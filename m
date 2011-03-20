From: Ivan Sorokin <sorokin@rain.ifmo.ru>
Subject: snd_pcm_writei returns -EAGAIN after poll
Date: Sun, 20 Mar 2011 05:21:17 +0300
Message-ID: <4D85649D.20107@rain.ifmo.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.ifmo.ru (mail.ifmo.ru [194.85.160.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 68F611037E3
	for <alsa-devel@alsa-project.org>; Sun, 20 Mar 2011 03:23:47 +0100 (CET)
Received: from [192.168.136.3] (campus.ifmo.ru [194.85.161.2])
	by mail.ifmo.ru (8.13.8/8.13.8) with ESMTP id p2K2NeCD026941
	for <alsa-devel@alsa-project.org>; Sun, 20 Mar 2011 05:23:46 +0300
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

Hello!

I use slightly modified test/pcm.c in write_and_poll mode.

My program looks like this:

snd_pcm_open with SND_PCM_NONBLOCK
snd_pcm_set_params

infinite loop
    poll for snd_pcm_poll_descriptors
    snd_pcm_poll_descriptors_revents
    if POLLOUT flag is set
       snd_pcm_writei

Everything works, but snd_pcm_writei sometimes returns -EAGAIN. The 
probability of when snd_pcm_writei returns -EAGAIN depends on buffer 
size that I pass to it. ExperimentallyI found out that when I call 
snd_pcm_writei with 940 bytes buffers (maybe something related to period 
size?) it never returns -EAGAIN.

Why poll returns when there is no place for new data? Is it ok to ignore 
EAGAIN and just start another poll? Is there any recommended buffer size 
for snd_pcm_writei?

My test program: 
https://github.com/sorokin/asoundpp/blob/master/sine_async.cpp (94 LOC)
