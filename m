From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH V4 2/5] Main rewite of the mpc5200 audio
	DMA code
Date: Tue, 26 May 2009 12:53:07 -0400
Message-ID: <9e4733910905260953i6337f8a9xc3cd1ff490cd3540@mail.gmail.com>
References: <20090525221406.21370.30326.stgit@terra>
	<20090525221509.21370.70182.stgit@terra>
	<20090526110120.GA8969@sirena.org.uk>
	<fa686aa40905260951g5115007fo3ef5eb1fb90998f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B64E1038D3
	for <alsa-devel@alsa-project.org>;
	Tue, 26 May 2009 18:53:10 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id k29so1111108rvb.32
	for <alsa-devel@alsa-project.org>; Tue, 26 May 2009 09:53:08 -0700 (PDT)
In-Reply-To: <fa686aa40905260951g5115007fo3ef5eb1fb90998f3@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, timur@freescale.com
List-Id: alsa-devel@alsa-project.org

On Tue, May 26, 2009 at 12:51 PM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> On Tue, May 26, 2009 at 5:01 AM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> On Mon, May 25, 2009 at 06:15:09PM -0400, Jon Smirl wrote:
>>> Rewrite the mpc5200 audio DMA code to support both I2S and AC97.
>>>
>>> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
>>
>> Grant, I'm OK with that if you are?
>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>

Put in the V5 version this one has this in the h file:

-int psc_dma_trigger(struct snd_pcm_substream *substream, int cmd,
-                          struct snd_soc_dai *dai);
+/* whack this after Timur's patch is merged in to
arch/powerpc/include/asm/delay.h */
+#define spin_event_timeout(condition, timeout, delay, rc)                   \
+{                                                                           \
+       unsigned long __loops = tb_ticks_per_usec * timeout;                \
+       unsigned long __start = get_tbl();                                  \
+       while ((rc = (condition)) && (tb_ticks_since(__start) <= __loops)) \
+               if (delay)                                                  \
+                       udelay(delay);                                      \
+               else                                                        \
+                       cpu_relax();                                        \
+}
+/* whack this after Timur's patch is merged in to
arch/powerpc/include/asm/delay.h */




>
>
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>



-- 
Jon Smirl
jonsmirl@gmail.com
