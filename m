From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Softvol only after device has opened
Date: Tue, 9 Jun 2015 16:45:32 +0200
Message-ID: <alpine.DEB.2.02.1506091644110.15001@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.02.1506091304020.15001@lnxricardw1.se.axis.com>
 <5576D38C.4030907@ladisch.de>
 <alpine.DEB.2.02.1506091416530.15001@lnxricardw1.se.axis.com>
 <5576DA39.7090105@ladisch.de>
 <alpine.DEB.2.02.1506091428130.15001@lnxricardw1.se.axis.com>
 <5576DE6B.4050301@ladisch.de>
 <alpine.DEB.2.02.1506091632010.15001@lnxricardw1.se.axis.com>
 <s5h4mmhoskw.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id B82412606C9
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2015 16:45:33 +0200 (CEST)
In-Reply-To: <s5h4mmhoskw.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org


On Tue, 9 Jun 2015, Takashi Iwai wrote:

> > > Have a look at /var/lib/asound.state.  "alsactl store" marks any user-
> > > space controls; when "alsactl restore" sees this flag, it will explic=
itly
> > > recreate the control.
> > =

> > And there is no other way to recreate the control using an application =

> > than to use alsactl then?
> =

> There is other way, of course.  It's no magic.  alsactl just creates a
> user-space control element using the normal API.

Yes, of course that's doable, I was wondering if there's some other =

application that I don't know about that could do it. I.e. if there's a =

startup script that normally uses amixer to set up default settings, is it =

possible to add something to that script rather than to write a separate =

application to create the user control, which of course is doable too.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
