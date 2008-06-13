From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH][ASoC v2] Update Freescale MPC8610HPCD
	fabric driver to	support multiple codecs
Date: Fri, 13 Jun 2008 10:53:04 +0100
Message-ID: <20080613095304.GE26613@rakim.wolfsonmicro.main>
References: <1213315299-30592-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3CA2C2447B
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 11:53:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1213315299-30592-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 12, 2008 at 07:01:39PM -0500, Timur Tabi wrote:
> Update the Freescale MPC8610 HPCD fabric driver to create a new platform device
> for each SSI in the system, instead of registering multiple PCMs under one card.
> This is necessary for alsamixer to control the individual codecs.

Applied, thanks.
