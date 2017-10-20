From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 02/14] soundwire: Add SoundWire bus type
Date: Fri, 20 Oct 2017 18:21:23 +0200
Message-ID: <20171020162123.GA4538@kroah.com>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-3-git-send-email-vinod.koul@intel.com>
 <20171020104528.GC3210@kroah.com>
 <20171020160134.GT30097@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 06CF3267708
 for <alsa-devel@alsa-project.org>; Fri, 20 Oct 2017 18:21:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20171020160134.GT30097@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Shreyas NC <shreyas.nc@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 20, 2017 at 09:31:34PM +0530, Vinod Koul wrote:
> On Fri, Oct 20, 2017 at 12:45:28PM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Oct 19, 2017 at 08:33:18AM +0530, Vinod Koul wrote:
> > > +/*
> > > + *  This file is provided under a dual BSD/GPLv2 license.  When using or
> > > + *  redistributing this file, you may do so under either license.
> > > + *
> > > + *  GPL LICENSE SUMMARY
> > > + *
> > > + *  Copyright(c) 2015-17 Intel Corporation.
> > > + *
> > > + *  This program is free software; you can redistribute it and/or modify
> > > + *  it under the terms of version 2 of the GNU General Public License as
> > > + *  published by the Free Software Foundation.
> > > + *
> > > + *  This program is distributed in the hope that it will be useful, but
> > > + *  WITHOUT ANY WARRANTY; without even the implied warranty of
> > > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > > + *  General Public License for more details.
> > > + *
> > > + *  BSD LICENSE
> > > + *
> > > + *  Copyright(c) 2015-17 Intel Corporation.
> > > + *
> > > + *  Redistribution and use in source and binary forms, with or without
> > > + *  modification, are permitted provided that the following conditions
> > > + *  are met:
> > > + *
> > > + *    * Redistributions of source code must retain the above copyright
> > > + *      notice, this list of conditions and the following disclaimer.
> > > + *    * Redistributions in binary form must reproduce the above copyright
> > > + *      notice, this list of conditions and the following disclaimer in
> > > + *      the documentation and/or other materials provided with the
> > > + *      distribution.
> > > + *    * Neither the name of Intel Corporation nor the names of its
> > > + *      contributors may be used to endorse or promote products derived
> > > + *      from this software without specific prior written permission.
> > > + *
> > > + *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> > > + *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> > > + *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
> > > + *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
> > > + *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> > > + *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> > > + *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> > > + *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> > > + *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> > > + *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> > > + *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> > 
> > Are you _sure_ that code that interacts with the driver core can have a
> > dual-license here?  Have you explained to lawyers what you are doing
> > here (wrapping gpl-only symbols with non-gpl-only exports)?
> 
> Sorry, the intention is not to wrap gpl symbols for non-gpl-only exports.
> 
> > And why dual license something that will only ever work on Linux?
> 
> We have non Linux users (mostly RTOS folks) which we would like to support
> with as much as common code.

Note, you need to be VERY CAREFUL about doing this.  You need to have
all sorts of infrastructure set up and in place and paperwork up the
wazoo in order to make it work properly.

In the end, I can almost guarantee it will not be worth the extra hassle
and effort you are trying to do here.

Seriously, go talk to your managers and corporate lawyer about this, you
are in for a world of hurt if you want to do this in a way that actually
works (i.e. doesn't just degrade to GPLv2 only instantly.)

I recommend not doing this unless you have money to burn.  If you do,
then great!  If not, it is much easier just to have two separate code
repos.

> > And finally, put a real SPDX header up there so that people don't have
> > to parse that horrid amount of text to try to determine exactly what
> > that license is.
> 
> Sorry for confusion, For the record we are trying to do Dual GPL v2/ BSD 3
> clause here. Can you give me example of SPDX use. I will be gald to use that

I could give you an example, but you need to get the real marking from
your company as I am not the one to pick it for you :)

> > > +struct bus_type sdw_bus_type = {
> > > +	.name = "soundwire",
> > > +	.match = sdw_bus_match,
> > > +	.uevent = sdw_uevent,
> > > +};
> > > +EXPORT_SYMBOL(sdw_bus_type);
> > 
> > EXPORT_SYMBOL_GPL()?
> 
> This can be EXPORT_SYMBOL_GPL as non Linux users wont have this. But then
> would it be to okay to have a module with some symbols _GPL and some non
> _GPL (the SoundWire protocol ones would need to be non GPL)

Again, don't even try to do that, it's not going to work.

The only team I know that ever has done this successfully is the core
ACPI code.  Go talk to them about the work involved in doing this
properly to see if you are willing to do that.

good luck!

greg k-h
