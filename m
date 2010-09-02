From: "Brand, Mark (Mr) (Summerstrand Campus South)" <Mark.Brand@nmmu.ac.za>
Subject: Re: Turtle Beach Tahiti (snd-msnd-classic)
Date: Thu, 2 Sep 2010 11:52:53 +0200
Message-ID: <F5D2EA2BCBDF9247A489B479BEB484B60B02A46A93@sicily.nmmu.ac.za>
References: <F5D2EA2BCBDF9247A489B479BEB484B60B02A45910@sicily.nmmu.ac.za>
	<s5h7hj8nlc4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ra.nmmu.ac.za (ra.nmmu.ac.za [192.96.15.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 5026024633
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Sep 2010 11:52:20 +0200 (CEST)
In-Reply-To: <s5h7hj8nlc4.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: 'Takashi Iwai' <tiwai@suse.de>, "krzysztof.h1@wp.pl" <krzysztof.h1@wp.pl>
List-Id: alsa-devel@alsa-project.org

Dear Takashi and all,

Thank you.  After patching, snd-msnd-classic still complained about the unknown parameter 'cfg', and still assumed PnP mode without it.  I found the following at line 810:
        module_param_array(cfg, long, NULL, S_IRUGO);
I moved it outside of the #ifndef MSND_CLASSIC block (2 lines up) and bingo!  I now have audio, thanks again!

Now: output has a fairly regular, clearly audible click.  This is not really a problem for system sounds, but it makes listening to music impossible.  I know nothing about driver development, but would I be correct in suspecting that this is as a result of some kind of buffer size mismatch?  I can't investigate as extensively as I'd like right now, but I'll definitely take a closer look this weekend.  In the meantime, I'd greatly appreciate your comments.

Kind regards
Mark Brand.

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de]
Sent: 30 August 2010 05:59 PM
To: Brand, Mark (Mr) (Summerstrand Campus South)
Cc: alsa-devel@alsa-project.org; krzysztof.h1@wp.pl
Subject: Re: Turtle Beach Tahiti (snd-msnd-classic)

At Mon, 30 Aug 2010 16:59:46 +0200,
Brand, Mark (Mr) (Summerstrand Campus South) wrote:
>
> Thank you very much for responding.
>
> >> Loading the ALSA driver for a Turtle Beach Tahiti fails quietly, with the following anomalies:
> >> 1. dmesg says "Assuming PnP mode", despite isapnp=0 option
> >The message is confusing.  The isapnp is assumed silently also when no
> >cfg option is given.
>
> >> 3. Type: sudo modprobe snd-msnd-classic isapnp=0 io=0x3e0 irq=10 mem=0xd0000
> >Try to add cfg option value.  It's either 0x250, 0x260 or 0x270.
>
> modprobe snd-msnd-classic isapnp=0 cfg=0x250 io=0x3e0 irq=10 mem=0xd0000
>
> responds with:
> FATAL: Error inserting snd_msnd_classic (/lib/modules/2.6.32-24-generic/kernel/sound/isa/msnd/snd-msnd-classic.ko): Unknown symbol in module, or unknown parameter (see dmesg)
>
> dmesg says:
> snd_msnd_classic: Unknown parameter 'cfg'

Ah, right, it's only for pinnacle.

Try the patch below instead.


Takashi

---
diff --git a/sound/isa/msnd/msnd_pinnacle.c b/sound/isa/msnd/msnd_pinnacle.c
index 5f3e684..f80c37f 100644
--- a/sound/isa/msnd/msnd_pinnacle.c
+++ b/sound/isa/msnd/msnd_pinnacle.c
@@ -894,7 +894,11 @@ static int __devinit snd_msnd_isa_probe(struct device *pdev, unsigned int idx)
        struct snd_card *card;
        struct snd_msnd *chip;

-       if (has_isapnp(idx) || cfg[idx] == SNDRV_AUTO_PORT) {
+       if (has_isapnp(idx)
+#ifndef MSND_CLASSIC
+           || cfg[idx] == SNDRV_AUTO_PORT
+#endif
+           ) {
                printk(KERN_INFO LOGNAME ": Assuming PnP mode\n");
                return -ENODEV;
        }

NOTICE: Please note that this eMail, and the contents thereof, is subject to the standard NMMU eMail disclaimer which may be found at:
http://www.nmmu.ac.za/disclaimer/email.htm
