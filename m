From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: Re: [PATCH] [PATCH]ASoC:blackfin:add ad73311 card
	driver name
Date: Wed, 7 Sep 2011 13:42:59 +0800
Message-ID: <CAHG8p1D+-zPjkjMnnt5DX-APt7tX0YiZJ5Rh+S0Kdx9O7YysRA@mail.gmail.com>
References: <1315338369-4251-1-git-send-email-scott.jiang.linux@gmail.com>
	<20110906151948.GB18090@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f172.google.com (mail-qy0-f172.google.com
	[209.85.216.172])
	by alsa0.perex.cz (Postfix) with ESMTP id A1959103866
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Sep 2011 07:43:00 +0200 (CEST)
Received: by qyk34 with SMTP id 34so1107461qyk.17
	for <alsa-devel@alsa-project.org>; Tue, 06 Sep 2011 22:42:59 -0700 (PDT)
In-Reply-To: <20110906151948.GB18090@opensource.wolfsonmicro.com>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2011/9/6 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Tue, Sep 06, 2011 at 03:46:09PM -0400, Scott Jiang wrote:
>> ASoC doesn't copy codec name to card driver now.
>> ALSA lib need this info to find the proper card config.
>> So add card name in snd_soc_card, asoc will copy this name to snd_card.
>
> Your changelog doesn't correspond to your code:
>
>> =A0static struct snd_soc_card bf5xx_ad73311 =3D {
>> =A0 =A0 =A0 .name =3D "bfin-ad73311",
>> + =A0 =A0 .driver_name =3D "AD73311",
>
>There should already be enough information available to userspace to ident=
ify
> that the card is a Blackfin card with ad73311.
>
Yes, card name contains enough info, but alsa lib doesn't use it.
My alsa lib version is 1.0.24. It uses driver name to find card config
not short name nor long name.

> Since the driver_name you're setting only contains the name of the CODEC =
it looks likely to
> cause more collisions anyway as other systems may use the same CODEC.
>
It is a historical result. all cards config of blackfin in alsa lib
use these names.

one more question, I found nobody changed this in their drivers.
Do their cards config in alsa lib acctually take effect?
