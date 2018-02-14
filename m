From: Donglin Peng <dolinux.peng@gmail.com>
Subject: Re: [PATCH v3] ASoC: use DEFINE_SHOW_ATTRIBUTE() to decrease code duplication
Date: Wed, 14 Feb 2018 22:39:36 +0800
Message-ID: <CAErzpmt+HhGkVoN199iPDmQx-1z3iS3waxYQ=oxvn14Bm0R5gg@mail.gmail.com>
References: <CAErzpmuxmrJszRz5_SZXPMkdU2UWNHChrnKjnHuCWZYrs4hgTA@mail.gmail.com>
 <20180212114937.GA12976@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180212114937.GA12976@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 12, 2018 at 7:49 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Feb 09, 2018 at 11:10:55PM +0800, Donglin Peng wrote:
>
>> --- a/sound/soc/soc-core.c
>> +++ b/sound/soc/soc-core.c
>> @@ -349,7 +349,7 @@ static void soc_init_codec_debugfs(struct
>> snd_soc_component *component)
>>              "ASoC: Failed to create codec register debugfs file\n");
>
> Your patch has been corrupted somewhere (probably in your mail client) -
> there's word wrapping here.
Hi Mark, do you know the way to disable gmail word wrap in plain text mode?
I find that gmail will force to wrap word at 70 characters in plain text mode.

There is a connection error when I use git send-email to send the patch
because I am using VPN.
