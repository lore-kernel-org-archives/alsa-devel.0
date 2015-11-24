From: "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v1 1/1] sst: replace custom implementation
 of readq / writeq
Date: Tue, 24 Nov 2015 10:25:01 +0000
Message-ID: <1448360710.15393.20.camel@intel.com>
References: <1440677358-6681-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1442480279.8361.73.camel@linux.intel.com> <1442481844.2520.19.camel@loki>
 <20150917114140.GB19522@localhost>
 <1442578045.8361.93.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D6102614E2
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2015 11:25:06 +0100 (CET)
In-Reply-To: <1442578045.8361.93.camel@linux.intel.com>
Content-Language: en-US
Content-ID: <362725597A10A741AE49505A0372C9EB@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "Koul, Vinod" <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "yang.jie@linux.intel.com" <yang.jie@linux.intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2015-09-18 at 15:07 +0300, Andy Shevchenko wrote:
> On Thu, 2015-09-17 at 17:11 +0530, Vinod Koul wrote:
> > On Thu, Sep 17, 2015 at 10:24:04AM +0100, Liam Girdwood wrote:
> > > On Thu, 2015-09-17 at 11:57 +0300, Andy Shevchenko wrote:
> > > > On Thu, 2015-08-27 at 15:09 +0300, Andy Shevchenko wrote:
> > > > > The readq() and writeq() helpers are available in the
> > > > > asm-generic/io-64-nonatomic-hi-lo.h and asm-generic/io-64
> > > > > -nonatomic
> > > > > -lo-hi.h
> > > > > headers. Replace custom implementation by the generic
> > > > > helpers.
> > > > > 
> > > > 
> > > > Liam, any comments on this?
> > > 
> > > Looks good from me, but it's one of Vinod's drivers (now added to
> > > CC).
> > 
> > Please do test this on BYT/BSW as well, otherwise looks good
> 
> Tested both patches (another one just recently sent) on ASuS T100TA.

Do I understand correctly I have to resend with Mark in Cc?

> 
> > 
> > Acked-by: Vinod Koul <vinod.koul@intel.com>
> > 
> 

-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy
---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
