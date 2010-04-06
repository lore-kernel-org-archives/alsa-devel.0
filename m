From: "Nicolo' Chieffo" <nicolo.chieffo@gmail.com>
Subject: Re: wrong decibel data?
Date: Tue, 6 Apr 2010 10:01:59 +0200
Message-ID: <q2z98391a7b1004060101kd5ffef92tf4d98faa62a3ad5b@mail.gmail.com>
References: <q2s98391a7b1004021121sde36d074m8a70acc142f95d93@mail.gmail.com>
	<r2i4f3252891004051846xc6ef1834habaf4f9db3bdd384@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f219.google.com (mail-ew0-f219.google.com
	[209.85.219.219])
	by alsa0.perex.cz (Postfix) with ESMTP id E69EF103865
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Apr 2010 10:02:19 +0200 (CEST)
Received: by ewy19 with SMTP id 19so1391373ewy.22
	for <alsa-devel@alsa-project.org>; Tue, 06 Apr 2010 01:02:19 -0700 (PDT)
In-Reply-To: <r2i4f3252891004051846xc6ef1834habaf4f9db3bdd384@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I've already attached my alsa-info.log in my first post.

* alsamixer -48 dB (0%)
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65536
  Mono:
  Front Left: Playback 10151 [15%] [on]
  Front Right: Playback 10151 [15%] [on]

* alsamixer -24 dB (50%)
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65536
  Mono:
  Front Left: Playback 25693 [39%] [on]
  Front Right: Playback 25693 [39%] [on]

* alsamixer -12 dB (75%):
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65536
  Mono:
  Front Left: Playback 40409 [62%] [on]
  Front Right: Playback 40409 [62%] [on]

* alsamixer -6 dB (88%):
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65536
  Mono:
  Front Left: Playback 50872 [78%] [on]
  Front Right: Playback 50872 [78%] [on]

* alsamixer -3 dB (94%):
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65536
  Mono:
  Front Left: Playback 57079 [87%] [on]
  Front Right: Playback 57079 [87%] [on]

* alsamixer 0 dB (100%):
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65536
  Mono:
  Front Left: Playback 64044 [98%] [on]
  Front Right: Playback 64044 [98%] [on]
