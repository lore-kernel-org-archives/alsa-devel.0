From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: ALSA: USB-audio: Add quirk for Zoom R16/24 playback
Date: Mon, 2 Nov 2015 08:59:09 +0100
Message-ID: <alpine.DEB.2.02.1511020853170.1465@lnxricardw1.se.axis.com>
References: <5634E9B3.1030000@alciom.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id A5BEA260661
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2015 08:59:11 +0100 (CET)
In-Reply-To: <5634E9B3.1030000@alciom.be>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alain <alain.fyon@alciom.be>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On Sat, 31 Oct 2015, Alain wrote:

> First of all, sorry for my english I'm French speaking.
> Some time ago I was planning to buy a ZOOM R24 but after some research =

> on internet I saw that machine was not fully functional under linux.
> till some nice people took care with that problem.
> =

> As I can see, but i'm not sure, the problem is fixed
> Can you confirm me the ZOOM R16/24 is ok for 8 inputs/2 outputs  ?

Yes, it works, confirmed by me and another person.

As far as I know it hasn't been tested with the R24, only the R16. =

However, both devices present themselves with the same USB ID in Audio =

Interface mode, and so far everything indicates that they function =

identically in this mode.

> Is the next kernel version will  include the modifications? or should I =

> do the modifications (compliling kernel is a big chalenge for me) ?

If I understand correctly it is scheduled to be included in the next major =

kernel release (4.4).

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
