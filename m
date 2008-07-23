From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: dapm_reg_event, etc
Date: Wed, 23 Jul 2008 15:34:38 -0400
Message-ID: <9e4733910807231234r10ae0b5erb6044667c0cb090@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.153])
	by alsa0.perex.cz (Postfix) with ESMTP id AE79624811
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jul 2008 21:34:39 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so1140917ywk.2
	for <alsa-devel@alsa-project.org>; Wed, 23 Jul 2008 12:34:38 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I modified Kconfig to build all of the codecs. That exposed a couple
more errors.

tlv320aic3x won't build . dapm_reg_event() is missing from soc_dapm.h:

/* generic register modifier widget */
#define SND_SOC_DAPM_REG(wid, wname, wreg, wshift, wmask, won_val, woff_val) \
{	.id = wid, .name = wname, .kcontrols = NULL, .num_kcontrols = 0, \
	.reg = -((wreg) + 1), .shift = wshift, .mask = wmask, \
	.on_val = won_val, .off_val = woff_val, .event = dapm_reg_event, \
	.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD}

int dapm_reg_event(struct snd_soc_dapm_widget *w,
                   struct snd_kcontrol *kcontrol, int event);

and there is another error in my patch:

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 41e73fc..cc64b04 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -67,7 +67,7 @@
        .info = snd_soc_info_volsw, .get = snd_soc_get_volsw, \
        .put = snd_soc_put_volsw, \
        .private_value = (unsigned long)&(struct soc_mixer_control) \
-               {.reg = xreg, .shift = shift_left, .rshift = right_shift, \
+               {.reg = xreg, .shift = shift_left, .rshift = shift_right, \
                 .max = xmax, .invert = xinvert} }
 #define SOC_DOUBLE_R_TLV(xname, reg_left, reg_right, xshift, xmax,
xinvert, tlv_array) \
 {      .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\

And the AC97 codec won't link, not sure why.

sound/built-in.o: In function `ac97_read':
ac97.c:(.text+0x2513a): undefined reference to `soc_ac97_ops'
ac97.c:(.text+0x25146): undefined reference to `soc_ac97_ops'
sound/built-in.o: In function `ac97_write':
ac97.c:(.text+0x2516e): undefined reference to `soc_ac97_ops'
ac97.c:(.text+0x2517e): undefined reference to `soc_ac97_ops'
sound/built-in.o: In function `ac97_soc_probe':
ac97.c:(.text+0x252f6): undefined reference to `soc_ac97_ops'
sound/built-in.o:ac97.c:(.text+0x25302): more undefined references to
`soc_ac97_ops' follow
make: *** [.tmp_vmlinux1] Error 1
jonsmirl@terra:~/fs$ make

I'll make a new version and put these fixes into it. I'll also make a
patch for a Kconfig option to force all of the codecs to build.

-- 
Jon Smirl
jonsmirl@gmail.com
