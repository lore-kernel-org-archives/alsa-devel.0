From: Jeeja KP <jeeja.kp@intel.com>
Subject: Re: [PATCH 01/12] ASoC: Intel: Skylake: Add helper
 function to setup host/link dma
Date: Mon, 5 Dec 2016 22:39:31 +0530
Message-ID: <20161205170930.GA16989@kpjeeja-desk>
References: <1480700509-23380-1-git-send-email-jeeja.kp@intel.com>
 <1480700509-23380-2-git-send-email-jeeja.kp@intel.com>
 <20161205113532.e76i7xs246bddgc4@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 53DCE265142
 for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2016 17:59:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20161205113532.e76i7xs246bddgc4@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 05, 2016 at 11:35:32AM +0000, Mark Brown wrote:
> On Fri, Dec 02, 2016 at 11:11:38PM +0530, jeeja.kp@intel.com wrote:
> 
> > This patch adds helper function to configure the host/link DMA when the
> > DMA is in decoupled mode.
> 
> This isn't just adding a helper function...
> 
> > +	link = snd_hdac_ext_bus_get_link(ebus, rtd->codec->component.name);
> > +	if (!link)
> > +		return -EINVAL;
> > +
> 
> ...it's also doing some things that appear to use that helper function.
Helper function requires 2 parameter format and link_index. these parameters
are updated in hw_params and used by the helper function to configure the link
DMA. so added these as part of the skl_pipe_params structure and these are
updated in hw_params and used in the helper function.

-- 
