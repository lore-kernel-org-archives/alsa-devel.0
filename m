From: Michele Curti <michele.curti@gmail.com>
Subject: Re: writing an alsa driver
Date: Thu, 4 Jun 2015 10:59:33 +0200
Message-ID: <20150604085933.GA8494@dellaz>
References: <20150527085440.GA4445@dellaz> <1432752116.8235.25.camel@loki>
 <20150527201320.GA309@asus> <1432812668.2726.18.camel@loki>
 <20150528125325.GA418@asus> <1432819294.2726.33.camel@loki>
 <20150528191721.GA608@asus> <1432892521.2732.14.camel@loki>
 <20150529131753.GA339@asus> <1433156768.2642.21.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
 [209.85.212.182])
 by alsa0.perex.cz (Postfix) with ESMTP id A0C9F26065C
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 10:59:38 +0200 (CEST)
Received: by wibdt2 with SMTP id dt2so41391035wib.1
 for <alsa-devel@alsa-project.org>; Thu, 04 Jun 2015 01:59:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1433156768.2642.21.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, "Nikula, Jarkko" <jarkko.nikula@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 01, 2015 at 12:06:08PM +0100, Liam Girdwood wrote:
> + Jarkko
> 
> On Fri, 2015-05-29 at 15:17 +0200, Michele Curti wrote:
> > On Fri, May 29, 2015 at 10:42:01AM +0100, Liam Girdwood wrote:
> > > On Thu, 2015-05-28 at 21:17 +0200, Michele Curti wrote:
> > > 
> > > > to let the probe continue, the system become quite unusable but I get the 
> > > > logs.
> > > > 
> > > > May 28 20:34:00 asus kernel: byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> > > > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: initialising Byt DSP IPC
> > > > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: initialising audio DSP id 0xf28
> > > > May 28 20:34:00 asus kernel: irq used for dsp = 6
> > > > 
> > > > ---> The IRQ number used is 6
> > > > 
> 
> Jarkko thinks the IRQ may be incorrectly reported by ACPI and that it
> could be using another ACPI index. This could probably be checked by
> decompiling the ACPi data and searching for the audio DSP.

Thanks, I'll try.

I'm back now from a period of limited internet access, I tried to change the
irqindex_host_ipc to 0 (like the others platforms)

diff --git a/sound/soc/intel/common/sst-acpi.c b/sound/soc/intel/common/sst-acpi.c
index 42f293f..7cc64e3 100644
--- a/sound/soc/intel/common/sst-acpi.c
+++ b/sound/soc/intel/common/sst-acpi.c
@@ -258,7 +258,7 @@ static struct sst_acpi_desc sst_acpi_baytrail_desc = {
 	.resindex_lpe_base = 0,
 	.resindex_pcicfg_base = 1,
 	.resindex_fw_base = 2,
-	.irqindex_host_ipc = 5,
+	.irqindex_host_ipc = 0,
 	.sst_id = SST_DEV_ID_BYT,
 	.resindex_dma_base = -1,
 };

and the sound card showed up.  So I tried to play a bit with alsamixer and got
some cracking noise.

Tried to play some songs but a song of 4 minutes finished in about a dozen of
seconds..  Maybe the clocks are not correctly configured..

After a while I smelt a smell of burnt components and the chassis near the
speakers was hot like hell.  Shutdown the laptop.

Now I'm not sure the hardware is damaged, after a couple of hours I tried to
reboot and got a (strange) beep during boot, so maybe I was lucky..

Anyway, now I removed the change.

> 
> > > > May 28 20:34:00 asus kernel: [101B blob data]
> > > > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x160 bytes at offset 0xc0000 type 0
> > > > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block allocated 0:0 at offset 0xc0000
> > > > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x170 bytes at offset 0xc0400 type 0
> > > > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x10 bytes at offset 0xc0578 type 0
> > > > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x10 bytes at offset 0xc0598 type 0
> > > > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x10 bytes at offset 0xc05b8 type 0
> > > > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x10 bytes at offset 0xc05d8 type 0
> > > > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x10 bytes at offset 0xc05f8 type 0
> > > > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x8 bytes at offset 0xc0618 type 0
> > > > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x10 bytes at offset 0xc0638 type 0
> > > > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x30 bytes at offset 0xc0658 type 0
> > > > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x10438 bytes at offset 0xc06a0 type 0
> > > > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block allocated 0:1 at offset 0xc8000
> > > > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block allocated 0:2 at offset 0xd0000
> > > > May 28 20:34:00 asus kernel: rt5645 i2c-10EC5648:00: Requesting IRQ 146
> > > > May 28 20:34:00 asus kernel: rt5645 i2c-10EC5648:00: Requesting gpio 0
> > > > May 28 20:34:00 asus kernel: rt5645 i2c-10EC5648:00: Fail gpio_request hp_det_gpio
> > > > May 28 20:34:00 asus kernel: gpiod_direction_input: invalid GPIO
> > > > May 28 20:34:00 asus kernel: rt5645 i2c-10EC5648:00: Fail gpio_direction hp_det_gpio
> > > > May 28 20:34:00 asus kernel: byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> > > > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x1a310 bytes at offset 0x400000 type 3
> > > > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x5738 bytes at offset 0x100010 type 1
> > > > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block allocated 1:0 at offset 0x100000
> > > > May 28 20:34:00 asus kernel: Linux video capture interface: v2.00
> > > > May 28 20:34:00 asus kernel: intel_rapl: Found RAPL domain package
> > > > May 28 20:34:00 asus kernel: intel_rapl: Found RAPL domain core
> > > > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x10ad8 bytes at offset 0x105750 type 1
> > > > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block allocated 1:1 at offset 0x108000
> > > > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block allocated 1:2 at offset 0x110000
> > > > May 28 20:34:00 asus kernel: byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> > > 
> > > 
> > > This is confusing as we can see messages about the baytrail-pcm-audio
> > > device not being registered and then valid messages from said device ?
> > > I'm wondering if you have created 2 baytrail-pcm-audio devices ? The
> > > ordering is also confusing since the block allocation should come before
> > > the DSP boot....
> > > 
> > > Can you paste the diff for all the audio changes you have made and also
> > > the output of lsmod when this happens.
> > >
> > 
> > Sure, sorry for the number of attachments.. :p
> 
> Ok, I can see something that might be causing the potential double
> registration of the PCM driver. Can you change the cpu_dai_name in your
> machine driver to "Baytrail PCM".

Will do, thanks,
Michele

> 
> Liam
> 
