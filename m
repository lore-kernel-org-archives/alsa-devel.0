From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASOC: utils: Update dummy codec DAI
 settings to allow stream creation
Date: Thu, 7 Jun 2012 22:30:57 +0100
Message-ID: <20120607213057.GA19485@sirena.org.uk>
References: <1339058158.1927.15.camel@vkoul-udesk3>
	<1339063721-15193-1-git-send-email-selma.bensaid@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B649F245C2
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Jun 2012 23:31:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1339063721-15193-1-git-send-email-selma.bensaid@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Selma Bensaid <selma.bensaid@intel.com>
Cc: vinod.koul@intel.com, sylvain.centelles@intel.com, alsa-devel@alsa-project.org, louis.le.gall@intel.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 07, 2012 at 12:08:41PM +0200, Selma Bensaid wrote:
> This patch consists in settings the channels_min, rates and formats
> of the dummy codec DAI driver to enable the creation of the PCM streams
> using it.

I still don't understand what this is actually supposed to fix - why are
we trying to set up a stream to something that isn't there?  Though it
looks like this was added for dynamic PCM which has no mainline users so
perhaps there's a sensible use for this...

The other question is how we decide that these are sensible values to
set for the dummy CODEC.
