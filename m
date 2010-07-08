From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Still unhappy with removal of DXS controls
Date: Thu, 8 Jul 2010 12:28:00 +0800
Message-ID: <AANLkTikG2-TJtVwxIK2MwQLx3buzZvN1nGsHMsx9Kf3p@mail.gmail.com>
References: <4C3234C1.2060901@gmx.de> <4C330752.3090201@ladisch.de>
	<4C33956B.1060600@gmx.de> <4C347A9B.608@ladisch.de>
	<4C349D8D.20707@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 91E97245EE
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Jul 2010 06:28:02 +0200 (CEST)
Received: by vws9 with SMTP id 9so572619vws.38
	for <alsa-devel@alsa-project.org>; Wed, 07 Jul 2010 21:28:00 -0700 (PDT)
In-Reply-To: <4C349D8D.20707@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/7/7 Soeren D. Schulze <soeren.d.schulze@gmx.de>

> On 07.07.2010 15:01, Clemens Ladisch wrote:
> > Soeren D. Schulze wrote:
> >> Is there a chance to get this upstream?
> >
> > Yes; would you be OK with this tag?
> >   Tested-by: Soeren D. Schulze <soeren.d.schulze@gmx.de>
>
> Yes; I didn't test it that extensively, but it seems to fix the problem.
>
> BTW, the value 24 is still too high if several streams are played at the
> same time.
>
>
> S=F6ren
>

It depend on how DSP mix several voices together ( up to our voices in this
case)
it DSP just add the amplitide of two voices , it may need some kind of
atten to prevent clipping
