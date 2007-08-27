From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: ALSA sound/core/pcm_lib.c:210: Unexpected hw_pointer
	value [1] (stream = 0, delta: -4096,
	max jitter = 8192): wrong interrupt acknowledge?
Date: Mon, 27 Aug 2007 22:44:38 +0530
Message-ID: <61445c750708271014j22d50563q1f5c1ef7f7d73168@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.237])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A6541038DD
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Aug 2007 19:14:40 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 58so1373827wri
	for <alsa-devel@alsa-project.org>; Mon, 27 Aug 2007 10:14:40 -0700 (PDT)
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

I am getting this error at the start of song, I get this only once and the
song plays quite well except some periodic minute/unnoticable clicks which
occur often if period size is less. Is there any chance of this being the
culprit i.e. causing clicks? I used to get the same messages after every
buffer size previously, but after fixing my pointer callback this happens
only once at the beginning.

After reading the code I think that, this might not be the reason behind
clicks, since this is just xrun debug thing, but this doesn't correspond to
xruns directly, does it? I got the above error message even when there were
no xruns. How serious is this issue? After referring web I collected that,
this might happen because the period is not processed as fast as it should
be.

-pharaoh.
