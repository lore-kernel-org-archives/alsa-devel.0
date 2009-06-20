From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: Blackfin: keep better track of	SPORT
	configuration state
Date: Sat, 20 Jun 2009 19:41:18 +0100
Message-ID: <20090620184118.GB4509@sirena.org.uk>
References: <0F1B54C89D5F954D8535DB252AF412FA04292614@chinexm1.ad.analog.com>
	<1245511745-19381-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1D665243F5
	for <alsa-devel@alsa-project.org>;
	Sat, 20 Jun 2009 20:41:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1245511745-19381-1-git-send-email-vapier@gentoo.org>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Jun 20, 2009 at 11:29:05AM -0400, Mike Frysinger wrote:
> From: Cliff Cai <cliff.cai@analog.com>
> 
> Do not let the SPORT be reconfigured until there are no more active
> streams.  Then we can let the system reprogram the SPORT state.

Applied.

Please remember to CC maintainers on patches, especially if not starting
a new thread for them.
