From: Donglin Peng <dolinux.peng@gmail.com>
Subject: Re: [PATCH v2] ASoC: use seq_file to dump the contents of
 dai_list,platform_list and codec_list
Date: Fri, 26 Jan 2018 15:16:00 +0800
Message-ID: <CAErzpmt5Z_bVkO-86yCNNWMNSYXWMzvABGtTEuYV1Y1qk=2LJQ@mail.gmail.com>
References: <20180118053126.22082-1-dolinux.peng@gmail.com>
 <CAHp75VcefO1L-E8ymHX7MibLiOXkRZ3+3FbkF_L+ywMV-i3Mvw@mail.gmail.com> <20180123173732.GI7600@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180123173732.GI7600@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 24, 2018 at 1:37 AM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jan 23, 2018 at 07:08:15PM +0200, Andy Shevchenko wrote:
>
>> If it's not critical, I would suggest to wait till v4.16-rc1, where I
>> would like to push [1], and switch to DEFINE_SHOW_ATTRIBUTE() macro.
>
> Too late, I already applied this - a further conversion for the new
> macro would be good.
I can send another patch after the following patch is merged:
https://patchwork.kernel.org/patch/10178813/
