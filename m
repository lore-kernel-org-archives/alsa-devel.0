From: Shreyas NC <shreyas.nc@intel.com>
Subject: Re: [PATCH 1/6] Documentation: soundwire: Add
 documentation for Multi link
Date: Wed, 6 Jun 2018 13:32:15 +0530
Message-ID: <20180606080215.GL3116@snc-desk>
References: <1528196497-29554-1-git-send-email-shreyas.nc@intel.com>
 <1528196497-29554-2-git-send-email-shreyas.nc@intel.com>
 <20180606062139.GB16230@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id B450E266F88
 for <alsa-devel@alsa-project.org>; Wed,  6 Jun 2018 10:03:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180606062139.GB16230@vkoul-mobl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod <vkoul@kernel.org>
Cc: patches.audio@intel.com, gregkh@linuxfoundation.org, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com
List-Id: alsa-devel@alsa-project.org

> >  Documentation/driver-api/soundwire/stream.rst | 30 ++++++++++++++++++++++++++-
> >  1 file changed, 29 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/driver-api/soundwire/stream.rst b/Documentation/driver-api/soundwire/stream.rst
> > index 29121aa..af9529b 100644
> > --- a/Documentation/driver-api/soundwire/stream.rst
> > +++ b/Documentation/driver-api/soundwire/stream.rst
> > @@ -76,7 +76,35 @@ Slaves are using single port. ::
> >  	                                                   +---------------+
> >  
> >  
> > -Example 4: Stereo Stream with L and R channel is rendered by two different
> > +Example 4: Stereo Stream with L and R channel is rendered by 2 Masters, each
> 
> We already have an example 4, shouldn't this be 5th one, can you check?
> I would prefer adding new example at the end and not in middle..

Ok, I will fix that in v2.

Thanks for the review!

--Shreyas

-- 
