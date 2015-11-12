From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Roland/Edirol M-16DX
Date: Thu, 12 Nov 2015 08:58:00 +0100
Message-ID: <alpine.DEB.2.02.1511120851500.11990@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.02.1510231017080.14239@lnxricardw1.se.axis.com>
 <562A136E.3030108@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 9116F2608CF
 for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2015 08:58:02 +0100 (CET)
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
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

I finally got my hands on an M-16DX yesterday, and was preparing myself =

for some initial research into this problem. Connected the device and used =

some DAW software (Ardour 3) to record and playback about half a minute of =

audio. No glitches whatsoever, neither in capture or playback.

So I thought, perhaps a DAW always opens the device for recording and =

playback and hence there's always a feedback channel open. So I tried just =

playing back a 7 minute wav file using aplay instead. Again, no glitches =

in the resulting audio.

More tests are needed - I only used 44.1 kHz sample rate for instance - =

but have I just been extremely lucky with the sample clocks so they match =

up precisely (if that even would work), or could the problem have =

magically fixed itself (ok, more realistically, as a result of something =

else getting fixed)?

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
