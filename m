From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: imx-ssi fixes
Date: Thu, 8 Apr 2010 15:47:50 +0100
Message-ID: <20100408144750.GC14241@sirena.org.uk>
References: <1270719086-23453-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CEAC5243F4
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Apr 2010 16:47:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1270719086-23453-1-git-send-email-s.hauer@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Valentin Longchamp <valentin.longchamp@epfl.ch>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 08, 2010 at 11:31:23AM +0200, Sascha Hauer wrote:

> Here are some bugfix patches for the imx-ssi driver. It should also fix
> the problems reported in FIQ mode.

Applied all three, thanks - the hrtimer stuff works an awful lot better
than the vanilla timer stuff did.  It's a shame I hadn't noticed that
hrtimers did manage to give better resolution on i.MX when I looked into
this previously.

It'd be good if you could look into the timer sync issue - doing
something like deferring the timer by a proportion of a period if
the period hasn't elapsed ought to cover it.
