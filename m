From: Caleb Crome <caleb@crome.org>
Subject: Re: fsl_ssi.c: Getting channel slips with fsl_ssi.c in
 TDM (network) mode.
Date: Thu, 29 Oct 2015 15:23:41 -0700
Message-ID: <CAG5mAdzJ2_MizAq2ACXwnA=wfO=xujGbUdB2OvcDi=7fHQfyBQ@mail.gmail.com>
References: <56273F75.2040702@invoxia.com>
 <CAG5mAdxDmh3XDZSSHb8Oa7s-rosdVvTZPqu2zyDC42rMcqxxHA@mail.gmail.com>
 <CAG5mAdwC00qbu9zMHKjx5JZX_2CobBo81+jtpsWGPHPQ0jKX0A@mail.gmail.com>
 <20151027071344.GC25728@pengutronix.de> <20151027201101.GA9527@Asurada-CZ80>
 <CAG5mAdz=TKSmXBOqKfSj0FYfk3c6syBa87OazyGRRF0NU4snXA@mail.gmail.com>
 <20151029045350.GA3374@Asurada-CZ80>
 <CAG5mAdwQd3ep7ZSNHDEni6caKeFPyvXhM0g=BjqPFA_gDSU1DQ@mail.gmail.com>
 <20151029171936.GA3492@Asurada-CZ80>
 <CAG5mAdzci2hPUBzFo+k3+CorfzQZD9_knQ2TXw1db1KoBL5Eyw@mail.gmail.com>
 <20151029192816.GA43706@Asurada-CZ80>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com
 [209.85.212.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 334BC2651A5
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 23:24:01 +0100 (CET)
Received: by wicll6 with SMTP id ll6so54252981wic.1
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 15:24:00 -0700 (PDT)
In-Reply-To: <20151029192816.GA43706@Asurada-CZ80>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Markus Pargmann <mpa@pengutronix.de>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Roberto Fichera <kernel@tekno-soft.it>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 29, 2015 at 12:28 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> On Thu, Oct 29, 2015 at 12:06:16PM -0700, Caleb Crome wrote:
>
>> This actually is exactly what I'm seeing now.  I'm seeing the
>> *startup* happening from the trigger starting up slipped.  So this
>> does make perfect sense to me.
>
> I saw your problem in the other reply. And I suggested you to let
> DMA work first before SSI gets enabled. As SDMA in that case would
> transfer one burst length (16 if you applied my patch I sent you)
> and pause before SSI gets enabled. Then SSI would have enough data
> to send out without any startup issue.

Ah ha, you are exactly right.  The root cause is that TE and SSIE are
enabled at the same regmap write, with no opportunity for delay
between the SSIE and TE.
DMA can only get going if SSIE is enabled, and the only place SSIE
gets enabled is exactly the same line that TE gets enabled.

specifically: regmap_update_bits(regs, CCSR_SSI_SCR, vals->scr, vals->scr);

I've looked over your emails and I don't see the patch that shows a
pause between SSIE enable and TE enable.  (I do see the dual-fifo
example -- thank you!  I'll give that a try -- it may further reduce
stress on the system).

Here is a patch that solves the issue much more elegantly than my previous one:
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 73778c2..0bb5e52 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -435,8 +475,27 @@ static void fsl_ssi_config(struct fsl_ssi_private
*ssi_private, bool enable,

 config_done:
     /* Enabling of subunits is done after configuration */
-    if (enable)
+    if (enable) {
+        /*
+         * don't enable TE/RE and SSIEN at the same time.
+         * enable SSIEN, but delay enabling of TE to
+         * allow time for DMA buffer to fill.
+         */
+        u32 mask = vals->scr & ~CCSR_SSI_SCR_TE;
+        if (mask != vals->scr) {
+            /* enabling TE in this call.  don't enable it
+             * until some delay after SSIE gets
+             * enabled. */
+            if (vals->scr & ~CCSR_SSI_SCR_TE) {
+                regmap_update_bits(regs, CCSR_SSI_SCR,
+                           mask, vals->scr);
+                udelay(50); /* give the DMA a chance
+                         * to fill the TX buffer
+                         * after SSIE is enabled. */
+            }
+        }
         regmap_update_bits(regs, CCSR_SSI_SCR, vals->scr, vals->scr);
+    }
 }


>
>> It occurred to me that perhaps the problem has to do when exactly when
>> during the frame-sync period the fsl_ssi_trigger function was called.
>> Perhaps, if it's called near the end or beginning of a frame, somehow
>
> I don't know how you measured if it's before of after. But the frame
> should not start until trigger() gets call -- more clearly SSIEN and
> TE get enabled. From my point of view, you problem should be caused
> by SSI getting enabled without enough data in the FIFO. And that's
> what I just described in the previous paragraph and previous reply.

Yep, that sure seems to be it.  This patch above never seems to have a
bad start.
Is adding the udelay the best way to put a delay between SSIE and TE enable?
Are there any other mechanisms for that?

Thanks so much for your attention and help!  I think I can finally
move forward with the MX6 on a bunch of projects now :-)

(well, I still have to test Rx and verify full dulex perfection there
too, but this is a great start)

-Caleb
