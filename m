From: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Subject: Re: [PATCH] ASoC: WL1273 FM radio: Access I2C IO
 functions through pointers.
Date: Thu, 13 Jan 2011 18:18:21 +0200
Message-ID: <1294935501.6390.44.camel@masi.mnp.nokia.com>
References: <1294924965-6358-1-git-send-email-matti.j.aaltonen@nokia.com>
	<1294925701.3453.5.camel@odin>
	<1294928273.6390.5.camel@masi.mnp.nokia.com>
	<20110113150113.GC20480@sirena.org.uk>
Reply-To: matti.j.aaltonen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (mgw-da01.ext.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C48A103B05
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 17:18:27 +0100 (CET)
In-Reply-To: <20110113150113.GC20480@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, sameo@linux.intel.com, ext Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-01-13 at 15:01 +0000, ext Mark Brown wrote:
> On Thu, Jan 13, 2011 at 04:17:53PM +0200, Matti J. Aaltonen wrote:
> > On Thu, 2011-01-13 at 13:35 +0000, ext Liam Girdwood wrote:
> 
> > > Although it looks like we have a build dependency on the MFD change
> > > here ? If so, it may be easier submitting this together with your MFD
> > > changes.
> 
> > I've already submitted the MFD & V4L2 changes,  they have been accepted
> > and should be in the 2.6.38 kernel. One possibility is to wait until v.
> > 38 is out... if necessary.
> 
> Gah!  Don't do this.  Any changes you're submitting should leave the
> kernnel buildable.  If you're submitting a change in the MFD driver to
> change the API incompatibly then you need to ensure that *all* callers
> are updated to match.
> We really shouldn't be getting patches fixing up stuff like this in the
> merge window :(

Sorry if I sent the patch at a wrong time...

I'm not changing the MFD driver, the first version is hopefully going
into the v. 2.6.38 kernel.

At first I started to upstream all three parts of the driver at the same
time, about a year ago. At first I sent all parts to the media list,
there I was - quite reasonably - asked to send the codec to the alsa
list. After some tuning and fine tuning the codec got accepted. But
getting the rest of the driver in took much longer and in the process
the MFD and V4L2 parts became incompatible with the codec.

So we'll just wait until 2.6.38 is out and everything remains
compilable... When 38 gets released the codec cannot be used with rest
of the driver until this patch is applied, but that can be done when a
suitable window opens, right? 

Cheers,
Matti
