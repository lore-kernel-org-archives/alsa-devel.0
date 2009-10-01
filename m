From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: fix kconfig order of Blackfin drivers
Date: Thu, 1 Oct 2009 11:27:37 +0100
Message-ID: <20091001102737.GA19998@rakim.wolfsonmicro.main>
References: <1254375210-14928-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F1C46103821
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 12:27:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1254375210-14928-1-git-send-email-vapier@gentoo.org>
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

On Thu, Oct 01, 2009 at 01:33:30AM -0400, Mike Frysinger wrote:
> From: Barry Song <barry.song@analog.com>

> Some of the Blackfin options don't directly follow the kconfig options
> they depend on, so kconfig is unable to display the proper tree.  So sort
> the options such they expand/collapse properly.

Applied, thanks.
