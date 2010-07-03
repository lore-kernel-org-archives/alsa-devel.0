From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: Question about snd_pcm_sw_params_set_start_threshold
Date: Sat, 3 Jul 2010 16:04:52 +0200
Message-ID: <AANLkTilyuqSBzRYjzQbx3iYf8tW0bwM2t1gU8u-afKMG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id A377424425
	for <alsa-devel@alsa-project.org>;
	Sat,  3 Jul 2010 16:05:12 +0200 (CEST)
Received: by fxm15 with SMTP id 15so2933129fxm.38
	for <alsa-devel@alsa-project.org>; Sat, 03 Jul 2010 07:05:12 -0700 (PDT)
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

Hi all,

I am running into some troubles with my linux plugin for the vdr. I
want to play audio in sync of video. My current solution is to buffer
about 500ms of video on the output device (pts based FIFO). I can play
audio with alsa, but
sometimes I am not in sync with the video. So I want to set start
threshold to 0 to disable automatic playback start. Instead I want to
buffer audio and start playback manual, if pts of video is near
current scr clock of output device. What are my options to manually
start playback?

thanks,
--
Christian Gmeiner, MSc
