From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH][ASoC v2] Add checks for codec DAI number
	during	match-up
Date: Fri, 13 Jun 2008 10:52:42 +0100
Message-ID: <20080613095241.GD26613@rakim.wolfsonmicro.main>
References: <1213315294-30548-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7377E24473
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 11:52:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1213315294-30548-1-git-send-email-timur@freescale.com>
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

On Thu, Jun 12, 2008 at 07:01:34PM -0500, Timur Tabi wrote:
> Update the Codec DAI matching scheme to take the DAI number into account, and
> not just the name.  This is necessary for systems with multiple codecs that
> use the Codec ID number to differentiate them.

Applied, thanks.
