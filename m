From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: Re: [PATCH] alsa-lib: if card driver name is empty
 string, use card name instead
Date: Tue, 20 Sep 2011 18:36:15 +0800
Message-ID: <CAHG8p1AB_uxYdhThm+cgf+RdRtrKG4a_7g4j_R_h8VEU5ZUd9A@mail.gmail.com>
References: <1316538944-31853-1-git-send-email-scott.jiang.linux@gmail.com>
	<s5haa9zspcb.wl%tiwai@suse.de>
	<CAHG8p1D=b9-1R6LkkO+39t41F3doGkCN8kPHn19gwif4r03JAg@mail.gmail.com>
	<s5h4o07sooa.wl%tiwai@suse.de>
	<CAHG8p1CdDzkCyVXNJE9SS3=5jK-250-2Kduxrya1_EGBjW=siw@mail.gmail.com>
	<s5hwrd3r8ks.wl%tiwai@suse.de>
	<20110920100314.GB2387@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5BE37103815
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Sep 2011 12:36:16 +0200 (CEST)
Received: by qyk33 with SMTP id 33so387402qyk.17
	for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2011 03:36:15 -0700 (PDT)
In-Reply-To: <20110920100314.GB2387@opensource.wolfsonmicro.com>
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

2011/9/20 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Tue, Sep 20, 2011 at 09:12:19AM +0200, Takashi Iwai wrote:
>> Scott Jiang wrote:
>
>> > I agree with you, but my driver patch has been rejected by Mark.
>
>> That's bad. =A0But it's a rule since over 10 years ago: the driver
>> should set driver field.
>
> Scott, as I've said every time you've posted your patch there's several
> problems with your patch:
>
> =A0- The name you've chosen is really not at all suitable, it doesn't
> =A0 identify the system at all.
I said I wound modify the name. But I want to know how to fix this
problem before I send a new patch.

> =A0- This clearly isn't something that affects only one driver - no ASoC
> =A0 driver sets a driver name - so a change to a single driver is clearly
> =A0 not a good solution even for just Blackfin.
>
I thought about this. I wanted to copy codec name to driver name as
before in asoc but I don't think it's a good idea.
Now we can have multicodecs in one card, they may not be the same, right?
If yes, we should add this name in each snd_soc_card.
