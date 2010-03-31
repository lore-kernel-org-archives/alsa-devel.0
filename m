From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Handling of the DXS controls in the via82xx driver
Date: Thu, 1 Apr 2010 07:00:59 +0800
Message-ID: <j2o4f3252891003311600g2f5b1579i5b634637f1da5e02@mail.gmail.com>
References: <4BAE8EF7.20204@gmx.de>
	<1269867371.6760.1367253675@webmail.messagingengine.com>
	<4BB0A970.7020600@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B086E10380C
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Apr 2010 01:01:00 +0200 (CEST)
Received: by pwj7 with SMTP id 7so592124pwj.38
	for <alsa-devel@alsa-project.org>; Wed, 31 Mar 2010 16:00:59 -0700 (PDT)
In-Reply-To: <4BB0A970.7020600@gmx.de>
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

2010/3/29 Soeren D. Schulze <soeren.d.schulze@gmx.de>

> Clemens Ladisch wrote:
> >> The bad thing about it is that 31,31 is a really bad setting for my
> >> poorly engineered sound card.  It distorts a lot.
> >
> > If the card cannot handle any loud output, then all outputs from any
> > source must be restricted, so the logical place for lower volume would
> > be the "Master" or "PCM" controls.
>
> The problem is rather that it cannot handle loud *input*.  With loud
> input from digital plus the respective DXS lever on high volume, it
> apparently overdrives at a very early stage in the sound card.  Master
> and PCM do not help anything any more.
>
> The other workaround would probably be using softvol for reducing the
> volume before it enters analog, but lowering the DXS levers is still
> better IMHO.
>
>
> Thank you
>
> S=F6ren
>
>
did you set those per voice volume control to 0dB ?

try to play a sine wave of full amplitude and record using analog loopback
of ac97 codec and audacity to find out whether the sine wave is clipped
