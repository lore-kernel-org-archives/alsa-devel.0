From: Donglin Peng <dolinux.peng@gmail.com>
Subject: Re: [PATCH v5 2/9] ASoC: soc-core: Allow searching dai driver name in snd_soc_find_dai
Date: Tue, 22 Aug 2017 22:15:32 +0800
Message-ID: <CAErzpmsg9fi0-ukHG13-dy2r02892h+oPXmtsusCbu-xLzazFQ@mail.gmail.com>
References: <20170822075729.8438-1-jeffy.chen@rock-chips.com>
 <20170822075729.8438-3-jeffy.chen@rock-chips.com> <CAErzpmtbbWbt28KPaFLVdwzuWy3A7se7_WBN8q6aJrHLbtT-LQ@mail.gmail.com>
 <20170822140255.t2wfwkjr67v3eoxu@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170822140255.t2wfwkjr67v3eoxu@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org, dgreid@chromium.org, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, briannorris@chromium.org, mengdong.lin@linux.intel.com, mka@chromium.org, lars@metafoo.de, dianders@chromium.org, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 22, 2017 at 10:02 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Aug 22, 2017 at 09:24:32PM +0800, Donglin Peng wrote:
>
>> In case that dai->driver->name is NULL, strcmp(dai->driver->name,
>> dlc->dai_name) will cause segmentation fault.
>> so I think that we can change it as the follows:
>
> We should be already verifying that drivers have a name, we assume one
> elsewhere.

But I can't find any codes that set or check dai_driver->name in
function snd_soc_register_codec or snd_soc_register_component.
