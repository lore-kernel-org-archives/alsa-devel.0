From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: Fix mpc5200-psc-ac97 to ensure
 the data ready bit is cleared
Date: Fri, 3 Jul 2009 10:59:37 +0100
Message-ID: <20090703095936.GA14330@rakim.wolfsonmicro.main>
References: <20090702175719.15773.58956.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 27478247EE
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jul 2009 11:59:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090702175719.15773.58956.stgit@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, w.sang@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 02, 2009 at 11:57:19AM -0600, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> When doing register reads, it is possible for there to be a stale
> data ready bit set which will cause subsequent reads to return
> prematurely with incorrect data.  This patch fixes the issues by
> ensuring stale data is cleared before starting another transaction.

Applied both, thanks.
