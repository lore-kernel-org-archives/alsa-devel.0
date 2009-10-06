From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: Blackfin AD1836/AD1938 machine
 drivers: require SPI master
Date: Tue, 6 Oct 2009 10:33:25 +0100
Message-ID: <20091006093325.GA10118@rakim.wolfsonmicro.main>
References: <1254808311-3594-1-git-send-email-vapier@gentoo.org>
	<1254808311-3594-2-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1CA871038A3
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 11:33:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1254808311-3594-2-git-send-email-vapier@gentoo.org>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 06, 2009 at 01:51:51AM -0400, Mike Frysinger wrote:
> Since these drivers rely on a SPI master and fail if the SPI functions
> aren't present, make sure the Kconfig reflects this dependency.

> Signed-off-by: Mike Frysinger <vapier@gentoo.org>

Could you please redo this as a dependency on the relevant SPI
controller driver?  The audio driver isn't going to work without that
anyway so it seems more sensible.
