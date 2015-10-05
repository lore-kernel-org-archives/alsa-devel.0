From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Boss GT-001
Date: Mon, 5 Oct 2015 16:38:55 +0200
Message-ID: <alpine.DEB.2.02.1510051635560.19610@lnxricardw1.se.axis.com>
References: <1481883.Y22cmGKEIB@kamdesktop> <90207636.43oDPcFcXs@kamdesktop>
 <2448573.QHGoo2Q6JJ@kamdesktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E7292605B8
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2015 16:38:56 +0200 (CEST)
In-Reply-To: <2448573.QHGoo2Q6JJ@kamdesktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "maillist@superlative.org" <maillist@superlative.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On Mon, 5 Oct 2015, maillist@superlative.org wrote:

> More follow up. I've upgraded the kernel to 4.0.0-040000-generic with no
> improvement. I've recompiled the usb sound modules with debug support and=
 am
> getting the following. Note that I'm getting a probe failure with error c=
ode
> -5. Is there any reference anywhere for what these errors are?

-5 would be an ordinary -E<foo> error code, looking in =

/usr/include/asm-generic/errno-base.h (ultimately from the kernel's =

uapi/asm-generic/errno-base.h) it would seem to be EIO (I/O error). Note =

too informative, but at least it'll stem from some 'return -EIO' or =

similar somewhere in the code. Must be some underlying function that is =

having problems.

> Oct  5 13:51:47 KAMDesktop kernel: [  910.586812] snd-usb-audio: probe of
> 3-1:1.0 failed with error -5

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
