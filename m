From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: [PATCH 1/2] amidi: ignore not only Active Sensing
 but all System Real-Time messages
Date: Mon, 11 Apr 2016 16:18:25 +0200
Message-ID: <alpine.DEB.2.02.1604111615550.9999@lnxricardw1.se.axis.com>
References: <570AA980.3070802@ladisch.de>
 <alpine.DEB.2.02.1604110858100.9999@lnxricardw1.se.axis.com>
 <570BA6B1.8060101@ladisch.de>
 <alpine.DEB.2.02.1604111535500.9999@lnxricardw1.se.axis.com>
 <570BB0F4.2020504@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id EDF8D2604D6
 for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2016 16:18:32 +0200 (CEST)
In-Reply-To: <570BB0F4.2020504@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Martin Tarenskeen <m.tarenskeen@zonnet.nl>
List-Id: alsa-devel@alsa-project.org


On Mon, 11 Apr 2016, Clemens Ladisch wrote:

> >> Filtering out clock messages serves an actual need.  But I am not
> >> willing to add complexity for a problem that is, at the moment, nothing
> >> but a figment of our imaginations.
> >
> > My argument is really that currently amidi has an option for filtering =
out
> > active sensing, which has probably been added as it serves a useful
> > purpose in its own right. The patch replaces that filter with one that
> > filters out everything from F8 (clock) and up
> =

> I consider this change a bug fix; I just forgot about clock messages
> when I originally impemented the filter.

Fair enough, although regardless of the original intention, the current =

version is out there (although I honestly haven't checked how long the =

filtering option has been available, perhaps it's not that long), and it's =

not buggy in the sense that it does what the corresponding (long) option =

says it will do.

> > I think it would be better to keep the existing option, and add a new
> > one, rather than to essentially change the meaning of the existing
> > option.
> =

> That would be a new feature.

Yes.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
