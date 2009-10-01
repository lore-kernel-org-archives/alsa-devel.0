From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: [PATCH] ascenario: Add scenario support to alsa-lib
Date: Thu, 1 Oct 2009 15:38:13 +0200
Message-ID: <20091001133813.GB5936@excalibur.local>
References: <1254390436-5283-1-git-send-email-stefan@datenfreihafen.org>
	<1254390436-5283-2-git-send-email-stefan@datenfreihafen.org>
	<20091001122835.GC14417@sirena.org.uk>
	<20091001131948.GA5936@excalibur.local>
	<20091001132417.GA26663@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirius.lasnet.de (sirius.lasnet.de [78.47.116.19])
	by alsa0.perex.cz (Postfix) with ESMTP id 5646210395A
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 15:38:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20091001132417.GA26663@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Stefan Schmidt <stefan@slimlogic.co.uk>, Ian Molton <ian@mnementh.co.uk>, Graeme Gregory <gg@slimlogic.co.uk>, Stefan Schmidt <stefan@datenfreihafen.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hello.

On Thu, 2009-10-01 at 14:24, Mark Brown wrote:
> On Thu, Oct 01, 2009 at 03:19:48PM +0200, Stefan Schmidt wrote:
> > On Thu, 2009-10-01 at 13:28, Mark Brown wrote:
> 
> > > > +/** Scenario ID's
> > > > + *
> > > > + * Standard Scenario ID's - Add new scenarios at the end.
> > > > + */
> 
> > > Extra 's here.
> 
> > That way?
> > /**
> >  * Scenario ID's
> >  *
> >  * Standard Scenario ID's - Add new scenarios at the end.
> >  */
> 
> There shouldn't be any 's in the above at all ("Scenarios IDs" instead),
> those are just plain plurals - just a trivial grammar nit.

Ah, non-native speaker problem. :) Fixed.

> > > I guess the idea is that in the future this will be removed and the
> > > scenario API will use inotify or similar to pick up changes.
> 
> > Indeed. Certainly a Todo item for later enhancements. Do you guys prefer such
> > todo items in the code or noted somewhere else?
> 
> I have no great preference either way.

Hmm, will think about it.

regards
Stefan Schmidt
