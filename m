From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Pausing an audio stream during playback using mixer
	control interface
Date: Mon, 10 Sep 2007 17:49:18 +0530
Message-ID: <61445c750709100519v83f6e92w76d023f0a4c34681@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.238])
	by alsa0.perex.cz (Postfix) with ESMTP id 79FD2103865
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Sep 2007 14:28:22 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 58so289352wri
	for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2007 05:28:19 -0700 (PDT)
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

Hi
I want to provide a mixer control interface which will pause the playback
and resume it as needed. I tried to disable DMA while pausing and enable it
while releasing, but this doesn't stop alsa upper layers from inquiring  the
buffer position and since DMA is not on, it gives a pcm write error, which
is quite obvious.

I know that, SNDRV_PCM_TRIGGER_PAUSE_PUSH can be used in trigger callback to
pause the stream, but I want to give a mixer interface to do the same. As
per my understanding this is not possible keeping in mind the current
framework, can anyone think of any work around?

-pharaoh.
