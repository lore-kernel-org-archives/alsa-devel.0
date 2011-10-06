From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] soc: codecs: tlv320aic32x4: fix
 initialization of micpga routing
Date: Thu, 6 Oct 2011 20:00:48 +0100
Message-ID: <20111006190048.GB17685@opensource.wolfsonmicro.com>
References: <1317927216-23476-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 81A99103A76
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Oct 2011 21:08:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317927216-23476-1-git-send-email-w.sang@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Javier Martin <javier.martin@vista-silicon.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 06, 2011 at 08:53:36PM +0200, Wolfram Sang wrote:
> Checking the pdata-flags used 'or', so the check is always true. Use 'and' to
> correctly mask the flags.

Applied, thanks.  Please try to choose subjects which resemble those for
the rest of the subsystem.
