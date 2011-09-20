From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] alsa-lib: if card driver name is empty
 string, use card name instead
Date: Tue, 20 Sep 2011 11:53:33 +0100
Message-ID: <20110920105333.GG2387@opensource.wolfsonmicro.com>
References: <1316538944-31853-1-git-send-email-scott.jiang.linux@gmail.com>
	<s5haa9zspcb.wl%tiwai@suse.de>
	<CAHG8p1D=b9-1R6LkkO+39t41F3doGkCN8kPHn19gwif4r03JAg@mail.gmail.com>
	<s5h4o07sooa.wl%tiwai@suse.de>
	<CAHG8p1CdDzkCyVXNJE9SS3=5jK-250-2Kduxrya1_EGBjW=siw@mail.gmail.com>
	<s5hwrd3r8ks.wl%tiwai@suse.de>
	<20110920100314.GB2387@opensource.wolfsonmicro.com>
	<CAHG8p1AB_uxYdhThm+cgf+RdRtrKG4a_7g4j_R_h8VEU5ZUd9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EF72A1038AE
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Sep 2011 12:53:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAHG8p1AB_uxYdhThm+cgf+RdRtrKG4a_7g4j_R_h8VEU5ZUd9A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Scott Jiang <scott.jiang.linux@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 20, 2011 at 06:36:15PM +0800, Scott Jiang wrote:
> 2011/9/20 Mark Brown <broonie@opensource.wolfsonmicro.com>:

> > =A0- This clearly isn't something that affects only one driver - no ASoC
> > =A0 driver sets a driver name - so a change to a single driver is clear=
ly
> > =A0 not a good solution even for just Blackfin.

> I thought about this. I wanted to copy codec name to driver name as
> before in asoc but I don't think it's a good idea.
> Now we can have multicodecs in one card, they may not be the same, right?
> If yes, we should add this name in each snd_soc_card.

If we want to do that then we need to go round every single machine
driver and add a driver name, plus add code in the core which flags
cards that don't set one.
