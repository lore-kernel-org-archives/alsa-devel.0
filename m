From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] sst: replace custom implementation
 of readq / writeq
Date: Fri, 18 Sep 2015 15:07:25 +0300
Message-ID: <1442578045.8361.93.camel@linux.intel.com>
References: <1440677358-6681-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1442480279.8361.73.camel@linux.intel.com> <1442481844.2520.19.camel@loki>
 <20150917114140.GB19522@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D1248260415
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2015 14:07:30 +0200 (CEST)
In-Reply-To: <20150917114140.GB19522@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2015-09-17 at 17:11 +0530, Vinod Koul wrote:
> On Thu, Sep 17, 2015 at 10:24:04AM +0100, Liam Girdwood wrote:
> > On Thu, 2015-09-17 at 11:57 +0300, Andy Shevchenko wrote:
> > > On Thu, 2015-08-27 at 15:09 +0300, Andy Shevchenko wrote:
> > > > The readq() and writeq() helpers are available in the
> > > > asm-generic/io-64-nonatomic-hi-lo.h and asm-generic/io-64
> > > > -nonatomic
> > > > -lo-hi.h
> > > > headers. Replace custom implementation by the generic helpers.
> > > > 
> > > 
> > > Liam, any comments on this?
> > 
> > Looks good from me, but it's one of Vinod's drivers (now added to 
> > CC).
> 
> Please do test this on BYT/BSW as well, otherwise looks good

Tested both patches (another one just recently sent) on ASuS T100TA.

> 
> Acked-by: Vinod Koul <vinod.koul@intel.com>
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
