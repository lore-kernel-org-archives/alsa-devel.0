From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: compress: Only mute playback streams
Date: Thu, 7 Feb 2013 05:37:40 -0800
Message-ID: <20130207133740.GR3143@intel.com>
References: <1360173344-27930-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1360227518.2423.4.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 391B42652AB
 for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2013 15:02:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1360227518.2423.4.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.jf.intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 07, 2013 at 08:58:38AM +0000, Liam Girdwood wrote:
> On Wed, 2013-02-06 at 17:55 +0000, Mark Brown wrote:
> > Otherwise capture activity on a compressed DAI would mute any playback
> > on the same DAI.
> > 
> > Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
