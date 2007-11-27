From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/3] PNP cleanups - Unify the pnp macros	to
	access	resources in the pnp resource table
Date: Tue, 27 Nov 2007 17:34:51 +0100
Message-ID: <1196181292.23251.53.camel@queen.suse.de>
References: <1195552283.23700.166.camel@queen.suse.de>
	<20071120123102.03bdaa67@the-village.bc.nu>
	<1195568360.23700.202.camel@queen.suse.de>
	<4742EFBE.6030407@keyaccess.nl> <s5hejejj559.wl%tiwai@suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B3C924A57
	for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2007 17:34:55 +0100 (CET)
In-Reply-To: <s5hejejj559.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, "yakui.zhao" <yakui.zhao@intel.com>, "Li, Shaohua" <shaohua.li@intel.com>, akpm <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2007-11-21 at 10:53 +0100, Takashi Iwai wrote:
> At Tue, 20 Nov 2007 15:31:26 +0100,
> Rene Herman wrote:
> > 
> > On 20-11-07 15:19, Thomas Renninger wrote:
> > 
> > > At the end is some example code how things could get even more cleaned
> > > up. It shows how I think pnp layer and one example driver would get
> > > adjusted. There are not that much drivers making use of
> > > pnp_resource_change...
> > 
> > The ALSA ISA-PnP drivers do in what I personally consider a bad layering 
> > violation. Brought up not doing that a while ago on alsa-devel, but no 
> > discussion ensued. If the PnP maintainer(s) agree with me though, I'd be 
> > more than happy to rip all of that out of ALSA.
Rene: Could you do that, pls.
> 
> I'm fine with removal of that stuff now.  It was implemented in that
> way because there was no proper way to re-assign ISA PnP resources on
> 2.4 kernel time.  On 2.6, it makes no longer any sense (except for
> compatibility, but this is almost no problem for PnP boards).

I wasted some time on thinking about how this pnp_resource_change and
pnp_manual_config_dev could get workarounded..., but it's impossible
without changing the (more a workaround than an) interface.

If you worked on this already, would you mind ripping these out?

If I understand Takashi correctly, the driver code using
pnp_resource_change and pnp_manual_config_dev can simply be removed and
devices could get resources assigned via sysfs "set" interface.

Thanks,

   Thomas
