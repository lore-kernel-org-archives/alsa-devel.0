From: Dake Gu <Dake.Gu@palm.com>
Subject: Alsa Pulse plugin pcm->ptr initialization problem
Date: Wed, 15 Apr 2009 16:40:15 -0700
Message-ID: <F9C2E2EABD9FD9428530435E0CB176A518A14F58B4@ushqwmb01.palm1.palmone.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-relay2.palm.com (smtp-relay2.palm.com [64.28.152.243])
	by alsa0.perex.cz (Postfix) with ESMTP id 9B29E10389D
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 01:40:20 +0200 (CEST)
Received: from ushqwmh02.palm1.palmone.com (ushqwmh02.palm1.palmone.com
	[148.92.223.143])
	by mailhost01.palm.com (8.13.6+Sun/8.12.10) with ESMTP id
	n3FNeGgu001606
	for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2009 16:40:17 -0700 (PDT)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

By looking through the pcm_pulse.c(1.0.18), I found there is a possible error in initializing the pcm->ptr.

Some background: see update_ptr() function in pcm_pulse.c:
Basically the pcm->ptr is increased when pa_stream_writable_size() increases.  The last pa_stream_writable_size() is saved in pcm->last_size,  so if new pa_stream_writable_size() value is larger than pcm->last_size,  the pcm->ptr is increased.    For example,  the pa_stream_writable_size() increases from 800 to 1400,  then pcm->ptr is increased by 400.   Alsa-lib's snd_pcm_ioplug_hw_ptr_update() function is calling pulse_pointer() to get pcm->ptr,  then pcm_ioplug.c calculates the hw.ptr from the changes of pulse_pointer().  The hw.ptr is used in snd_pcm_mmap_playback_avail().

However, there is an issue that during the pulse is started,  the pcm->last_size jumps from 0 to a positive value, which should not be counted as pcm->ptr increase.  It's causing the hw.ptr wrongly calculated.
Wrong senario
      pa_writable   (N/A)  1000    900      800       1200
           pcm->ptr   0        1000    1000    1000     1400    .....
               hw.ptr   0        1000    1000    1000     1400
Correct scenario:
      pa_writable   (N/A)  1000   900      800       1200
           pcm->ptr   0         0        0          0           400    .....
               hw.ptr   0        0         0          0           400
If hw.ptr is incorrectly set larger than actual size,  it causes avail>"real avail" and client sends more data than pulse can accept.

Dake
