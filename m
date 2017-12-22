From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH][next] soundwire: intel: fix missing assignment to ret
Date: Fri, 22 Dec 2017 13:40:35 +0530
Message-ID: <20171222081034.GP18649@localhost>
References: <20171221233210.8821-1-colin.king@canonical.com>
 <20171222033148.GN18649@localhost>
 <20171222071522.GA11094@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171222071522.GA11094@kroah.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Colin King <colin.king@canonical.com>, Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 22, 2017 at 08:15:22AM +0100, Greg KH wrote:
> On Fri, Dec 22, 2017 at 09:01:49AM +0530, Vinod Koul wrote:
> > On Thu, Dec 21, 2017 at 11:32:10PM +0000, Colin King wrote:
> > > From: Colin Ian King <colin.king@canonical.com>
> > > 
> > > Currently the return status ret is being checked but it has not been
> > > updated since the previous check on ret. It appears that assignment of
> > > ret from return status of the call to sdw_cdns_enable_interrupt was
> > > accidentally ommited.  Fix this.
> > 
> > Thanks Colin, this looks good to me.
> > 
> > Greg, we have this and another patch from Colin, both lgtm.
> > 
> > Would you like me to collect these and send to you before merge cycle or
> > apply directly?
> 
> Please collect and then send on, as it is not in my queue at all.

Sounds good, will do that

-- 
~Vinod
