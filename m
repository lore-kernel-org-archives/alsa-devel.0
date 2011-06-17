From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Blackfin: allow SPI for SSM2602 parts
Date: Fri, 17 Jun 2011 10:41:36 +0100
Message-ID: <20110617094136.GB7851@opensource.wolfsonmicro.com>
References: <1308277455-370-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9CDCA244B0
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Jun 2011 11:41:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1308277455-370-1-git-send-email-vapier@gentoo.org>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 16, 2011 at 10:24:15PM -0400, Mike Frysinger wrote:
> This board has hardware switches for selecting SPI or I2C, so don't
> require I2C for this driver.
> 
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>

Applied, though I suspect this won't actually load as the different bus
will change the name the CODEC uses to register with the subsystem (so
we can address multiple CODECs).
