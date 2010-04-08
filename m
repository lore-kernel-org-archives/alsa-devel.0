From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] imx-ssi: Use a hrtimer in FIQ mode
Date: Thu, 8 Apr 2010 16:45:15 +0100
Message-ID: <20100408154514.GD6792@sirena.org.uk>
References: <1270719086-23453-1-git-send-email-s.hauer@pengutronix.de>
	<1270719086-23453-4-git-send-email-s.hauer@pengutronix.de>
	<20100408095324.GB6303@rakim.wolfsonmicro.main>
	<20100408131353.GI3688@pengutronix.de>
	<20100408140329.GB14241@sirena.org.uk>
	<1270739669.3248.591.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 97C1A1038E8
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Apr 2010 17:45:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1270739669.3248.591.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, alsa-devel@alsa-project.org, Valentin Longchamp <valentin.longchamp@epfl.ch>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 08, 2010 at 04:14:29PM +0100, Liam Girdwood wrote:

> I agree this will drift but I _think_ we are probably workable here for
> most latency sensitive apps as long as the worst case notification delay
> is 1 period, pointer() is accurate to a few frames and there is a least
> > 3 or 4 period buffers available for use in our driver buffer (for each
> direction). 

Yes, if they're running more than one period ahead everything should be
fine.

> Currently the min periods for this driver is 2, so I would probably
> change to 4 to reduce drift related glitches.

Good idea.
