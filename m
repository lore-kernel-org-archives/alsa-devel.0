From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/3] PNP cleanups - Unify the pnp macros to
	access	resources in the pnp resource table
Date: Tue, 20 Nov 2007 17:48:04 +0100
Message-ID: <1195577284.23700.211.camel@queen.suse.de>
References: <1195552283.23700.166.camel@queen.suse.de>
	 <20071120123102.03bdaa67@the-village.bc.nu>
	 <1195568360.23700.202.camel@queen.suse.de>  <4742EFBE.6030407@keyaccess.nl>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760993AbXKTQsT@vger.kernel.org>
In-Reply-To: <4742EFBE.6030407@keyaccess.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, "Li, Shaohua" <shaohua.li@intel.com>, "yakui.zhao" <yakui.zhao@intel.com>, akpm <akpm@linux-foundation.org>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2007-11-20 at 15:31 +0100, Rene Herman wrote:
> On 20-11-07 15:19, Thomas Renninger wrote:
> 
> > At the end is some example code how things could get even more cleaned
> > up. It shows how I think pnp layer and one example driver would get
> > adjusted. There are not that much drivers making use of
> > pnp_resource_change...
> 
> The ALSA ISA-PnP drivers do in what I personally consider a bad layering 
> violation. Brought up not doing that a while ago on alsa-devel, but no 
> discussion ensued. If the PnP maintainer(s) agree with me though, I'd be 
> more than happy to rip all of that out of ALSA.
> 
> (added alsa-devel)

The pnp_resource_change is really ugly..., these are making use of it:
sound/isa/sb/es968.c
sound/isa/sb/sb16.c
sound/isa/gus/interwave.c
sound/isa/es18xx.c
sound/isa/cs423x/cs4236.c
sound/isa/wavefront/wavefront.c
sound/isa/ad1816a/ad1816a.c
sound/isa/cmi8330.c
sound/isa/opl3sa2.c
sound/isa/opti9xx/opti92x-ad1848.c
sound/isa/als100.c
sound/isa/azt2320.c
sound/isa/dt019x.c


   Thomas
