From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: twl4030: runtime audio capture channel swapping
	(kernel 3.18+)
Date: Fri, 12 Aug 2016 12:53:09 +0300
Message-ID: <9ad5dc76-177b-4aa5-b523-4705af436ac7@ti.com>
References: <CALHzX6rsFSFbER6f8mEyiyOMS4S=ErargBbMLL93fpYsRMkW1A@mail.gmail.com>
 <64bcc44e-3058-01b5-3402-d140448f3add@ti.com>
 <CALHzX6qqiDk=+d=zPU8f=ntc0KqNC2xcuRwAS+Lqj+SwdLee-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------E3C1A8618657B4E3D76C25BE"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [198.47.19.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 80C5E267048
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2016 11:53:14 +0200 (CEST)
In-Reply-To: <CALHzX6qqiDk=+d=zPU8f=ntc0KqNC2xcuRwAS+Lqj+SwdLee-g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Akram Hameed <akramh@aq1systems.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

--------------E3C1A8618657B4E3D76C25BE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Akram,

first of all: I'm able to reproduce the RX underflow :o

On 08/12/16 04:14, Akram Hameed wrote:
>> > 2) McBSP2 is also configured the same between old and new kernels, though I
>> > note for some reason the ID pulled by dev_dbg looks spurious, though I guess
>> > unrelated to my issue.
>> > Configuring McBSP255  phys_base: 0x49022000
>> > **** McBSP255 regs ****
>> > DRR2:  0xf88a
>> > DRR1:  0x0000
>> > DXR2:  0x0000
>> > DXR1:  0x0000
>> > SPCR2: 0x0230
>> > SPCR1: 0x0031
>> > RCR2:  0x8041
>> > RCR1:  0x0040
>> > XCR2:  0x8041
>> > XCR1:  0x0040
>> > SRGR2: 0x001f
>> > SRGR1: 0x0f00
>> > PCR0:  0x000f
>> > ***********************
>>
>> We must drop the DRR1/2 (and probably DXR1/2) dump... By reading the DRR
>> register with the debug code we introduce underflow. The data must be only
>> moved by the DMA from the DATA registers. If we have low threshold it is more
>> likely to cause channel swap and it is for sure going to introduce missing
>> data - the data is going to the kernel log instead of the receive buffer.
> 
> For what it is worth, I had to enable that register dump with
> dynamic_debug/control, so I guess it is not being used in normal operation.

Yeah, it is only dumped on start, but still it is not a good thing as it can
introduce initial channel swap.

>> I can not recall the history, but between 3.0 and 3.18 we might moved to
>> dmaengine based PCM for OMAPs. But I still have no recollection to experience
>> capture side channel swap.
> 
> I have found that absolutely the pcm was moved to dmaengine around 3.7. I
> hazard a guess my problem would not be present prior to that, but I have no
> evidence.  The hardware manufacturers we use have a kernel patched for their
> specific use of OMAP3530/DM3730 at version 3.5 that I can try and verify if
> capture had issues at that time.

I have looked back at the history and nothing stands out. We are adding
SRC/DST_PACKED in sDMA, but if I remove that, it makes no difference.

Even if I enable real element mode, I can still see the underflows.

