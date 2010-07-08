From: Timur Tabi <timur@freescale.com>
Subject: wm8776_dai vs. cs4270_dai
Date: Thu, 08 Jul 2010 17:59:44 -0500
Message-ID: <4C365860.9080205@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 4AEF51038D5
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Jul 2010 00:59:52 +0200 (CEST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o68Mxj3b001234
	for <alsa-devel@alsa-project.org>; Thu, 8 Jul 2010 15:59:49 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o68NAGmP023053
	for <alsa-devel@alsa-project.org>; Thu, 8 Jul 2010 18:10:16 -0500 (CDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark,

In wm8776.c, the DAI structure is defined as an array of two elements, one
for playback and one for capture:

struct snd_soc_dai_driver wm8776_dai[] = {
	{
		.name = "WM8776 Playback",
		.playback = {
			.stream_name = "Playback",
			.channels_min = 2,
			.channels_max = 2,
			.rates = WM8776_RATES,
			.formats = WM8776_FORMATS,
		},
		.ops = &wm8776_dac_ops,
	},
	{
		.name = "WM8776 Capture",
		.capture = {
			.stream_name = "Capture",
			.channels_min = 2,
			.channels_max = 2,
			.rates = WM8776_RATES,
			.formats = WM8776_FORMATS,
		},
		.ops = &wm8776_adc_ops,
	},
};

In my CS4270 driver, I have these combined into one structure:

struct snd_soc_dai_driver cs4270_dai = {
	.name = "cs4270",
	.playback = {
		.stream_name = "Playback",
		.channels_min = 1,
		.channels_max = 2,
		.rates = SNDRV_PCM_RATE_CONTINUOUS,
		.rate_min = 4000,
		.rate_max = 216000,
		.formats = CS4270_FORMATS,
	},
	.capture = {
		.stream_name = "Capture",
		.channels_min = 1,
		.channels_max = 2,
		.rates = SNDRV_PCM_RATE_CONTINUOUS,
		.rate_min = 4000,
		.rate_max = 216000,
		.formats = CS4270_FORMATS,
	},
	.ops = &cs4270_dai_ops,
};

Should the CS4270 driver be changed to use two structures?
