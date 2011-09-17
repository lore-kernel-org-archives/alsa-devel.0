From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] [v2] ASoC: support all possible sample
 rates in the WM8776 driver
Date: Sat, 17 Sep 2011 14:27:47 +0100
Message-ID: <20110917132747.GA3798@sirena.org.uk>
References: <1316182614-9666-1-git-send-email-timur@freescale.com>
	<s5hwrd8jy68.wl%tiwai@suse.de> <4E736F9B.6080206@freescale.com>
	<4E7378E2.9050200@metafoo.de> <4E737A89.8090509@freescale.com>
	<4E738B65.6080802@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D496244A6
	for <alsa-devel@alsa-project.org>;
	Sat, 17 Sep 2011 15:27:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E738B65.6080802@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 16, 2011 at 07:46:13PM +0200, Lars-Peter Clausen wrote:

> So ideally the CODEC driver would have callback which you could pass a set of
> sysclk ranges the machine driver can supply and the CODEC driver would return a
> list of sample rates it can support for this sysclk rate range. And then you
> could use this updated list in your machine driver to decide which sysclk rate
> to select. But I'm not sure if this isn't to over-engineered and hard-coding
> this table into the machine driver wouldn't be better.

Yes, that's basically the issue - we could do something about this but
the effort involved seems disproportionate to the value.
