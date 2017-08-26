From: Donglin Peng <dolinux.peng@gmail.com>
Subject: Re: [PATCH v2] ASoC: Add a sanity check before using dai driver name
Date: Sat, 26 Aug 2017 23:09:49 +0800
Message-ID: <CAErzpmupMr=RZj4yDni3xEp-f+fLBJ2KqnD8GcarMmGOH0JxXg@mail.gmail.com>
References: <20170824033411.5788-1-jeffy.chen@rock-chips.com> <201708262141.5hey2M3k%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201708262141.5hey2M3k%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>, kbuild-all@01.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, tiwai@suse.de, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Sat, Aug 26, 2017 at 10:13 PM, kbuild test robot <lkp@intel.com> wrote:
> Hi Jeffy,
>
> [auto build test ERROR on asoc/for-next]
> [also build test ERROR on next-20170825]
> [cannot apply to v4.13-rc6]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Jeffy-Chen/ASoC-Add-a-sanity-check-before-using-dai-driver-name/20170826-195851
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> config: x86_64-randconfig-it0-08261958 (attached as .config)
> compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
>
> All error/warnings (new ones prefixed by >>):
>
>    sound//soc/soc-core.c: In function 'snd_soc_find_dai':
>>> sound//soc/soc-core.c:4321:0: error: unterminated argument list invoking macro "if"
>     MODULE_ALIAS("platform:soc-audio");
>     ^
>>> sound//soc/soc-core.c:1031:4: error: expected '(' at end of input
>        if (dlc->dai_name && strcmp(dai->name, dlc->dai_name)
>        ^

It seems that the v3 patch should be applied other than v2.
