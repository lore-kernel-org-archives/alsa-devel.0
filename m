From: John Keeping <john@metanate.com>
Subject: Re: [PATCH 2/2] ASoC: Intel: boards: Add bdw-rt5677 machine driver
Date: Wed, 17 Aug 2016 17:20:24 +0100
Message-ID: <20160817172024.7cf93056.john@metanate.com>
References: <20160814111823.1782-1-john@metanate.com>
	<20160814111823.1782-3-john@metanate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160814111823.1782-3-john@metanate.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Zhang <benzh@chromium.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jie Yang <yang.jie@linux.intel.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

Hi Ben,

> diff --git a/sound/soc/intel/boards/bdw-rt5677.c b/sound/soc/intel/boards/bdw-rt5677.c
> @@ -0,0 +1,341 @@
> +/*
> + * ASoC machine driver for Intel Broadwell platforms with RT5677 codec
> + */

It has been pointed out to me that this file lacks a proper license
header; I pulled it from the chromeos-3.14 branch and I can't see a
version with a license header.

The module properties indicate GPLv2, but who should be the subject of
the copyright statement?


Thanks,
John
