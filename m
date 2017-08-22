From: jeffy <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH v5 6/9] ASoC: rockchip: Parse dai links from dts
Date: Tue, 22 Aug 2017 17:25:05 +0800
Message-ID: <599BF871.8000408@rock-chips.com>
References: <20170822075729.8438-1-jeffy.chen@rock-chips.com> <20170822075729.8438-7-jeffy.chen@rock-chips.com> <CAErzpmsfgW47ezbUUVkqhdrca8Bwti3MMXWkBJDu_YDcow0vHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAErzpmsfgW47ezbUUVkqhdrca8Bwti3MMXWkBJDu_YDcow0vHw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: linux-kernel@vger.kernel.org, dgreid@chromium.org, =?UTF-8?B?SGVpa28g?= =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>, briannorris@chromium.org, mengdong.lin@linux.intel.com, mka@chromium.org, lars@metafoo.de, dianders@chromium.org, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Donglin,

On 08/22/2017 05:08 PM, Donglin Peng wrote:
>> >         card->dev = &pdev->dev;
>> >         platform_set_drvdata(pdev, card);
> There is no need to call platform_set_drvdata, because
> devm_snd_soc_register_card will do it.
>

right, will remove it in next version, thanks:)
