From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] alsa-lib: if card driver name is empty
 string, use card name instead
Date: Tue, 20 Sep 2011 11:03:15 +0100
Message-ID: <20110920100314.GB2387@opensource.wolfsonmicro.com>
References: <1316538944-31853-1-git-send-email-scott.jiang.linux@gmail.com>
	<s5haa9zspcb.wl%tiwai@suse.de>
	<CAHG8p1D=b9-1R6LkkO+39t41F3doGkCN8kPHn19gwif4r03JAg@mail.gmail.com>
	<s5h4o07sooa.wl%tiwai@suse.de>
	<CAHG8p1CdDzkCyVXNJE9SS3=5jK-250-2Kduxrya1_EGBjW=siw@mail.gmail.com>
	<s5hwrd3r8ks.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A5A3C10389B
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Sep 2011 12:03:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hwrd3r8ks.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Scott Jiang <scott.jiang.linux@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 20, 2011 at 09:12:19AM +0200, Takashi Iwai wrote:
> Scott Jiang wrote:

> > I agree with you, but my driver patch has been rejected by Mark.

> That's bad.  But it's a rule since over 10 years ago: the driver
> should set driver field.

Scott, as I've said every time you've posted your patch there's several
problems with your patch:

 - The name you've chosen is really not at all suitable, it doesn't
   identify the system at all.
 - This clearly isn't something that affects only one driver - no ASoC
   driver sets a driver name - so a change to a single driver is clearly
   not a good solution even for just Blackfin.

You need to address these issues, they're both blocking.