>> > a) Swap definitely is happening due to Overflow, but so far I only observe an
>> > overflow when using dma_op_mode THRESHOLD. When using dma_op_mode THRESHOLD,
>> > the swap does not seem to coincide with an underflow, so I am at a loss to
>> > explain further.
>>
>> How does you application works? What are the parameters ALSA is configured for
>> capture/playback (cat /proc/asound/card0/pcm0p/sub0/hw_params; cat
>> /proc/asound/card0/pcm0c/sub0/hw_params) - number of periods, etc?
> 
> Our application accesses ALSA via a C++ wrapper
> (RtAudio: https://www.music.mcgill.ca/~gary/rtaudio/). We capture audio only
> (48kHz, 2ch), and do not play back during these capture sessions. Capture is
> done in a background thread and double buffering is used at the application
> level so the 'audio ready' callback does not block longer than strictly
> necessary to service incoming data. As mentioned in a previous email, this
> approach has worked flawlessly before in kernel 3.0.
> 
> ALSA buffer size is not particularly large, perhaps it might help for me to
> increase the number of ALSA buffers? Here are the hw_params:
> 
> cat /proc/asound/card0/pcm0c/sub0/hw_params
> access: RW_INTERLEAVED
> format: S16_LE
> subformat: STD
> channels: 2
> rate: 48000 (48000/1)
> period_size: 480
> buffer_size: 960

I found no correlation between the ALSA settings and the frequency of the
McBSP underruns.

> 
> And of course, playback is not operating:
> 
> cat /proc/asound/card0/pcm0p/sub0/hw_params 
> closed
> 
>> > b) In dma_op_mode ELEMENT, I get Underflow reported almost every second in
>> > this newer kernel (again, using 10ms period size). Channel swap only seems to
>> > occur ever few hours, however, and I do not believe I have observed the
>> > overflow at all in ELEMENT mode. So, the swap occurs due to underflow, maybe?
>>
>> Underflow in McBSP or Underflow by ALSA?
>>
>> Underflow in McBSP RX tells that DMA is trying to read data when the FIFO is
>> empty. This can only happen if something else is reading data also from the
>> McBSP since we configure the McBSP and sDMA in sync.
> 
> The underflow I observe is a McBSP one. I am not receiving any from ALSA. Here
> is some dmesg output (dma_op_mode == element, alsa hw_params same as above):
> [  831.852416] omap-mcbsp 49022000.mcbsp: RX Buffer Underflow!
> [  835.450286] omap-mcbsp 49022000.mcbsp: RX Buffer Underflow!
> [  837.221862] omap-mcbsp 49022000.mcbsp: RX Buffer Underflow!
> 
> I enabled these underflow messages in omap_mcbsp_config in
> sound/soc/omap/mcbsp.c for curiosity's sake, but as you can see...they occur
> quite often. I am not sure what else might be accessing the DRR: it almost
> looks like the 'McBSP2.MCBSPLP_RQSTATUS_REG[3] RRDY' interrupt might be fired
> for DMA transfer too often to generate this message? The spruf98p manual says
> on page 2979: 'happens only if the MPU/IVA2.2 subsystem or sDMA controller
> does not respect the DMA length, does not wait for DMA request, or does not
> check the buffer status before reading data.'
> 
> How to fix it, I am not sure, but absolutely by using threshold mode in
> dma_op_mode, I get far less frequent underflow.

I can think of two causes:
1. sDMA for some reason issues an extra read, there might be an ERRATA for
this? I can try to check the sDMA erratas.
2. McBSP issues extra DMA request out of blue and that forces sDMA to read?
Have not heard anything like that, but can check the erratas for McBSP. It
could be that the threshold handling is having some issues in McBSP?

>> Overflow in McBSP happens when DAM is failing to read the data out from McBSP
>> FIFO in time - FIFO is full and McBSP discards the incoming data)
>>
>> ALSA underflow is different, it happens when the application fails to process
>> the period in time and the DMA starts to rewrite the buffer. This happens when
>> you have one thread to capture/process/play. If the process/play takes more
>> time than we go round in the boffer (buffer time) we have ALSA underflow. You
>> can try to increase the number of periods or separate the capture and
>> process/play jobs into separate threads.
>>
>> > My plan from now is to get my JTAG up and running and try and make the change
>> > "If you are working with 16-bit stereo data a nice solution is to configure
>> > the McBSP for a single 32-bit element instead of 2 16-bit elements. "
>>
>> The McBSP driver does not have support for this ATM. There is a side effect of
>> this AFAIK: channels will be swapped, but I have not tested it.
>> Using 32bit element instead of 2x16bit helps in case when you do not have FIFO
>> for sure to give more time for the DMA. Also in case of underrun/overrun you
>> will be loosing both channel's data so the swap would not happen.
> 
> This sounds like a fine solution for me in the interim: a permanent channel
> swap can be dealt with after data is received from ALSA.

I tried this (not too hard) but could not make it work for playback so capture
could be broken as well with this hack.

