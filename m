From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Roland/Edirol M-16DX
Date: Fri, 23 Oct 2015 16:44:57 +0200
Message-ID: <alpine.DEB.2.02.1510231640080.14239@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.02.1510231017080.14239@lnxricardw1.se.axis.com>
 <562A136E.3030108@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 852432619F5
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 16:44:59 +0200 (CEST)
In-Reply-To: <562A136E.3030108@ladisch.de>
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
Cc: =?ISO-8859-15?Q?Ricard_Wanderl=F6f?= <ricardw@axis.com>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On Fri, 23 Oct 2015, Clemens Ladisch wrote:

> Ricard Wanderlof wrote:
> > I seem to recall reading posts not to long ago that refer to using an
> > implicit feedback path; my question is, was this in fact implemented,
> =

> Yes, for USB Audio 2.0 devices.
> =

> > meaning that a device like the M-16DX should function as expected also =
for
> > playback?
> =

> There is some bug in the code that should detect such Roland devices.

I'm not sure what you mean, is there a bug that fails to detect when it is =

necessary to use implcit feedback specifically when using Roland devices?

So that when using an M-16DX despite the endpoint desciptor specifying =

Asynchronous and Implicit feedback it fails to enable that mode?

E.g. something related to the fact that these devices need entries in the =

quirks table rather than being class compliant?

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
