From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 5/9] ASoC: Intel: Skylake: Add topology
 core init and handlers
Date: Fri, 18 Sep 2015 20:39:07 +0530
Message-ID: <20150918150907.GD19522@localhost>
References: <1439832404-12424-1-git-send-email-vinod.koul@intel.com>
 <1439832404-12424-6-git-send-email-vinod.koul@intel.com>
 <1442570157.7634.36.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id A1779265A03
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2015 17:07:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1442570157.7634.36.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 18, 2015 at 10:55:57AM +0100, Liam Girdwood wrote:

> > +/* Default types range from 0~12. type can range from 0 to 0xff
> > + * SST types start at higher to avoid any overlapping in future */
> > +#define SOC_CONTROL_TYPE_HDA_SST_ALGO_PARAMS	200
> > +#define SOC_CONTROL_TYPE_HDA_SST_MUX		201
> > +#define SOC_CONTROL_TYPE_HDA_SST_MIX		201
> > +#define SOC_CONTROL_TYPE_HDA_SST_BYTE		203
> 
> These are lower than 0xff

Thanks for pointing, I will update these...

-- 
~Vinod
