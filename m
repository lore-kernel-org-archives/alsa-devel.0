From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: wrong decibel data?
Date: Tue, 6 Apr 2010 09:46:14 +0800
Message-ID: <r2i4f3252891004051846xc6ef1834habaf4f9db3bdd384@mail.gmail.com>
References: <q2s98391a7b1004021121sde36d074m8a70acc142f95d93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A56ED103843
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Apr 2010 03:46:16 +0200 (CEST)
Received: by pwj7 with SMTP id 7so3173811pwj.38
	for <alsa-devel@alsa-project.org>; Mon, 05 Apr 2010 18:46:14 -0700 (PDT)
In-Reply-To: <q2s98391a7b1004021121sde36d074m8a70acc142f95d93@mail.gmail.com>
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

2010/4/3 Nicolo' Chieffo <nicolo.chieffo@gmail.com>

> Hello, I have a laptop with an intel hda audio chipset (STAC92xx)
>
> My problem is that when I put pulseaudio volume to 14% (or less) I
> can't hear any audio coming from speakers or headphones: in fact the
> alsamixer volume is set to 0%
>
> I already filed a bug to pulseaudio [1] in which the developers say
> that this is a common problem which is usually caused by the ALSA
> audio driver which reports a wrong decibel value.
>
> [1] http://pulseaudio.org/ticket/580
>
>
please provide the output of "amixer -D pulse" when you set the volume
control of alsamixer to (-3dB , -6dB , -12 dB , -24 dB and -48dB ) using
"alsamixer -c 0"
