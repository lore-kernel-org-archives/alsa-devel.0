From: Sangbeom Kim <sbkim73@samsung.com>
Subject: [PATCH V2 0/3] Add WM8580 PCM Machine driver for Samsung SoCs
Date: Sat,  9 Apr 2011 10:57:58 +0900
Message-ID: <1302314281-11466-1-git-send-email-sbkim73@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org
Cc: jassisinghbrar@gmail.com, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, kgene.kim@samsung.com, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org


Hi,

This is 2nd patchset for WM8580 pcm machine driver that supports
PCM audio on SMDKC110, SMDKV210, SMDK6450, SMDK6440.
and It is tested on SMDKC110, SMDKV210, SMDKV6450.

Changeds since v1:
 - Used snd_soc_register_card() for new machines
 - Modified Kconfig for useless config

Based on these patches WM8580 pcm machine driver supports followings:
 o Playback supports 8kHz sampling rates.
 o Capture supports 8kHz sampling rates.

This patchset contains followings 

 o To Kukjin Kim and Ben Dooks,
[PATCH 1/3] ARM: S5PV210: Add PCM audio support for WM8580
[PATCH 2/3] ARM: S5P64X0: Add PCM audio support for WM8580

 o To Jassi Brar, Mark Brown and Liam Girdwood,
[PATCH 3/3] ASoC: SAMSUNG: Add WM8580 PCM Machine driver 

Best Regards,
SB Kim (Sangbeom Kim)
