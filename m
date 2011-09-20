From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Ensure we generate a card name
Date: Tue, 20 Sep 2011 14:20:02 +0100
Message-ID: <20110920132002.GF2809@opensource.wolfsonmicro.com>
References: <1316515341-21157-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hvcsn1nwc.wl%tiwai@suse.de>
	<20110920110355.GI2387@opensource.wolfsonmicro.com>
	<s5hr53b1kgw.wl%tiwai@suse.de>
	<20110920121913.GC2809@opensource.wolfsonmicro.com>
	<s5hobyf1inz.wl%tiwai@suse.de>
	<20110920125646.GD2809@opensource.wolfsonmicro.com>
	<s5hk4931i5d.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C65692446E
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Sep 2011 15:20:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hk4931i5d.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.cm>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 20, 2011 at 03:02:22PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > It might not be used by ALSA but it's used by some userspaces to
> > identify the card they're running on.

> The card->name can contain special letters.  This has been so for over
> a decade, and won't be changed.  Why now need to change this?

I'm not suggesting that it should?  To be honest I'm quite surprised
that the alsa-lib code isn't able to cope with spaces in the driver
name in the first places, I'd rather just fix the specific characters it
doesn't like.
