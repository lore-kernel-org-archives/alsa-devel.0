From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH 0/12] sound/alsa/soc/codec: fix memory leak and resource
	relaim in error path
Date: Mon, 19 Jul 2010 09:41:20 +0800
Message-ID: <AANLkTikSPYLmrIVkyD_GOVZ76Bkha7DNxED33ZZgQNKJ@mail.gmail.com>
References: <1279162147.29294.2.camel@mola> <20100715085932.GA23529@rakim.wolfsonmicro.main>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100715085932.GA23529@rakim.wolfsonmicro.main>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Tejun Heo <tj@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

hi Mark,

2010/7/15 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Thu, Jul 15, 2010 at 10:49:07AM +0800, Axel Lin wrote:
>
>> [PATCH 1/12] ad1836: fix a memory leak if another ad1836 is register=
ed
>> [PATCH 2/12] ak4642: fix a memory leak if failed to initialise AK464=
2
>> [PATCH 3/12] da7210: fix a memory leak if failed to initialise da721=
0 audio codec
>> [PATCH 4/12] wm8523: fix resource reclaim in wm8523_register error p=
ath
>> [PATCH 5/12] wm8711: fix a memory leak if another WM8711 is register=
ed
>> [PATCH 6/12] wm8904: fix resource reclaim in wm8904_register error p=
ath
>> [PATCH 7/12] wm8940: fix resource reclaim in wm8940_register error p=
ath
>> [PATCH 8/12] wm8955: fix resource reclaim in wm8955_register error p=
ath
>> [PATCH 9/12] wm8961: fix resource reclaim in wm8961_register error p=
ath
>> [PATCH 10/12] wm8974: fix a memory leak if another WM8974 is registe=
red
>> [PATCH 11/12] wm8978: fix a memory leak if another WM8978 is registe=
red
>> [PATCH 12/12] wm9081: fix resource reclaim in wm9081_register error =
path
>
> If you're going to be submiting large batches of small patches like t=
his
> it would be really helpful if you could make sure you format the subj=
ect
> lines for your patches so that they match the standards for the area =
of
> the kernel you're updating. =A0This makes them much easier to apply.
>

After checking Liam's multi-component branch, I think this serial of
fix is not necessary.
If you think it still has value to merge this serial of fix for
current implementation, just let me know.

Regards,
Axel
