From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [RFC/PATCH] pxa2xx_ac97 and gpio reset line
Date: Sun, 15 Mar 2009 20:25:55 +0000
Message-ID: <20090315202554.GB7439@sirena.org.uk>
References: <87bpsb6dt1.fsf@free.fr> <20090308193138.GB18035@sirena.org.uk>
	<20090308194456.GC18035@sirena.org.uk> <878wn723si.fsf@free.fr>
	<20090314224648.GB6523@sirena.org.uk> <87d4cjghrp.fsf@free.fr>
	<20090315112638.GA7439@sirena.org.uk> <87hc1vezdr.fsf@free.fr>
	<9D6BA91B-5FD3-4EE4-ACAD-21C144198AA5@sirena.org.uk>
	<874oxvdj8h.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B20CE1037EB
	for <alsa-devel@alsa-project.org>; Sun, 15 Mar 2009 21:26:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <874oxvdj8h.fsf@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 15, 2009 at 02:10:54PM +0100, Robert Jarzmik wrote:
> Mark Brown <broonie@sirena.org.uk> writes:

> >> Should this be handled like a casual gpio (ie. gpio 99) ?
> > I'm not sure what you mean by a casual GPIO?

> I meant different from "special" gpios (ie. GPIO95 and GPIO113), which are
> "special" because they have an alternate function tied to AC97 reset.

Ah, I see - for reference, a more normal term would be something like
generic.  I didn't mean it was essential support them right now, just
that it'd be better to allow for them in the interface in case we need
the same workaround again.  But yes, this looks good - I've applied it,
thanks.
