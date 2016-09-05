From: John Keeping <john@metanate.com>
Subject: Re: [PATCH v2 0/2] ASoC: Chromebook Pixel 2015 audio support
Date: Mon, 5 Sep 2016 15:34:26 +0100
Message-ID: <20160905153426.72c1caeb.john@metanate.com>
References: <20160814111823.1782-1-john@metanate.com>
        <cover.1472071966.git.john@metanate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1472071966.git.john@metanate.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Jie Yang <yang.jie@linux.intel.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Ben Zhang <benzh@chromium.org>, Dylan Reid <dgreid@chromium.org>, Genki Marshall <genki@genki.is>, Tom Rini <trini@konsulko.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 24 Aug 2016 22:06:34 +0100, John Keeping wrote:

> This is the second version of the series originally posted here [1].
> 
> The second patch is largely unchanged and is still derived from the
> Chromium OS 3.14 source, but the patch to the codec driver now takes a
> different approach that I hope is easier to review as well resulting in
> less code.
> 
> [1] https://lkml.org/lkml/2016/8/14/207

Ping?  Is there anything I can do to help move this forward?

> John Keeping (2):
>   ASoC: rt5677: Add ACPI support
>   ASoC: Intel: boards: Add bdw-rt5677 machine driver
> 
>  sound/soc/codecs/rt5677.c           |  53 +++++-
>  sound/soc/intel/Kconfig             |  11 ++
>  sound/soc/intel/boards/Makefile     |   2 +
>  sound/soc/intel/boards/bdw-rt5677.c | 347 ++++++++++++++++++++++++++++++++++++
>  sound/soc/intel/common/sst-acpi.c   |   1 +
>  5 files changed, 413 insertions(+), 1 deletion(-)
>  create mode 100644 sound/soc/intel/boards/bdw-rt5677.c
> 
