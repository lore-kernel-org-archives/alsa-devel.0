From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH v4 5/8] ASoC: Intel: Skylake: Add topology
 core init and handlers
Date: Wed, 7 Oct 2015 14:37:38 +0000
Message-ID: <1444228658.25504.61.camel@intel.com>
References: <1444213919-32369-1-git-send-email-vinod.koul@intel.com>
 <1444213919-32369-6-git-send-email-vinod.koul@intel.com>
 <20151007142835.GN12635@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 02A50265E1A
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 16:39:14 +0200 (CEST)
In-Reply-To: <20151007142835.GN12635@sirena.org.uk>
Content-Language: en-US
Content-ID: <B506FE6742AC1A4FACAAA28616E5DB7F@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "broonie@kernel.org" <broonie@kernel.org>
Cc: "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Prusty,
 Subhransu S" <subhransu.s.prusty@intel.com>, "Kp, Jeeja" <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2015-10-07 at 15:28 +0100, Mark Brown wrote:
> On Wed, Oct 07, 2015 at 11:31:56AM +0100, Vinod Koul wrote:
> 
> > +bind_event:
> > +	if (tplg_w->event_type == 0) {
> > +		dev_info(bus->dev, "ASoC: No event handler required\n");
> > +		return 0;
> > +	}
> 
> This looks like it'll be excessively noisy...  why does the user care?

Right. I will move to debug.. 

Thanks
-- 
~Vinod
