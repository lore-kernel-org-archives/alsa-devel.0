From: "Omair M. Abdullah" <omair.m.abdullah@intel.com>
Subject: Re: [PATCH] ASoC: Jack: add configurable option for
 irq_flag
Date: Mon, 18 Feb 2013 18:25:17 +0530
Message-ID: <20130218125516.GC23031@oma-dev>
References: <1360647422-12404-1-git-send-email-omair.m.abdullah@linux.intel.com>
 <20130212114752.GA1678@opensource.wolfsonmicro.com>
 <63969.10.223.96.90.1360733997.squirrel@linux.intel.com>
 <20130213131917.GF5062@opensource.wolfsonmicro.com>
 <20130215071000.GA23031@oma-dev>
 <20130215121727.GD22283@opensource.wolfsonmicro.com>
 <20130217063725.GB23031@oma-dev>
 <20130217173015.GD1583@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 2471E264F07
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2013 13:53:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130217173015.GD1583@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Ramesh Babu <ramesh.babu@linux.intel.com>, alsa-devel@alsa-project.org, vinod.koul@linux.intel.com, vaibhav.agarwal@intel.com, lgirdwood@gmail.com, Omair Mohammed Abdullah <omair.m.abdullah@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Feb 17, 2013 at 06:11:45PM +0000, Mark Brown wrote:
> On Sun, Feb 17, 2013 at 12:07:25PM +0530, Omair M. Abdullah wrote:
> > On Fri, Feb 15, 2013 at 12:17:27PM +0000, Mark Brown wrote:
> 
> > > It sounds like all you're looking for here is a better debounce
> > > algorithm, for example one that delays for a bit then starts polling the
> > > GPIO state at a higher rate and declares a result when the GPIO state
> > > doesn't change for a few polls.
> 
> > We are using a polling mechanism in our system to check the jack state a few
> > times. But what we observed is that we always get a bounce.
> 
> If you're already doing that then this is at best redundant and at worst
> will make things worse if you do happen to hit a case where you don't
> see any bounce for some reason.
> 
> > Also, we do have a system where we are using the snd_soc_jack_gpio code for a
> > codec interrupt through a GPIO line, like Ramesh mentioned - even if it is just
> > for re-using the software debounce mechanism. In such cases, the interrupt would
> > be triggered on one edge only. Maybe that is not the original intent the of that
> > code?
> 
> What you're describing does not sound at all sane, the GPIO jack code is
> there for managing GPIO jacks not for providing a generic debounce
> mechanism for interrupts.  I'm not sure how you'd actually go about
> doing this...
If you have the codec interrupt line which is connected to the SoC through a
GPIO then this is possible.
