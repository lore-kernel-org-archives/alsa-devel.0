From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 3/9] ASoC: Intel: Skylake: add DSP
 platform widget event handlers
Date: Fri, 18 Sep 2015 09:52:14 +0530
Message-ID: <20150918042214.GT19522@localhost>
References: <1439832404-12424-1-git-send-email-vinod.koul@intel.com>
 <1439832404-12424-4-git-send-email-vinod.koul@intel.com>
 <1442483278.2520.24.camel@loki> <20150917113856.GA19522@localhost>
 <1442492707.2520.36.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 7697E2659B0
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2015 06:19:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1442492707.2520.36.camel@loki>
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
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, Hardik T Shah <hardik.t.shah@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 17, 2015 at 01:25:07PM +0100, Liam Girdwood wrote:
 
> > > There is a lot of list walking and manipulation in this series and it's
> > > not clear where any locks are being held to prevent list corruption.
> > > I'm assuming list items are being added and removed as part of
> > > loading/unloading the topology data but it looks like we are also
> > > manipulating component lists during DAPM events ?
> > 
> > We have a driver list dapm_path_list where we store the widgets powered up.
> > This gives us a very quick reference of the paths which are powered up in
> > the graph and helps fast traversal to check if we should power up a path as
> > path is connected to something else which is powered up already (mixng two
> > paths) and similarly while disconnecting.
> > 
> > Please note all these are handled only in event handlers for widgets, so
> > they will be invoked by dapm with mutex, dapm_mutex held, so we didn't think
> > we would need another lock here
> > 
> 
> Ok, I was thinking that may be the case. It may be worth while stating
> this in comments where this applies.

It's actually specfied that we add all connected paths to drivers list.
I am okay to add more, will do so here if there any anymore comments from
Mark, otherwise will add as an update in patches after this series

Thanks
-- 
~Vinod
