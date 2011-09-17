From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Noise using pulseaudio with ymf724f
Date: Sat, 17 Sep 2011 15:43:45 +0800
Message-ID: <CAN8cciZv4S180zKAJT73e-3nSan8NK4toWszTABqqvTwuq3yCg@mail.gmail.com>
References: <CAN8ccibqYPovEn=M9b-x4ZjqM3U9DwKnJtyDUKGoos-C2WBVXg@mail.gmail.com>
	<4E706E5E.2020602@ladisch.de>
	<CAN8cciZeXCiptD6MfJg1DZyUeReTEDz+hPVK9jMMnsXJi5uLPQ@mail.gmail.com>
	<4E72F411.4060302@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 813C6244B4
	for <alsa-devel@alsa-project.org>;
	Sat, 17 Sep 2011 09:43:47 +0200 (CEST)
Received: by fxe22 with SMTP id 22so2424202fxe.38
	for <alsa-devel@alsa-project.org>; Sat, 17 Sep 2011 00:43:46 -0700 (PDT)
In-Reply-To: <4E72F411.4060302@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/9/16 Clemens Ladisch <clemens@ladisch.de>:
> Raymond Yau wrote:
>> 2011/9/14 Clemens Ladisch <clemens@ladisch.de>:
>> > A block in the native format has 1024 bytes.
>>
>> Do you mean hardware pointer is only updated every 5.333ms ?
>
> Yes.
>
>

The noise can also be reproduced by change the value of the hw ptr of
hda-intel with 0xffffff00 so that it provide an less accurate pointer
position



diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 2a8bed9..0ef368d 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1574,8 +1574,8 @@ static struct snd_pcm_hardware azx_pcm_hw = {
 				 /* No full-resume yet implemented */
 				 /* SNDRV_PCM_INFO_RESUME |*/
 				 SNDRV_PCM_INFO_PAUSE |
-				 SNDRV_PCM_INFO_SYNC_START |
-				 SNDRV_PCM_INFO_NO_PERIOD_WAKEUP),
+				 SNDRV_PCM_INFO_SYNC_START /* |
+				 SNDRV_PCM_INFO_NO_PERIOD_WAKEUP */),
 	.formats =		SNDRV_PCM_FMTBIT_S16_LE,
 	.rates =		SNDRV_PCM_RATE_48000,
 	.rate_min =		48000,
@@ -1639,6 +1639,8 @@ static int azx_pcm_open(struct snd_pcm_substream
*substream)
 				   buff_step);
 	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
 				   buff_step);
+	snd_pcm_hw_constraint_minmax(runtime,
SNDRV_PCM_HW_PARAM_PERIOD_TIME, 5333, UINT_MAX);
+	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_PERIODS, 3, 1024);
 	snd_hda_power_up(apcm->codec);
 	err = hinfo->ops.open(hinfo, apcm->codec, substream);
 	if (err < 0) {
@@ -1986,7 +1988,7 @@ static snd_pcm_uframes_t azx_pcm_pointer(struct
snd_pcm_substream *substream)
 	struct azx *chip = apcm->chip;
 	struct azx_dev *azx_dev = get_azx_dev(substream);
 	return bytes_to_frames(substream->runtime,
-			       azx_get_position(chip, azx_dev));
+			       azx_get_position(chip, azx_dev)) & 0xffffff00;
 }

 /*
-- 
1.6.0.6
