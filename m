From: "Claudio Matsuoka" <cmatsuoka@gmail.com>
Subject: Latency and timestamps
Date: Mon, 19 Nov 2007 22:46:31 -0200
Message-ID: <5f52f6d70711191646s6f23fce3seba229a77062e1a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rn-out-0102.google.com (rn-out-0910.google.com [64.233.170.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 3184F24953
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 01:46:34 +0100 (CET)
Received: by rn-out-0102.google.com with SMTP id e23so1521441rng
	for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2007 16:46:32 -0800 (PST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I'm adding latency control to an application and didn't find much
documentation about the pcm status functions aside from a very brief
description and the latency.c example. What exactly are the "trigger
timestamp" and "now timestamp" returned by
snd_pcm_status_get_trigger_tstamp() and snd_pcm_status_get_tstamp()? I
collected both from my output pcm handle to find values (in
tv_sec.tv_usec format) such as

1195518180.938427 938427.557702
1195518180.938441 938441.557702
1195518181.300395 300395.557702
1195518181.300441 300441.557702

where the "trigger" tv_sec matches the "now" tv_usec, and the
"trigger" tv_usec varies in large steps. Also the example latency.c
says:

00703                 showinmax(in_max);
00704                 if (p_tstamp.tv_sec == p_tstamp.tv_sec &&
00705                     p_tstamp.tv_usec == c_tstamp.tv_usec)
00706                         printf("Hardware sync\n");
00707                 snd_pcm_drop(chandle);

In line 704, shouldn't it be p_tstamp.tv_sec == c_tstamp.tv_sec?

My final goal is to sync on-screen events with the sound output. I'd
like to do something like storing output metadata associated with a
certain timestamp and collecting it back based on the timestamp of the
currently playing pcm data (like the OSS sequencer echoback events),
is that possible, or is there a better way to do this?
