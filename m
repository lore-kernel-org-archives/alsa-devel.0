From: krzysztof.h1@poczta.fm
Subject: Re: [REPOST] opti93x: conversion to use cs4231 library
Date: 07 Feb 2008 08:18:24 +0100
Message-ID: <20080207071824.E8F7697A829@f43.poczta.interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.poczta.interia.pl (smtp35.poczta.interia.pl [80.48.65.35])
	by alsa0.perex.cz (Postfix) with ESMTP id D276F2453A
	for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2008 08:18:30 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>, Takashi Iwai <tiwai@suse.de>, Krzysztof Helt <krzysztof.h1@poczta.fm>, Alsa-devel <alsa-devel@alsa-project.org>, Massimo Piccioni <alsa@piccio.org>
List-Id: alsa-devel@alsa-project.org

Rene Herman napisa=B3(a):
> On 30-01-08 01:43, Rene Herman wrote:
> =

> > 931 and 933 work and 930 (a non-PnP chip) is being a royal pain in the =

> > ass again. With the new code, I haven&#039;t yet been able to get it to=
 work
> =

> > -- no IRQ is firing. However, I also experienced this _once_ with the =

> > old driver so I&#039;m not sure what&#039;s going on. When I now try to=
 reproduce
> =

> > with the old one, I can&#039;t. Maybe a timing difference.
> > =

> > Will need further testing -- I have no time in the next few days.
> =

> Hate it but will need to confirm that this is definitely a regression.
> OPTi
> 82C930A does not work with the cs4231-lib using driver, does work with
> the
> current driver. It loads, but gets no interrupts.
> =


Thank you for testing. If it works with the old driver I will analyze what
the old driver does for opti930.

Thanks again,
Krzysztof


----------------------------------------------------------------------
Zmus swojego faceta, zeby to przeczytal
Kliknij >>> http://link.interia.pl/f1ceb
