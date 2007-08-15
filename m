From: Akio <akioolin@gmail.com>
Subject: Voip Application with ALSA OSS Emulation ==> voice
	delay
Date: Wed, 15 Aug 2007 15:08:01 +0000 (UTC)
Message-ID: <loom.20070815T160926-869@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id A8A6C103834
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Aug 2007 18:35:05 +0200 (CEST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1ILLpm-00027i-K8
	for alsa-devel@alsa-project.org; Wed, 15 Aug 2007 18:35:03 +0200
Received: from 61-56-150-105-adsl-chu.STATIC.so-net.net.tw ([61.56.150.105])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 15 Aug 2007 18:35:02 +0200
Received: from akioolin by 61-56-150-105-adsl-chu.STATIC.so-net.net.tw with
	local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 15 Aug 2007 18:35:02 +0200
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

Dear Sir:

              Could you do me a favor?

              Right now, we are using a arm box with linux kernel 2.6.14 to
              develop a voip  solution. After the rtp connection was 
              connected at first 20 secs, there is no delay. As the timing passing
              by, the delay will going longer and longer.  After 16 houres, the 
              delay will up to 12 secs. Because the alsa lib application can't 
              detect any alsa device, we have no choice but only alsa
              oss emulation data path to using audio device. after tracing
	      sound/core/oss/pcm_oss.c. we find some things.

              1.in snd_pcm_oss_write() and in snd_pcm_oss_read(), there is a
                little slight difference. in snd_pcm_oss_write(), before and after
                snd_pcm_oss_write1() there are using up() and down() to protect
                snd_pcm_oss_write1(). but in snd_pcm_oss_read(), there is no 
                protection. why doesn't use up() and down() to protect 
                snd_pcm_oss_read1()?

              2.after using printk to tracing runtime->oss.xxx fields in
                 snd_pcm_oss_read1(), we got the data positions seem correct. 
                 and alignment very well. what should we have to check? where
                 do we have to check?

              3.in snd_pcm_oss_capture_position_fixup(), why using the following
                condition to check, 
                if (*delay <= (snd_pcm_sframes_t)runtime->buffer_size)?
                why not using 
                if (*delay <= (snd_pcm_sframes_t)runtime->period_size)?

                because the following wrapping,
                frames = (*delay - runtime->buffer_size) + runtime->period_size - 1;
                frames /= runtime->period_size;
                frames *= runtime->period_size;
                using runtime->period_size, not runtime->buffer_size.

              4.why using snd_pcm_oss_capture_position_fixup() in
                 snd_pcm_oss_read3() not in snd_pcm_oss_read()?

              5.the following url seem counter the same problems.          
                 http://blackfin.uclinux.org/gf/project/uclinux-dist/forum/?
                 action=ForumBrowse&forum_id=39&_forum_action=
                 ForumMessageBrowse&thread_id=22524

           We will check the write direction to see the runtime->oss.xxx fields will
           act as the same read or not. Thanks in advance.
							
Best Regards,
Akio
