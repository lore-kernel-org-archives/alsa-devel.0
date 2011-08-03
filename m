From: Dong Aisheng-B29396 <B29396@freescale.com>
Subject: Re: [PATCH 1/1] ASoC: core: cache index fix
Date: Wed, 3 Aug 2011 11:11:18 +0000
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7721F5223@039-SN1MPN1-002.039d.mgd.msft.net>
References: <65EE16ACC360FA4D99C96DC085B3F7721F43AA@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5hoc08nk7t.wl%tiwai@suse.de>
	<65EE16ACC360FA4D99C96DC085B3F7721F443D@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5hlivcnhe2.wl%tiwai@suse.de>
	<65EE16ACC360FA4D99C96DC085B3F7721F45A8@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5haabsnfg2.wl%tiwai@suse.de>
	<20110802154815.GE25884@opensource.wolfsonmicro.com>
	<s5hipqfn65k.wl%tiwai@suse.de>
	<20110802164005.GI25884@opensource.wolfsonmicro.com>
	<65EE16ACC360FA4D99C96DC085B3F7721F4F43@039-SN1MPN1-002.039d.mgd.msft.net>
	<20110803093140.GB30782@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe001.messaging.microsoft.com
	[65.55.88.11]) by alsa0.perex.cz (Postfix) with ESMTP id AB03C2437B
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Aug 2011 13:11:24 +0200 (CEST)
In-Reply-To: <20110803093140.GB30782@opensource.wolfsonmicro.com>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, "lrg@ti.com" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: Wednesday, August 03, 2011 5:32 PM
> To: Dong Aisheng-B29396
> Cc: Takashi Iwai; alsa-devel@alsa-project.org; s.hauer@pengutronix.de;
> lrg@ti.com; linux-arm-kernel@lists.infradead.org; w.sang@pengutronix.de
> Subject: Re: [alsa-devel] [PATCH 1/1] ASoC: core: cache index fix
> 
> On Wed, Aug 03, 2011 at 07:39:27AM +0000, Dong Aisheng-B29396 wrote:
> 
> > Can we fix FLAT first since it is most used and let rbtree and LZO as
> before?
> 
> Leaving rbtree and LZO alone is exactly what I've been saying!

Sorry for not catch your point before.

Do you think the my patch that provides a register and cache index conversion
helper function behind for FLAT could be a way to try?

If yes, I can clean my patch to only include FLAT fix and send it out for
You to take a look.

Using this method, codec driver does not need to pad the default cache array.
During the cache read, the register will be automatically converted to cache
index to fetch value.
This can also fix the soc_codec_reg_show for codecs who are using packed
(FLAT) Cache while step = 2.
(Here I assume the packed cache only has a different step with FLAT cache.
FIXME if wrong)
