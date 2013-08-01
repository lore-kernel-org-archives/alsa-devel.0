From: Olof Johansson <olof@lixom.net>
Subject: Re: [patch] ASoC: dapm: using freed pointer in dapm_kcontrol_add_widget()
Date: Wed, 31 Jul 2013 20:49:14 -0700
Message-ID: <CAOesGMgh7j8U=3nAUfo0EnybS-b=mCdzt_M33PMqekAz8=GcUA@mail.gmail.com>
References: <20130731085244.GB8210@elgon.mountain>
	<51F8D2B5.7060504@metafoo.de>
	<CAOesGMgrztKFbLM4m3sr1cH=Od6FVy8p2BbEi_X=J_jDhyHBKw@mail.gmail.com>
	<51F9585F.8060505@metafoo.de>
	<51F95B01.7040002@metafoo.de>
	<20130731200526.GD9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20130731200526.GD9858@sirena.org.uk>
Sender: kernel-janitors-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Dan Carpenter <dan.carpenter@oracle.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 31, 2013 at 1:05 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Jul 31, 2013 at 08:44:17PM +0200, Lars-Peter Clausen wrote:
>
>> Something along the lines of this:
>
> This seems to fix it for me, can you submit properly please?

Here too. If you submit that as a patch, feel free to add:

Tested-by: Olof Johansson <olof@lixom.net>


-Olof
