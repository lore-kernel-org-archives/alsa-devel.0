From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: PNP_DRIVER_RES_DISABLE breaks swsusp at least with
	snd_cs4236
Date: Fri, 11 Jan 2008 19:40:18 +0100
Message-ID: <200801111940.22023.linux@rainbow-software.org>
References: <200801092343.48726.linux@rainbow-software.org>
	<20080111080141.75aaad5f@poseidon.drzeus.cx>
	<47877B83.5040604@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.gsystems.sk (ns.gsystems.sk [62.176.172.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 461CF24629
	for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2008 20:07:30 +0100 (CET)
In-Reply-To: <47877B83.5040604@keyaccess.nl>
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
Cc: Andrew Morton <akpm@osdl.org>, ALSA development <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>, Pierre Ossman <drzeus@drzeus.cx>, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: alsa-devel@alsa-project.org

On Friday 11 January 2008 15:21:55 Rene Herman wrote:
> On 11-01-08 08:01, Pierre Ossman wrote:
> > On Fri, 11 Jan 2008 02:19:07 +0100
> >
> > Rene Herman <rene.herman@keyaccess.nl> wrote:
> >> I see a PnP resume _consists_ of setting the resources so I can see the
> >> test implementation wise, but yes, conceptually it seems this test
> >> shouldn't be present. So just like the attached then?
> >>
> >> Pierre, what was the idea here? Added the other SOBs to the CC as
> >> well...
> >
> > You assume there was an idea? ;)
> >
> > I don't remember why things were done the way they were. And I can't find
> > any clues in the correspondence around the issue. So your guess is as
> > good as mine.
>
> Hrmpf. Well, okay. Ondrej -- I assume this patch fixes things?

Yes, it works fine.
3c509 card still does not work after resume, but that looks like another 
problem.

-- 
Ondrej Zary
