From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Roland/Edirol M-16DX
Date: Sat, 24 Oct 2015 07:51:31 +0200
Message-ID: <alpine.DEB.2.02.1510240745580.3097@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.02.1510231017080.14239@lnxricardw1.se.axis.com>
 <562A136E.3030108@ladisch.de>
 <alpine.DEB.2.02.1510231640080.14239@lnxricardw1.se.axis.com>
 <562A4D7E.6040401@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 51CF5265755
 for <alsa-devel@alsa-project.org>; Sat, 24 Oct 2015 07:51:36 +0200 (CEST)
In-Reply-To: <562A4D7E.6040401@ladisch.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On Fri, 23 Oct 2015, Clemens Ladisch wrote:

> Ricard Wanderlof wrote:
> > On Fri, 23 Oct 2015, Clemens Ladisch wrote:
> >> Ricard Wanderlof wrote:
> >>> meaning that a device like the M-16DX should function as expected als=
o for
> >>> playback?
> >>
> >> There is some bug in the code that should detect such Roland devices.
> >
> > I'm not sure what you mean, is there a bug that fails to detect when it=
 is
> > necessary to use implcit feedback specifically when using Roland device=
s?
> =

> Yes.

Sounds like something that shouldn't be too hard to fix given a device =

at hand as well as a couple of hours of debugging time then.

Any more ideas of what the problem is? E.g. because for whatever reason =

it's not enough to have an entry in the quirks table, or something else =

completely (like the number of capture and playback channels being =

different)?

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
