From: Donglin Peng <dolinux.peng@gmail.com>
Subject: Re: [PATCH v2 03/10] ASoC: Intel: Remove unnecessary function call
Date: Mon, 28 Aug 2017 10:20:52 +0800
Message-ID: <CAErzpmvHOfqrM-ArGr=q69nZtAvU-DQ6mOUDxEO=aeByn_ZWCQ@mail.gmail.com>
References: <cover.1503484313.git.dolinux.peng@gmail.com> <63f080c9ef444ef32486914be97ed5f8c8c55d9f.1503484313.git.dolinux.peng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <63f080c9ef444ef32486914be97ed5f8c8c55d9f.1503484313.git.dolinux.peng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Peng Donglin <dolinux.peng@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Wed, Aug 23, 2017 at 8:19 PM, Peng Donglin <dolinux.peng@gmail.com> wrote:
> The work of the function platform_set_drvdata is done by
> devm_snd_soc_register_card.
>
> Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
> ---
>
> Changes in v2:
> -add missed occurrences.
>
>  sound/soc/intel/boards/bytcht_da7213.c       | 6 ++----
>  sound/soc/intel/boards/bytcht_es8316.c       | 6 ++----
>  sound/soc/intel/boards/bytcht_nocodec.c      | 6 ++----
>  sound/soc/intel/boards/bytcr_rt5640.c        | 7 ++-----
>  sound/soc/intel/boards/bytcr_rt5651.c        | 7 ++-----
>  sound/soc/intel/boards/cht_bsw_max98090_ti.c | 6 ++----
>  sound/soc/intel/boards/cht_bsw_rt5645.c      | 6 ++----
>  sound/soc/intel/boards/cht_bsw_rt5672.c      | 6 ++----
>  8 files changed, 16 insertions(+), 34 deletions(-)
>

I found that this patch had not been applied, perhaps you missed it.
