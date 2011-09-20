From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Ensure we generate a driver name
Date: Tue, 20 Sep 2011 14:52:28 +0100
Message-ID: <20110920135228.GA2974@opensource.wolfsonmicro.com>
References: <1316523514-21967-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hhb471hqr.wl%tiwai@suse.de>
	<20110920131804.GE2809@opensource.wolfsonmicro.com>
	<s5hd3ev1gqn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 59A6A103850
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Sep 2011 15:52:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hd3ev1gqn.wl%tiwai@suse.de>
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

On Tue, Sep 20, 2011 at 03:32:48PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > *sigh*  This sort of issue is why I'd prefer to just squash specific
> > characters, especially given that we're just being random about what a
> > valid character is.

> Heh.  Or just use a char *, such as

> 	char *p;
> 	...
> 	for (p = card->snd_card->driver; *p; p++) {
> 		if (*p != '_' && *p != '-' && !isalnum(*p))
> 			*p = '_';
> 	}

I find that a bit less legible, and I do like the ARRAY_SIZE() check for
the warm and fuzzies.  It's more just the listing all the characters
bit.  Anyway, is the last version OK for you?
