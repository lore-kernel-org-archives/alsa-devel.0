From: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: Re: Correct way to set NONAUDIO flag
Date: Wed, 17 Aug 2011 21:11:32 +0530
Message-ID: <1313595699.533.33.camel@snowflake>
References: <1313567970.533.21.camel@snowflake> <4E4BB74C.40302@ladisch.de>
	<1313586408.533.30.camel@snowflake>
	<000901cc5cf2$af7fa180$0e7ee480$@bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.128.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 299A024377
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Aug 2011 17:40:29 +0200 (CEST)
In-Reply-To: <000901cc5cf2$af7fa180$0e7ee480$@bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, 'Clemens Ladisch' <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-08-17 at 10:31 -0500, Pierre-Louis Bossart wrote:
> > > > I'm trying to figure out the right way to set the NONAUDIO flag on
> > an
> > > > iec958 device.
> > >
> > > Use the device name "iec958:AES0=6".
> > 
> > Thanks. As I understand it, this forces us to set all the flags instead
> > of just the one that we're interested in. Is this the only way?
> 
> I banged my head against the wall on this one for eAC3 support. For some
> strange reason my receiver works fine with AC3 without touching the C bits,
> but for eAC3 setting the NONAUDIO bit is required.
> If you try to set the bits with ALSA controls in PulseAudio, somehow the
> settings are overwritten when the iec958 device is opened and initialized
> with default values. Clemens is right, setting the AES0=6 in the hdmi
> profile proved to be the only solution. It'd be nice to find a solution in
> which the iec958 device preserves the AES values set beforehand. That way we
> could set the NONAUDIO bit only in passthrough mode.

Well, given this is the best way to do it, my plan is to just close
(suspend) and reopen (unsuspend) and tack on the the right flags to the
device name when we're in passthrough mode.

-- Arun
