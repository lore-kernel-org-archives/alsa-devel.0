From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 02/14] soundwire: Add SoundWire bus type
Date: Fri, 20 Oct 2017 18:27:23 +0200
Message-ID: <20171020162723.GB6674@kroah.com>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-3-git-send-email-vinod.koul@intel.com>
 <20171020104528.GC3210@kroah.com>
 <CAOFm3uExqnB45SDFKJo811aaEfeaEC02TUdpmPj1Wq9QEWqy_g@mail.gmail.com>
 <20171020162042.GW30097@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171020162042.GW30097@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Philippe Ombredanne <pombredanne@nexb.com>, LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Takashi <tiwai@suse.de>, Pierre <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 20, 2017 at 09:50:42PM +0530, Vinod Koul wrote:
> On Fri, Oct 20, 2017 at 06:03:24PM +0200, Philippe Ombredanne wrote:
> > On Fri, Oct 20, 2017 at 12:45 PM, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > On Thu, Oct 19, 2017 at 08:33:18AM +0530, Vinod Koul wrote:
> > >> diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
> > >> new file mode 100644
> > >> index 000000000000..a14d1de80afa
> > >> --- /dev/null
> > >> +++ b/drivers/soundwire/bus_type.c
> > >> @@ -0,0 +1,229 @@
> > >> +/*
> > >> + *  This file is provided under a dual BSD/GPLv2 license.  When using or
> > >> + *  redistributing this file, you may do so under either license.
> > >> + *
> > >> + *  GPL LICENSE SUMMARY
> > >> + *
> > >> + *  Copyright(c) 2015-17 Intel Corporation.
> > >> + *
> > >> + *  This program is free software; you can redistribute it and/or modify
> > >> + *  it under the terms of version 2 of the GNU General Public License as
> > >> + *  published by the Free Software Foundation.
> > >> + *
> > >> + *  This program is distributed in the hope that it will be useful, but
> > >> + *  WITHOUT ANY WARRANTY; without even the implied warranty of
> > >> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > >> + *  General Public License for more details.
> > >> + *
> > >> + *  BSD LICENSE
> > >> + *
> > >> + *  Copyright(c) 2015-17 Intel Corporation.
> > >> + *
> > >> + *  Redistribution and use in source and binary forms, with or without
> > >> + *  modification, are permitted provided that the following conditions
> > >> + *  are met:
> > >> + *
> > >> + *    * Redistributions of source code must retain the above copyright
> > >> + *      notice, this list of conditions and the following disclaimer.
> > >> + *    * Redistributions in binary form must reproduce the above copyright
> > >> + *      notice, this list of conditions and the following disclaimer in
> > >> + *      the documentation and/or other materials provided with the
> > >> + *      distribution.
> > >> + *    * Neither the name of Intel Corporation nor the names of its
> > >> + *      contributors may be used to endorse or promote products derived
> > >> + *      from this software without specific prior written permission.
> > >> + *
> > >> + *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> > >> + *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> > >> + *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
> > >> + *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
> > >> + *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> > >> + *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> > >> + *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> > >> + *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> > >> + *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> > >> + *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> > >> + *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> > >
> > > Are you _sure_ that code that interacts with the driver core can have a
> > > dual-license here?  Have you explained to lawyers what you are doing
> > > here (wrapping gpl-only symbols with non-gpl-only exports)?
> > >
> > > And why dual license something that will only ever work on Linux?
> > >
> > > And finally, put a real SPDX header up there so that people don't have
> > > to parse that horrid amount of text to try to determine exactly what
> > > that license is.
> > 
> > Vinod:
> > 
> > It is hard to parse for people ... but it is quite hard for tools to catch
> > this too. This license notice is so peculiar and special that I had to
> > make a special detection rule just for it [1] in my tool :|
> > Please have mercy: could you not pick something simpler?
> 
> Sorry for the trouble it caused. The code is Dual license as indicated by
> first two lines. I didn't invent the text here, legal folks did and used
> the standard template available in my company
> 
> I quick grep on Dual license users looks like we already have this in kernel
> code. See drivers/ntb/hw/intel/ntb_hw_intel.c

Just because someone did something wrong in the past, doesn't mean they
should keep doing more wrong things in the future :)
