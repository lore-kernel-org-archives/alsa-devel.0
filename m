From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: [PATCH] ALSA: USB-audio: Add support for Novation
 Nocturn MIDIcontrol surface
Date: Sun, 18 Oct 2015 08:30:07 +0200
Message-ID: <alpine.DEB.2.02.1510180827050.24963@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.02.1510161332480.4075@lnxricardw1.se.axis.com>
 <56212516.2050003@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id D5259261518
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2015 08:30:11 +0200 (CEST)
In-Reply-To: <56212516.2050003@ladisch.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Ricard at home <ricard2005@butoba.net>
List-Id: alsa-devel@alsa-project.org


On Fri, 16 Oct 2015, Clemens Ladisch wrote:

> Ricard Wanderlof wrote:
> > I've noticed that checkpatch complains about the space between the & an=
d (,
> > but in the interest of consistency I've not changed this. Is there some
> > reason for the space
> =

> Yes.   But it's not a particularly substantial reason,

... and what is it pray tell ...? ;-)

> and you're not the first person to mention this checkpatch complaint, so =

> feel free to kill them.
> =

> > would it be worth while cleaning up the file?
> =

> Yes, it would be worth while cleaning up the file by restoring the
> proper VID/PID order of the entries.  :)

I hadn't even noticed that. I suppose it does not really make that much of =

a difference, as if you're looking for a specific device you'd just do an =

ordinary search through the file. But of course it makes sense if nothing =

else as it makes it clear exactly where to add a new entry.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
