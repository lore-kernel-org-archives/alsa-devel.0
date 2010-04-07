From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: wrong decibel data?
Date: Wed, 7 Apr 2010 08:34:14 +0800
Message-ID: <l2y4f3252891004061734w9b710450ic6661ff8b2e630f9@mail.gmail.com>
References: <q2s98391a7b1004021121sde36d074m8a70acc142f95d93@mail.gmail.com>
	<r2i4f3252891004051846xc6ef1834habaf4f9db3bdd384@mail.gmail.com>
	<q2z98391a7b1004060101kd5ffef92tf4d98faa62a3ad5b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f202.google.com (mail-pz0-f202.google.com
	[209.85.222.202])
	by alsa0.perex.cz (Postfix) with ESMTP id E6ED2103807
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Apr 2010 02:34:15 +0200 (CEST)
Received: by pzk40 with SMTP id 40so464503pzk.23
	for <alsa-devel@alsa-project.org>; Tue, 06 Apr 2010 17:34:15 -0700 (PDT)
In-Reply-To: <q2z98391a7b1004060101kd5ffef92tf4d98faa62a3ad5b@mail.gmail.com>
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

2010/4/6 Nicolo' Chieffo <nicolo.chieffo@gmail.com>

> I've already attached my alsa-info.log in my first post.
>
>
> * alsamixer -3 dB (94%):
> Simple mixer control 'Master',0
>  Capabilities: pvolume pswitch pswitch-joined penum
>  Playback channels: Front Left - Front Right
>  Limits: Playback 0 - 65536
>  Mono:
>  Front Left: Playback 57079 [87%] [on]
>  Front Right: Playback 57079 [87%] [on]
>
> * alsamixer 0 dB (100%):
> Simple mixer control 'Master',0
>  Capabilities: pvolume pswitch pswitch-joined penum
>  Playback channels: Front Left - Front Right
>  Limits: Playback 0 - 65536
>  Mono:
>  Front Left: Playback 64044 [98%] [on]
>  Front Right: Playback 64044 [98%] [on]
>

you should notice that 0dB of Pulseaudio volume control is not at the
maximum dB
i.e. (  floating point 1.0 is not at 100% any more , seem that floating
point 0 (-inf dB) is also not at 0% point too )

http://thread.gmane.org/gmane.linux.alsa.devel/70545/focus=70585

>>   As mentioned for the PA case I decided to shift 0dB to max
amplification in any case, which I think is a workable way to avoid this
problem.


how about "dbmeasure pulse" and "dbmeasure hw:0,0" ?
