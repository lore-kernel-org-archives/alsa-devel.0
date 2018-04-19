From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Sample format changes by plugin while playing
Date: Thu, 19 Apr 2018 16:34:15 +0200
Message-ID: <alpine.DEB.2.11.1804191626070.5586@lnxricardw1.se.axis.com>
References: <2f7e073c-b51a-dd7d-af89-9a10872faed1@gmx.de>
 <f022197f-4909-c901-b61f-cd8a197d46e8@gmx.de>
 <991e97ca-1176-c2a2-d376-a9c277334b03@ladisch.de>
 <c7d05205-7990-3720-b687-157167a7c350@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id D4E71267235
 for <alsa-devel@alsa-project.org>; Thu, 19 Apr 2018 16:34:22 +0200 (CEST)
In-Reply-To: <c7d05205-7990-3720-b687-157167a7c350@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Tiemann <rtie@gmx.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Thu, 19 Apr 2018, Robert Tiemann wrote:

> =

> On 04/19/2018 03:53 PM, Clemens Ladisch wrote:
> =

> >> Is it possible for an ALSA plugin to reconfigure the sample rate and
> >> sample format of its slave in such a way that the software playing
> >> through that plugin wouldn't notice?
> > =

> > In theory, yes.  But you'd have to implement most of this yourself.
> =

> That's fine, I just wanted to know if this could possibly work and if
> an ALSA plugin could be the right place for this kind of stuff. That
> is, before diving into development and hitting any roadblocks only
> much later.

I'm curious about this. Do you have a need to reconfigure the sample rate =

and format while a stream is playing? We had such a use case a while ago, =

where we had a source whose sample rate could change at any time, but ALSA =

sets up the stream configuration (sample rate etc) when the stream is =

opened (hw_params()) and it doesn't seem to be possible to reconfigure it =

on the fly. In the end we dropped the idea and solved the problem a =

different way.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