Couple of interesting details (I'm running my tests on top of linux-next):
In element mode we have the underruns coming in steady pace, but if I do dmesg
over the serial console (which is also using DMA nowdays) the underruns in
audio got increased. In threshold mode we have less underruns, but again dmesg
on serial will generate lots of underruns :o

Out of curiosity I have checked how things are when McBSP is master on the
bus. I see no underruns at all. Even if I do the dmesg on serial. This is
something I don't really understand atm.
For reference I have attached my local patch on top of linux-next for the
omap-twl4030 machine driver to create the PCM for McBSP master configuration.

If I:
arecord -Dplughw:0,0 -f dat --period-size=480 --buffer-size=960 > /dev/null

I see underruns

but:
arecord -Dplughw:0,1 -f dat --period-size=480 --buffer-size=960 > /dev/null

I see no underruns

:0,0 is the McBSP slave, :0,1 is when McBSP is master.

Can you look at the patch and see if you could get the McBSP master mode
working on your setup and test it?

-- 
Péter

--------------E3C1A8618657B4E3D76C25BE
Content-Type: text/x-patch;
	name="0001-ASoC-omap-twl4030-Add-CxS-HiFi-configuration-for-tes.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename*0="0001-ASoC-omap-twl4030-Add-CxS-HiFi-configuration-for-tes.pa";
	filename*1="tch"

=46rom f42a4cc3e9f01d5f7985e0ea2a970b365c61a8c4 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Fri, 5 Sep 2014 09:59:09 +0300
Subject: [PATCH] ASoC: omap-twl4030: Add CxS HiFi configuration for testi=
ng

hw:0,0 - McBSP2 slave, twl4030 master
hw:0,1 - McBSP2 master, twl4030 slave
hw:0,2 - If enabled voice port

For testing purpioses.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-twl4030.c | 109 ++++++++++++++++++++++++++++++++++++=
++++--
 1 file changed, 105 insertions(+), 4 deletions(-)

diff --git a/sound/soc/omap/omap-twl4030.c b/sound/soc/omap/omap-twl4030.=
c
index 743131473056..b07d15b59007 100644
--- a/sound/soc/omap/omap-twl4030.c
+++ b/sound/soc/omap/omap-twl4030.c
@@ -39,6 +39,7 @@
=20
 #include <sound/core.h>
 #include <sound/pcm.h>
+#include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/jack.h>
=20
@@ -49,11 +50,15 @@ struct omap_twl4030 {
 	struct snd_soc_jack hs_jack;
 };
=20
+/* McBSP2 slave, TWL4030 master */
 static int omap_twl4030_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
+	struct snd_soc_dai *cpu_dai =3D rtd->cpu_dai;
+	struct snd_soc_card *card =3D rtd->card;
 	unsigned int fmt;
+	int ret;
=20
 	switch (params_channels(params)) {
 	case 2: /* Stereo I2S mode */
@@ -70,6 +75,14 @@ static int omap_twl4030_hw_params(struct snd_pcm_subst=
ream *substream,
 		return -EINVAL;
 	}
=20
+	/* Set McBSP clock to PER_96M_FCLK */
+	ret =3D snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_SYSCLK_CLKS_FCLK,
+				     96000000, SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(card->dev, "can't set cpu system clock\n");
+		return ret;
+	}
+
 	return snd_soc_runtime_set_dai_fmt(rtd, fmt);
 }
=20
@@ -77,6 +90,81 @@ static struct snd_soc_ops omap_twl4030_ops =3D {
 	.hw_params =3D omap_twl4030_hw_params,
 };
