From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: WL1273 FM radio: Access I2C
	IO	functions through pointers.
Date: Thu, 13 Jan 2011 15:01:13 +0000
Message-ID: <20110113150113.GC20480@sirena.org.uk>
References: <1294924965-6358-1-git-send-email-matti.j.aaltonen@nokia.com>
	<1294925701.3453.5.camel@odin>
	<1294928273.6390.5.camel@masi.mnp.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E1FF243DB
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 16:01:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1294928273.6390.5.camel@masi.mnp.nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Cc: alsa-devel@alsa-project.org, sameo@linux.intel.com, ext Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 13, 2011 at 04:17:53PM +0200, Matti J. Aaltonen wrote:
> On Thu, 2011-01-13 at 13:35 +0000, ext Liam Girdwood wrote:

> > Although it looks like we have a build dependency on the MFD change
> > here ? If so, it may be easier submitting this together with your MFD
> > changes.

> I've already submitted the MFD & V4L2 changes,  they have been accepted
> and should be in the 2.6.38 kernel. One possibility is to wait until v.
> 38 is out... if necessary.

Gah!  Don't do this.  Any changes you're submitting should leave the
kernnel buildable.  If you're submitting a change in the MFD driver to
change the API incompatibly then you need to ensure that *all* callers
are updated to match.

We really shouldn't be getting patches fixing up stuff like this in the
merge window :(
