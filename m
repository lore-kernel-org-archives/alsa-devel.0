From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Softvol only after device has opened
Date: Tue, 9 Jun 2015 16:32:35 +0200
Message-ID: <alpine.DEB.2.02.1506091632010.15001@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.02.1506091304020.15001@lnxricardw1.se.axis.com>
 <5576D38C.4030907@ladisch.de>
 <alpine.DEB.2.02.1506091416530.15001@lnxricardw1.se.axis.com>
 <5576DA39.7090105@ladisch.de>
 <alpine.DEB.2.02.1506091428130.15001@lnxricardw1.se.axis.com>
 <5576DE6B.4050301@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id AEFEC26067D
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2015 16:32:38 +0200 (CEST)
In-Reply-To: <5576DE6B.4050301@ladisch.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On Tue, 9 Jun 2015, Clemens Ladisch wrote:

> Ricard Wanderlof wrote:
> > What I was getting at was that although I can't do:
> >
> > $ amixer sset Capture 192
> >
> > if Capture is defined by the softvol plugin, and I haven't opened the
> > device prior to running amixer, however
> >
> > $ alsactl restore 0:
> >
> > works, assuming that I've saved the settings previously, even before the
> > device is opened. I can understand that this is very useful and desired,
> > but given that the underlying control does not yet exist, it puzzles me
> > that it actually works.
> =

> Have a look at /var/lib/asound.state.  "alsactl store" marks any user-
> space controls; when "alsactl restore" sees this flag, it will explicitly
> recreate the control.

And there is no other way to recreate the control using an application =

than to use alsactl then?

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