=20
+/* McBSP2 master, TWL4030 slave */
+static int omap_twl4030_slave_hw_params(struct snd_pcm_substream *substr=
eam,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
+	struct snd_soc_dai *codec_dai =3D rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai =3D rtd->cpu_dai;
+	struct snd_soc_card *card =3D rtd->card;
+	int channels =3D params_channels(params);
+	int wlen;
+	unsigned int fmt;
+	int ret;
+
+	switch (channels) {
+	case 2: /* Stereo I2S mode */
+		fmt =3D	SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBS_CFS;
+		break;
+	case 4: /* Four channel TDM mode */
+		fmt =3D	SND_SOC_DAIFMT_DSP_A |
+			SND_SOC_DAIFMT_IB_NF |
+			SND_SOC_DAIFMT_CBS_CFS;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		wlen =3D 16;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		wlen =3D 32;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Set codec DAI configuration */
+	ret =3D snd_soc_runtime_set_dai_fmt(rtd, fmt);
+	if (ret < 0) {
+		dev_err(card->dev, "can't set DAI configuration\n");
+		return ret;
+	}
+
+	/* Set the codec system clock for DAC and ADC */
+	ret =3D snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
+				     SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(card->dev, "can't set codec system clock\n");
+		return ret;
+	}
+
+	/* Set McBSP clock to external (CLKS) */
+	ret =3D snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_SYSCLK_CLKS_EXT,
+				     256 * params_rate(params),
+				     SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(card->dev, "can't set cpu system clock\n");
+		return ret;
+	}
+
+	ret =3D snd_soc_dai_set_clkdiv(cpu_dai, OMAP_MCBSP_CLKGDV,
+				     (256 / (wlen * channels)));
+	if (ret < 0)
+		dev_err(card->dev, "can't set SRG clock divider\n");
+
+	return 0;
+}
+
+static struct snd_soc_ops omap_twl4030_slave_ops =3D {
+	.hw_params =3D omap_twl4030_slave_hw_params,
+};
+
 static const struct snd_soc_dapm_widget dapm_widgets[] =3D {
 	SND_SOC_DAPM_SPK("Earpiece Spk", NULL),
 	SND_SOC_DAPM_SPK("Handsfree Spk", NULL),
@@ -223,8 +311,8 @@ static int omap_twl4030_card_remove(struct snd_soc_ca=
rd *card)
 /* Digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link omap_twl4030_dai_links[] =3D {
 	{
-		.name =3D "TWL4030 HiFi",
-		.stream_name =3D "TWL4030 HiFi",
+		.name =3D "TWL4030 HiFi CxM",
+		.stream_name =3D "TWL4030 HiFi CxM",
 		.cpu_dai_name =3D "omap-mcbsp.2",
 		.codec_dai_name =3D "twl4030-hifi",
 		.platform_name =3D "omap-mcbsp.2",
@@ -233,6 +321,15 @@ static struct snd_soc_dai_link omap_twl4030_dai_link=
s[] =3D {
 		.ops =3D &omap_twl4030_ops,
 	},
 	{
+		.name =3D "TWL4030 HiFi CxS",
+		.stream_name =3D "TWL4030 HiFi CxS",
+		.cpu_dai_name =3D "omap-mcbsp.2",
+		.codec_dai_name =3D "twl4030-hifi",
+		.platform_name =3D "omap-mcbsp.2",
+		.codec_name =3D "twl4030-codec",
+		.ops =3D &omap_twl4030_slave_ops,
+	},
+	{
 		.name =3D "TWL4030 Voice",
 		.stream_name =3D "TWL4030 Voice",
 		.cpu_dai_name =3D "omap-mcbsp.3",
@@ -286,14 +383,18 @@ static int omap_twl4030_probe(struct platform_devic=
e *pdev)
 			return -EINVAL;
 		}
 		omap_twl4030_dai_links[0].cpu_dai_name  =3D NULL;
+		omap_twl4030_dai_links[1].cpu_dai_name  =3D NULL;
 		omap_twl4030_dai_links[0].cpu_of_node =3D dai_node;
+		omap_twl4030_dai_links[1].cpu_of_node =3D dai_node;
=20
 		omap_twl4030_dai_links[0].platform_name  =3D NULL;
+		omap_twl4030_dai_links[1].platform_name  =3D NULL;
 		omap_twl4030_dai_links[0].platform_of_node =3D dai_node;
+		omap_twl4030_dai_links[1].platform_of_node =3D dai_node;
=20
 		dai_node =3D of_parse_phandle(node, "ti,mcbsp-voice", 0);
 		if (!dai_node) {
-			card->num_links =3D 1;
+			card->num_links =3D 2;
 		} else {
 			omap_twl4030_dai_links[1].cpu_dai_name  =3D NULL;
 			omap_twl4030_dai_links[1].cpu_of_node =3D dai_node;
@@ -324,7 +425,7 @@ static int omap_twl4030_probe(struct platform_device =
*pdev)
 		}
=20
 		if (!pdata->voice_connected)
-			card->num_links =3D 1;
+			card->num_links =3D 2;
=20
 		priv->jack_detect =3D pdata->jack_detect;
 	} else {
--=20
2.9.2


--------------E3C1A8618657B4E3D76C25BE
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------E3C1A8618657B4E3D76C25BE--
