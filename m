From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: Intel G45 no sound without monitor
Date: Tue, 17 Feb 2009 09:20:38 +0800
Message-ID: <20090217012038.GB5084@localhost>
References: <20090216210702.GA28202@csy.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id D863A1037EC
	for <alsa-devel@alsa-project.org>; Tue, 17 Feb 2009 02:20:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090216210702.GA28202@csy.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shane W <shane-alsa@csy.ca>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 16, 2009 at 11:07:02PM +0200, Shane W wrote:
> Hello,
> 
> Not sure if this is a board hardware issue or something
> driver specific but thought I'd put it out there in case it
> wasn't known.  On my G45, I don't get any sound if my
> television isn't turned on or is disconnected.  That is,
> HDMI from the G45 to the Yamaha amp is a no go without a
> connected monitor.  Turning on the monitor after system
> boot has no effect so monitor must be turned on and system
> rebooted for sound to work.

Hi Shane,

It's related to our intel gfx driver.

We bought the same Yamaha RX-V1800 and experienced the same problem.
I was doing extensive (black box) debugging on it these days, and
found that the following process can produce sound on Yamaha:

        startx
        xrandr --output HDMI-1 --mode 1920x1200

In fact the default 1920x540 mode is the only mode in which Yamaha
cannot produce sound. Our intel gfx maintainer confirmed that it's
actually the 1080i mode that is not supported yet.

Thanks,
Fengguang
