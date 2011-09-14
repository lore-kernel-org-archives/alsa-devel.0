From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: Re: [PATCH v2]ASoC:blackfin:add ad73311 card driver
	name
Date: Wed, 14 Sep 2011 11:27:28 +0800
Message-ID: <CAHG8p1CUveaYFkE+=FOZhTpPoKXTWB3UdTJpwtDq8pGTp17CzQ@mail.gmail.com>
References: <1315940366-20515-1-git-send-email-scott.jiang.linux@gmail.com>
	<20110913105328.GA11214@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f172.google.com (mail-qy0-f172.google.com
	[209.85.216.172])
	by alsa0.perex.cz (Postfix) with ESMTP id 819A124587
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Sep 2011 05:27:31 +0200 (CEST)
Received: by qyk32 with SMTP id 32so3659821qyk.17
	for <alsa-devel@alsa-project.org>; Tue, 13 Sep 2011 20:27:29 -0700 (PDT)
In-Reply-To: <20110913105328.GA11214@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2011/9/13 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Tue, Sep 13, 2011 at 02:59:26PM -0400, Scott Jiang wrote:
>
>> Add driver_name in snd_soc_card, asoc will copy this name to driver fiel=
d of snd_card.
>> ALSA lib need this info to load the proper card config.
>
>> =A0static struct snd_soc_card bf5xx_ad73311 =3D {
>> =A0 =A0 =A0 .name =3D "bfin-ad73311",
>> + =A0 =A0 .driver_name =3D "AD73311",
>
> All my comments about the previous revision of the patch continue to
> apply here. =A0The changlog doesn't explain the issue well (the driver
> should already end up with a unique name)
>
in alsa lib snd_config_hook_load_for_all_cards(), use
sndrv_ctl_card_info->driver to determine card config,
not sndrv_ctl_card_info->name, though card name contains enough info.

> and the name you've picked
> is less distinctive than the existing name.
>
I know the name is not good enough, but it is a historical result.
Asoc copy codec name to card->driver before, cause all cards config
file in alsa lib conf dir have this kind of name.
