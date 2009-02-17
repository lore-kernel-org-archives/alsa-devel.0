From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: Intel G45 no sound without monitor
Date: Tue, 17 Feb 2009 10:26:45 +0800
Message-ID: <20090217022645.GA6747@localhost>
References: <20090216210702.GA28202@csy.ca> <20090217012038.GB5084@localhost>
	<20090217022057.GA18226@csy.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 79817103849
	for <alsa-devel@alsa-project.org>; Tue, 17 Feb 2009 03:26:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090217022057.GA18226@csy.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shane W <shane@csy.ca>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 17, 2009 at 04:20:57AM +0200, Shane W wrote:
> On Tue, Feb 17, 2009 at 09:20:38AM +0800, Wu Fengguang wrote:
> > On Mon, Feb 16, 2009 at 11:07:02PM +0200, Shane W wrote:
> > > Hello,
> > > wasn't known.  On my G45, I don't get any sound if my
> > > television isn't turned on or is disconnected.  That is,
> > > HDMI from the G45 to the Yamaha amp is a no go without a
> > > connected monitor.  Turning on the monitor after system
> > 
> > It's related to our intel gfx driver.
> 
> Ok so in this case, X needs to run for sound to work?  In
> my test environment, X hadn't been started so the intel-gfx
> drivers including i915 kernel module weren't loaded, just
> ALSA.

Yes Xorg is required for G45+Yamaha.  However our G35 board can drive
Yamaha directly in console. The i915 kernel module is irrelevant.

Thanks,
Fengguang
