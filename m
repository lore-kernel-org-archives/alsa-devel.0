From: Grant Diffey <gdiffey@gmail.com>
Subject: Fast Track Ultra latency and new streaming logic.
Date: Tue, 1 May 2012 10:18:54 +1000
Message-ID: <CACckToWK=Si8-8rPKgo-ZWA+ncTVb7zW8jHZvf7VbKT1sMM32Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0CD66104238
	for <alsa-devel@alsa-project.org>;
	Tue,  1 May 2012 02:18:55 +0200 (CEST)
Received: by wgbed3 with SMTP id ed3so1357877wgb.20
	for <alsa-devel@alsa-project.org>; Mon, 30 Apr 2012 17:18:54 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>, Felix Homann <linuxaudio@showlabor.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Daniel,

In continuing my personal habit of looking gift horses in the mouth...

I can't seem to get below 512frames in flight (2 256sample frames or 4 128
or 8 64's) without consistant overruns.

I have a feeling that the pcm <-> urb layer is buffering until a urb is max
urbsize from a quick look at the code does this seem like the right track?

This leads to rather high latencies (22ms+) or is this conclusion bogus?

Grant.
