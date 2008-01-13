From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: -mm:
	pnp-do-not-stop-start-devices-in-suspend-resume-path.patch
	breaks resuming isapnp cards
Date: Sat, 12 Jan 2008 22:50:42 -0700
Message-ID: <200801122250.44220.bjorn.helgaas@hp.com>
References: <200801092343.48726.linux@rainbow-software.org>
	<200801122008.10313.rjw@sisk.pl> <47891E21.8060209@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from g1t0027.austin.hp.com (g1t0027.austin.hp.com [15.216.28.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 639D424909
	for <alsa-devel@alsa-project.org>; Sun, 13 Jan 2008 06:53:32 +0100 (CET)
In-Reply-To: <47891E21.8060209@keyaccess.nl>
Content-Disposition: inline
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
Cc: Andrew Morton <akpm@osdl.org>, ALSA development <alsa-devel@alsa-project.org>, Ondrej Zary <linux@rainbow-software.org>, Takashi Iwai <tiwai@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@suse.cz>, Pierre Ossman <drzeus@drzeus.cx>, linux-pm@lists.linux-foundation.org
List-Id: alsa-devel@alsa-project.org

On Saturday 12 January 2008 1:08:01 pm Rene Herman wrote:
> pnp-do-not-stop-start-devices-in-suspend-resume-path.patch in current -mm
> breaks resuming isapnp cards from hibernation. They need the pnp_start_dev
> to enable the device again after hibernation.
>
> They don't really need the pnp_stop_dev() which the above mentioned patch
> also removes but with the pnp_start_dev() restored it seems pnp_stop_dev()
> should also stay. Bjorn Helgaas should decide  -- currently the patch as
> you have it breaks drivers though. Could you drop it?

Yes, please drop pnp-do-not-stop-start-devices-in-suspend-resume-path.patch
for now.

When the PNP core requested resources for active devices, the
pnp_stop_dev() in the suspend path released the PNP core resources,
leaving the underlying driver resources orphaned.  But the patch
that made the PNP core request those resource is also gone, so
we can leave the start/stop alone.

> On 12-01-08 20:08, Rafael J. Wysocki wrote:
> > On Saturday, 12 of January 2008, Rene Herman wrote:
> >> It seems all PnP drivers would need to stick a pnp_start_dev in their
> >> resume method
> >
> > Yes.
> >
> >> then which means it really belongs in core.
> >
> > Yes, if practical.
> >
> >> One important point where PnP and PCI differ is that PnP allows to
> >> change the resources on a protocol level and I don't see how it could
> >> ever not be necessary to restore the state a user may have set if power
> >> has been removed. Hibernate is just that, isn't it?

That's a good point, thanks for pointing that out.

Bjorn
