From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: wrong decibel data?
Date: Mon, 5 Apr 2010 08:15:45 +0800
Message-ID: <g2g4f3252891004041715t3a4dae58s7a8adfb743340010@mail.gmail.com>
References: <q2s98391a7b1004021121sde36d074m8a70acc142f95d93@mail.gmail.com>
	<q2t98391a7b1004021325jbc9e7ddal26063e490fe69254@mail.gmail.com>
	<hp744t$5b5$1@dough.gmane.org>
	<l2s98391a7b1004030348n2b2a540bq8fddb0a90dd7c3c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 61DC4103809
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Apr 2010 02:15:46 +0200 (CEST)
Received: by pwj7 with SMTP id 7so2366867pwj.38
	for <alsa-devel@alsa-project.org>; Sun, 04 Apr 2010 17:15:45 -0700 (PDT)
In-Reply-To: <l2s98391a7b1004030348n2b2a540bq8fddb0a90dd7c3c9@mail.gmail.com>
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

> I don't think that any specific debug is needed. pulseaudio developers
> just told that you have to declare -200 dB when the sound is disabled,
> that's it.
> Is this a difficult thing to do? which files must be touched?
>
>


to proivide dB scale of pulse master volume control of the alsa mixer
applications

alsa-plugins/pulse/ctl_pulse.c
