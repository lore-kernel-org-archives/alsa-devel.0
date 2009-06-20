From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: Blackfin: convert internal
	names	from bf52x to bf5xx
Date: Sat, 20 Jun 2009 19:51:23 +0100
Message-ID: <20090620185123.GD4509@sirena.org.uk>
References: <1245511797-19460-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E35FE2440C
	for <alsa-devel@alsa-project.org>;
	Sat, 20 Jun 2009 20:51:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1245511797-19460-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Barry Song <barry.song@analog.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Jun 20, 2009 at 11:29:56AM -0400, Mike Frysinger wrote:
> From: Barry Song <barry.song@analog.com>
> 
> These drivers aren't BF52x specific, so don't use bf52x in the names.

Applied for 2.6.32.

Given that these machine drivers cover so many different systems you
probably want to remove a lot of the Kconfig settings and make
everything take platform data specifying how the system is set up.  At
the minute there's a relatively large amount of manual kernel
configuration required to get things up and running on a given board
which isn't ideal.
