From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Ensure we generate a driver name
Date: Tue, 20 Sep 2011 14:18:05 +0100
Message-ID: <20110920131804.GE2809@opensource.wolfsonmicro.com>
References: <1316523514-21967-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hhb471hqr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A0BCF103910
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Sep 2011 15:18:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hhb471hqr.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 20, 2011 at 03:11:08PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > +	snprintf(card->snd_card->driver, sizeof(card->snd_card->driver),
> > +		 "%s", card->driver_name ? card->driver_name : card->name);
> > +	for (i = 0; i < ARRAY_SIZE(card->snd_card->driver); i++) {

> Should check card->snd_card->driver[i] != 0 here, too.

*sigh*  This sort of issue is why I'd prefer to just squash specific
characters, especially given that we're just being random about what a
valid character is.
