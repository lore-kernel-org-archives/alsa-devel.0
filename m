From: Vinod <vkoul@kernel.org>
Subject: Re: [PATCH v4 1/8] ASoC: Intel: Skylake: fix widget
	handling
Date: Wed, 25 Jul 2018 21:41:56 +0530
Message-ID: <20180725161156.GV3661@vkoul-mobl>
References: <20180725005055.18138-1-pierre-louis.bossart@linux.intel.com>
 <20180725005055.18138-2-pierre-louis.bossart@linux.intel.com>
 <20180725105928.GL3661@vkoul-mobl>
 <8f35758e-1592-cf0f-832c-cc358a7b2659@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F2092675D4
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 18:12:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <8f35758e-1592-cf0f-832c-cc358a7b2659@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, Rakesh Ughreja <rakesh.a.ughreja@intel.com>
List-Id: alsa-devel@alsa-project.org

On 25-07-18, 09:04, Pierre-Louis Bossart wrote:
> On 7/25/18 5:59 AM, Vinod wrote:
> > On 24-07-18, 19:50, Pierre-Louis Bossart wrote:
> > > From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
> > > 
> > > include DAPM Mux and output widgets into the list.
> > 
> > Pierre,
> > 
> > Curious how is this a fix?
> 
> This is Skylake-specific topology black magic that you are probably better
> equiped to understand that me... This just takes out the outputs and mux
> from a number of topology handling cases.

:D

I agree with the change. But it is not a fix.. So "Add additional widget
handling" would be a better title.

Fix is used for bugs and should be applied to next -rc.

-- 
~Vinod
