From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] add a "private" field to the ac97 struct
Date: Thu, 6 Mar 2008 20:53:09 +0000
Message-ID: <20080306205309.GB3993@opensource.wolfsonmicro.com>
References: <20080306164211.GA8205@Chamillionaire.breakpoint.cc>
	<1204823557.2939.5.camel@petrie.sacredspiral.co.uk>
	<20080306172225.GA8492@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 848E1103876
	for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2008 21:53:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080306172225.GA8492@Chamillionaire.breakpoint.cc>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sebastian Siewior <al+sa@ml.breakpoint.cc>
Cc: alsa-devel@alsa-project.org, Nicolas Pitre <nico@cam.org>, William Pitcock <nenolod@sacredspiral.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 06, 2008 at 06:22:25PM +0100, Sebastian Siewior wrote:

> The problem is more or less that I can't pass the value to the other
> probe function and the global variable doesn't look all that pretty. Am
> I missing something here?

This is also a problem for the wm97xx touchscreen drivers.  They have a
similar issue with wanting to get platform configuration into a device
probed off the AC97 bus with the additional issue that features like
syncing with screen redraw will often require code to interface with
other hardware in the system.  If something is added to the AC97 data
it'd be helpful if it were a void * so the wm97xx touch driver could use
it to pass a struct with more data.

This is not really an AC97-specific issue - any device discoverd via a
bus is going to have a similar thing if it needs to obtain platform
data.  I don't know how OpenFirmware normally handles these things?
It's going to be an issue for other buses like PCI too in many systems,
MAC addresses for NICs being the example I've run into myself in a
previous life.

In the case of the wm97xx touchscreen we've avoided the problem by
having the touch driver register platform devices; this isn't ideal but
works well in the systems which are the typical targets for these
devices.  I had been intending to revisit this issue at some point but
it's quite a way down my TODO list.

The wm97xx drivers touch aren't in mainline yet - if you want to have a
look the most current upstream submission versions can be found in the
upstream branch of:

	git://opensource.wolfsonmicro.com/linux-2.6-touch

gitweb:

	http://opensource.wolfsonmicro.com/cgi-bin/gitweb.cgi?p=linux-2.6-touch.git;a=summary
