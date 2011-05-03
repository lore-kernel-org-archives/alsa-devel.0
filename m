From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2 v2] ASoC: soc-cache: block based rbtree
 compression
Date: Tue, 3 May 2011 16:48:47 +0100
Message-ID: <20110503154847.GY1762@opensource.wolfsonmicro.com>
References: <20110503132420.GM1762@opensource.wolfsonmicro.com>
	<s5hd3jzrjsw.wl%tiwai@suse.de>
	<20110503135117.GA2893@sirena.org.uk>
	<s5h8vunri6p.wl%tiwai@suse.de>
	<20110503142729.GP1762@opensource.wolfsonmicro.com>
	<s5h4o5breqj.wl%tiwai@suse.de>
	<20110503152405.GV1762@opensource.wolfsonmicro.com>
	<s5hzkn3pzrv.wl%tiwai@suse.de>
	<20110503154043.GW1762@opensource.wolfsonmicro.com>
	<s5hvcxrpz0k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CA7ED1038CB
	for <alsa-devel@alsa-project.org>;
	Tue,  3 May 2011 17:48:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hvcxrpz0k.wl%tiwai@suse.de>
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, May 03, 2011 at 05:47:07PM +0200, Takashi Iwai wrote:

> IMO, it's easier to expose an API that allows the update of an
> register array.  The rest is a job of the cache backend stuff. 
> As a fallback, it can be a loop of the single read/write.

We'll want to do that as well, but we still want the actual data
structure underneath to support that.  Since most register maps that
benefit from compression are also sparse rbtree is the common case for
getting a win from this.
