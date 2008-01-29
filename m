From: krzysztof.h1@poczta.fm
Subject: Re: [REPOST] opti93x: conversion to use cs4231 library
Date: 29 Jan 2008 08:09:45 +0100
Message-ID: <20080129070945.EA72C860C89@f35.poczta.interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.poczta.interia.pl (smtp35.poczta.interia.pl [80.48.65.35])
	by alsa0.perex.cz (Postfix) with ESMTP id D6B93245C1
	for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2008 08:09:48 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Krzysztof Helt <krzysztof.h1@poczta.fm>, Rene Herman <rene.herman@keyaccess.nl>, Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai napisa=B3(a):
> At Sat, 26 Jan 2008 10:44:11 +0100,
> Krzysztof Helt wrote:
> > =

> > From: Krzysztof Helt >krzysztof.h1@wp.pl>
> > =

> > This patch converts the Opti93x driver to use
> > the cs4231 library instead of just duplicating the code.
> > =

> > Signed-off-by: Krzysztof Helt >krzysztof.h1@wp.pl>
> =

> This causes a compile error for snd-opti92x-cs4231.  Also has some
> coding style issues.
> =

I am sorry for compilation error. I was sure I have tested compilation
of all opti versions but obviously not.

> The fixed patch is below.  Please let me know this and previous
> patches work so that I can push them to the upstream.
> =


I don't have previous patches but I have few patches which =

depends on these two I posted (e.g. 3d control for opti 933, more
coding style fixes).

I will post them after these two are merged to have stable reference
for diffs.

Regards,
Krzysztof



----------------------------------------------------------------------
Sprawdz, ktore komorki sa najmodniejsze!
Kliknij >>> http://link.interia.pl/f1cd4
