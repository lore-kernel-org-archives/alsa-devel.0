From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Still unhappy with removal of DXS controls
Date: Tue, 6 Jul 2010 06:25:19 +0800
Message-ID: <AANLkTikO0_N2ip9bc-EDTLYiQ3btSg8yHNAgEmwd_8-f@mail.gmail.com>
References: <4C3234C1.2060901@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6FD1510381D
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Jul 2010 00:25:22 +0200 (CEST)
Received: by vws9 with SMTP id 9so3136006vws.38
	for <alsa-devel@alsa-project.org>; Mon, 05 Jul 2010 15:25:20 -0700 (PDT)
In-Reply-To: <4C3234C1.2060901@gmx.de>
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

2010/7/6 Soeren D. Schulze <soeren.d.schulze@gmx.de>

> [Sorry if this is a duplicate -- I was too stupid to subscribe the first
> time and my mail hasn't been moderated yet, apparently.]
>
> Me again...
>
> Referring to the issue I described on 2010-03-28
> [http://www.spinics.net/lists/alsa-devel/msg32731.html], the situation
> hasn't changed since then.
>
> In short, I *really* need to lower the DXS volumes in order to play
> sound properly.  If I don't do it, I get massive distortion.
>
> It's not a matter of the output stage, but of the input stage.  Lowering
> PCM or Master doesn't help anything, but using softvol in mplayer does
> (I need to get down to 20%, so I effectively hear 14-bit audio, nice...).
>


In theory , DSP can also provide gain in addition to atten, so the maximum
volume may not be 0dB. you may need to calibrate the dB scale of this
control and set the default value to 0dB to prevent distortion due to
clipping.

I don't think mplayer know how to change these IFACE_PCM volume control
since only less than 10 sound cards support this hardware feature and only
three drivers have implemented this control


> S=F6ren
>
