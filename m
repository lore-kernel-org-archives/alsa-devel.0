From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Zoom R16/24 playback slient
Date: Wed, 30 Sep 2015 23:44:28 +0200
Message-ID: <alpine.DEB.2.02.1509302257330.24705@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.02.1509292156390.6263@lnxricardw1.se.axis.com>
 <560B8481.1080304@laiskiainen.org>
 <alpine.DEB.2.02.1509300955510.12892@lnxricardw1.se.axis.com>
 <560B9EA9.2090304@laiskiainen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E30826627C
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 23:44:33 +0200 (CEST)
In-Reply-To: <560B9EA9.2090304@laiskiainen.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Panu Matilainen <pmatilai@laiskiainen.org>
Cc: =?ISO-8859-15?Q?Ricard_Wanderl=F6f?= <ricardw@axis.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On Wed, 30 Sep 2015, Panu Matilainen wrote:

> >> Another finding from my last round in the spring I do remember clearly,
> >> is that enabling both the input and output interfaces makes things hang
> >> up (timeouts and nothing really works). But if you disable the input
> >> interface and enable the output interface, you get an apparently worki=
ng
> >> playback stream. Only no sound comes out. If you disable the output and
> >> enable input, capture itself works fine.

I did a small bit of experimenting, and as far as I can tell, playback =

seems to hang the device so it becomes completely unresponsive and needs =

to be restarted.

What I did was change QUICK_IGNORE_INTERFACE to =

QUIRK_AUDIO_STANDARD_INTERFACE for ifnum 1 (playback) in the quirks table.

What happens here is that if I attmempt to aplay a file that is 10.5 =

seconds long, it actually plays for about 16 seconds, but no sound comes =

out. If I attempt it again, it takes about 5 seconds, after which I get =

aplay: set_params:1297: Unable to install hw params: <dump of attempted =

parameter settings>. There is no error message the first time.

The problem is the same no matter if I have IGNORE_INTERFACE set for ifnum =

2 (capture) or not. Setting both ifnum 1 and 2 to AUDIO_STANDARD_INTERFACE =

still results in capture to work as expected.

Interestingly enough, if I instrument the call to pcm:set_params(), it =

seems to get called as soon as the device is plugged in, with no ill =

effects. The sample rate display on the R16 also changes from 96.0 kHz to =

44.1 kHz. I don't seem to remember it doing this the first times I plugged =

it in, but the behavior remains after rebooting my computer, so it doesn't =

seem to be anything cached or something like that.

The problem doesn't seem to be in set_params(), as I can tell by adding =

delays that the unit freezes well after calling this function.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
