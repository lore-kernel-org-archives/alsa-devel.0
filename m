From: "Michael Bourgeous" <sts.nitrogen@gmail.com>
Subject: Re: [Pkg-alsa-devel] Bug#436502: alsa-tools ->
	usx2yloader
Date: Thu, 13 Sep 2007 02:23:36 -0600
Message-ID: <8e4fc8270709130123x39b33a1fkd4dae9d018bb4c65@mail.gmail.com>
References: <20070911152102.GA17585@frodo.home.lxtec.de>
	<20070912205256.GR4125@frodo.home.lxtec.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_28165_24101438.1189671816222"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 39AB3244AC
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Sep 2007 10:23:37 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id f40so443501fka
	for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2007 01:23:36 -0700 (PDT)
In-Reply-To: <20070912205256.GR4125@frodo.home.lxtec.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pkg-alsa-devel@lists.alioth.debian.org, alsa-devel <alsa-devel@alsa-project.org>, Karsten Wiese <annabellesgarden@yahoo.de>, 436502@bugs.debian.org
List-Id: alsa-devel@alsa-project.org

------=_Part_28165_24101438.1189671816222
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 9/12/07, Elimar Riesebieter <riesebie@lxtec.de> wrote:
>
> Attached is a patch for the Makefiles and an udev rule which should
> work anyway. I don't have TASCAM US-122 usb hardware handy, so
> I would be very pleased if someone could test it.
>
> Thanks
>
> Elimar
>

I can't remember for sure, but the included rules file might have
problems loading the us428control program.  I think there might have
been problems I encountered with using the tascam_fpga script directly
from udev, since us428control doesn't self-daemonize.  I'll attach the
.rules file that I use, which might be useful as an example to fix the
.rules file provided already if it's found that there are problems
with udev and the existing tascam_fpga script.  As I recall, since
us428control was still holding on to its stdout, udev would hang and
not load any devices after the US-428.

A better option might be a patch to us428control to add a daemonize
switch (which, of course, could be as simple as fclose()-ing stdin,
stdout, and stderr, and dealing with any I/O functions accordingly).

Mike Bourgeous

------=_Part_28165_24101438.1189671816222
Content-Type: application/octet-stream; name="55-tascam.rules"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="55-tascam.rules"
X-Attachment-Id: f_f6izmglw

IyBUYXNjYW0gVVMteDJ5IEZpcm13YXJlIFNjcmlwdCBieSBNaWtlIEJvdXJnZW91cyA8aV9hbV9u
aXRyb2dlbiBhdCBob3RtYWlsLmNvbT4KIyBCYXNlZCBvbiBodHRwOi8vd3d3LmFzdHJvLmNhbHRl
Y2guZWR1L35tY3MvdGFzY2FtX3VzMTIyL2luZGV4Lmh0bWwKCiMjIyBVUy00MjggIyMjCiMgTG9h
ZCBmaXJtd2FyZSAjCkJVUz09InVzYiIsIEFDVElPTj09ImFkZCIsIFNZU0ZTe2lkUHJvZHVjdH09
PSI4MDAwIiwgU1lTRlN7aWRWZW5kb3J9PT0iMTYwNCIsIFwKCVJVTis9Ii9iaW4vc2ggLWMgJy9z
YmluL2Z4bG9hZCAtdnYgLUQgJU4gLXMgL3Vzci9zaGFyZS9hbHNhL2Zpcm13YXJlL3VzeDJ5bG9h
ZGVyL3Rhc2NhbV9sb2FkZXIuaWh4IC1JIC91c3Ivc2hhcmUvYWxzYS9maXJtd2FyZS91c3gyeWxv
YWRlci91czQyOGZ3LmloeCciCiMgTG9hZCBmcGdhICMKQlVTPT0idXNiIiwgQUNUSU9OPT0iYWRk
IiwgU1lTRlN7aWRQcm9kdWN0fT09IjgwMDEiLCBTWVNGU3tpZFZlbmRvcn09PSIxNjA0IiwgXAoJ
UlVOKz0iL2Jpbi9zaCAtYyAnL3Vzci9iaW4vdXN4Mnlsb2FkZXIgOyAvdXNyL2Jpbi91czQyOGNv
bnRyb2wmJyIKCiMjIyBVUy0yMjQgIyMjCiMgTG9hZCBmaXJtd2FyZSAjCkJVUz09InVzYiIsIEFD
VElPTj09ImFkZCIsIFNZU0ZTe2lkUHJvZHVjdH09PSI4MDA0IiwgU1lTRlN7aWRWZW5kb3J9PT0i
MTYwNCIsIFwKCVJVTis9Ii9iaW4vc2ggLWMgJy9zYmluL2Z4bG9hZCAtdnYgLUQgJU4gLXMgL3Vz
ci9zaGFyZS9hbHNhL2Zpcm13YXJlL3VzeDJ5bG9hZGVyL3Rhc2NhbV9sb2FkZXIuaWh4IC1JIC91
c3Ivc2hhcmUvYWxzYS9maXJtd2FyZS91c3gyeWxvYWRlci91czIyNGZ3LmloeCciCiMgTG9hZCBm
cGdhICMKQlVTPT0idXNiIiwgQUNUSU9OPT0iYWRkIiwgU1lTRlN7aWRQcm9kdWN0fT09IjgwMDUi
LCBTWVNGU3tpZFZlbmRvcn09PSIxNjA0IiwgXAoJUlVOKz0iL2Jpbi9zaCAtYyAnL3Vzci9iaW4v
dXN4Mnlsb2FkZXInIgoKIyMjIFVTLTEyMiAjIyMKIyBMb2FkIGZpcm13YXJlICMKQlVTPT0idXNi
IiwgQUNUSU9OPT0iYWRkIiwgU1lTRlN7aWRQcm9kdWN0fT09IjgwMDYiLCBTWVNGU3tpZFZlbmRv
cn09PSIxNjA0IiwgXAoJUlVOKz0iL2Jpbi9zaCAtYyAnL3NiaW4vZnhsb2FkIC12diAtRCAlTiAt
cyAvdXNyL3NoYXJlL2Fsc2EvZmlybXdhcmUvdXN4Mnlsb2FkZXIvdGFzY2FtX2xvYWRlci5paHgg
LUkgL3Vzci9zaGFyZS9hbHNhL2Zpcm13YXJlL3VzeDJ5bG9hZGVyL3VzMTIyZncuaWh4JyIKIyBM
b2FkIGZwZ2EgIwpCVVM9PSJ1c2IiLCBBQ1RJT049PSJhZGQiLCBTWVNGU3tpZFByb2R1Y3R9PT0i
ODAwNyIsIFNZU0ZTe2lkVmVuZG9yfT09IjE2MDQiLCBcCglSVU4rPSIvYmluL3NoIC1jICcvdXNy
L2Jpbi91c3gyeWxvYWRlciciCgoK
------=_Part_28165_24101438.1189671816222
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_28165_24101438.1189671816222--
