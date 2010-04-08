From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: wrong decibel data?
Date: Thu, 8 Apr 2010 10:05:28 +0800
Message-ID: <q2l4f3252891004071905l553da6a0he8b53448524fc94d@mail.gmail.com>
References: <q2s98391a7b1004021121sde36d074m8a70acc142f95d93@mail.gmail.com>
	<r2i4f3252891004051846xc6ef1834habaf4f9db3bdd384@mail.gmail.com>
	<q2z98391a7b1004060101kd5ffef92tf4d98faa62a3ad5b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1AFBF1038F1
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Apr 2010 04:05:29 +0200 (CEST)
Received: by pwj8 with SMTP id 8so572085pwj.38
	for <alsa-devel@alsa-project.org>; Wed, 07 Apr 2010 19:05:29 -0700 (PDT)
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


Most users only care about 0dB point since any software gain is the cause of
clipping (distortion) when the volume control provide software gain


http://en.wikipedia.org/wiki/Clipping_%28audio%29

In digital signal
processing<http://en.wikipedia.org/wiki/Digital_signal_processing>,
clipping occurs when the signal is restricted by the range of a chosen
representation. For example in a system using 16-bit
signed<http://en.wikipedia.org/wiki/Signed-digit_representation>integers,
32767 is the largest positive value that can be represented, and
if during processing the amplitude of the signal is doubled,
sample<http://en.wikipedia.org/wiki/Sample_%28signal%29>values of
32000 should become 64000, but instead they are truncated to the
maximum, 32767.
