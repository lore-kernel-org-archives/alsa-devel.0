From: Shane W <shane-alsa@csy.ca>
Subject: Re: Intel G45 no sound without monitor
Date: Mon, 16 Feb 2009 18:22:27 -0800
Message-ID: <20090217022226.GA18535@csy.ca>
References: <20090216210702.GA28202@csy.ca> <20090217012038.GB5084@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from idcmail-mo1so.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 663C3103841
	for <alsa-devel@alsa-project.org>; Tue, 17 Feb 2009 03:22:28 +0100 (CET)
Received: from shane by continuum.csy.ca with local (Exim 4.69)
	(envelope-from <shane-alsa@csy.ca>) id 1LZFbP-0004pn-4a
	for alsa-devel@alsa-project.org; Mon, 16 Feb 2009 18:22:27 -0800
Content-Disposition: inline
In-Reply-To: <20090217012038.GB5084@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 17, 2009 at 09:20:38AM +0800, Wu Fengguang wrote:
> On Mon, Feb 16, 2009 at 11:07:02PM +0200, Shane W wrote:
> > Hello,
> > wasn't known.  On my G45, I don't get any sound if my
> > television isn't turned on or is disconnected.  That is,
> > HDMI from the G45 to the Yamaha amp is a no go without a
> > connected monitor.  Turning on the monitor after system
> 
> It's related to our intel gfx driver.

Ok so in this case, X needs to run for sound to work?  In
my test environment, X hadn't been started so the intel-gfx
drivers including i915 kernel module weren't loaded, just
ALSA.

Shane
