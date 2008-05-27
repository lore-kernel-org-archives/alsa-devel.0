From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: ASOC, SPDIF and AC97
Date: Tue, 27 May 2008 14:16:54 -0400
Message-ID: <9e4733910805271116t1d36e769qaedfc0362b03e48d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by alsa0.perex.cz (Postfix) with ESMTP id 973772446B
	for <alsa-devel@alsa-project.org>;
	Tue, 27 May 2008 20:16:56 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m28so2456744wag.8
	for <alsa-devel@alsa-project.org>; Tue, 27 May 2008 11:16:55 -0700 (PDT)
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
To: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I'm back to working on an ASOC driver for the STAC9766 used in the
MPC5200 based Efika.

I'm having trouble with SPDIF. I can make two devices like this in the
codec file. But how do I get the SPDIF device hooked up to the right
AC97 slot, 10/11? Are any of the ASOC codecs implementing SPDIF?

I also see that the STAC9766 is missing an ac97_patch. From my reading
of the datasheet it needs somethings fixed up.

Does the ac97 support belong in the PCI directory? It took me a while
to locate it while working on ASOC. With a model more like ASOC
codecs, the AC97 patches could be pushed into the codec files.

static struct snd_soc_dai stac9766_dai[] = {
{
	.name	= "STAC9766-Analog",
	.id	= 0,
	
	/* stream cababilities */
	.playback = {
		.stream_name	= "STAC9766 Analog",
		.channels_min	= 1,
		.channels_max	= 6,
		.rates		= STAC9766_RATES,
		.formats	= SNDRV_PCM_FMTBIT_S16,
	},
	.capture = {
		.stream_name	= "STAC9766 Analog",
		.channels_min	= 1,
		.channels_max	= 2,
		.rates		= STAC9766_RATES,
		.formats	= SNDRV_PCM_FMTBIT_S16,
	},
	/* alsa ops */
	.prepare = ac97_analog_prepare,
},
{
	.name	= "stac9766-S/PDIF",
	.id	= 1,
	
	/* stream cababilities */
	.playback = {
		.stream_name	= "STAC9766 Digital",
		.channels_min	= 1,
		.channels_max	= 2,
		.rates		= STAC9766_RATES,
		.formats	= SNDRV_PCM_FMTBIT_S16,
	},
	/* alsa ops */
	.prepare = ac97_digital_prepare,
}};

-- 
Jon Smirl
jonsmirl@gmail.com
