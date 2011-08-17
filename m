From: "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>
Subject: Re: Correct way to set NONAUDIO flag
Date: Wed, 17 Aug 2011 10:31:07 -0500
Message-ID: <13430.6839471266$1313595082@news.gmane.org>
References: <1313567970.533.21.camel@snowflake> <4E4BB74C.40302@ladisch.de>
	<1313586408.533.30.camel@snowflake>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 930D224377
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Aug 2011 17:31:10 +0200 (CEST)
In-Reply-To: <1313586408.533.30.camel@snowflake>
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Arun Raghavan' <arun.raghavan@collabora.co.uk>, 'Clemens Ladisch' <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> > > I'm trying to figure out the right way to set the NONAUDIO flag on
> an
> > > iec958 device.
> >
> > Use the device name "iec958:AES0=6".
> 
> Thanks. As I understand it, this forces us to set all the flags instead
> of just the one that we're interested in. Is this the only way?

I banged my head against the wall on this one for eAC3 support. For some
strange reason my receiver works fine with AC3 without touching the C bits,
but for eAC3 setting the NONAUDIO bit is required.
If you try to set the bits with ALSA controls in PulseAudio, somehow the
settings are overwritten when the iec958 device is opened and initialized
with default values. Clemens is right, setting the AES0=6 in the hdmi
profile proved to be the only solution. It'd be nice to find a solution in
which the iec958 device preserves the AES values set beforehand. That way we
could set the NONAUDIO bit only in passthrough mode.
-Pierre
