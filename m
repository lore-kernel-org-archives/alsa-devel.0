From: Akio <akioolin@gmail.com>
Subject: some alsa lib usage on arm926 platform
Date: Fri, 28 Sep 2007 15:34:23 +0000 (UTC)
Message-ID: <loom.20070928T152516-14@post.gmane.org>
References: <loom.20070922T073328-313@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 65AAB10381B
	for <alsa-devel@alsa-project.org>;
	Fri, 28 Sep 2007 17:34:50 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IbHrX-0004DL-7E
	for alsa-devel@alsa-project.org; Fri, 28 Sep 2007 15:34:43 +0000
Received: from 219-69-46-27.idc.static.giga.net.tw ([219.69.46.27])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2007 15:34:43 +0000
Received: from akioolin by 219-69-46-27.idc.static.giga.net.tw with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2007 15:34:43 +0000
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

Dear All:
 
           right now, I'm using alsa lib interface to work with voip 
           application. Our hardware platform is an ARM926 266MHz box with 
           Linux kernel 2.6.19.2. We got some problems. would you like to do 
           us favors?
 
           1. what is the different between "plughw:0,0", "defalut", "hw:0.0"?
               after reading the document in 
               http://www.alsa-project.org/alsa-doc/alsa-lib/pcm.html
               about "PCM naming conventions", we still not very sure the
               relationship between those device conventions. is there any 
               more detail documents talk about on this? right now, we are 
               using alsa lib 1.0.13 and the device is "plughw:0,0".
 
          2. Is there any documents detail discuss the setting about
              sample rate, buffer size, period size. because, I have two
              different voice codec to handle, one is narrow band(8k Hz),
              the other is wide band(16K Hz). right now, I using the 
              following functions and setting to make alsa work.
              snd_pcm_hw_params_set_rate_near sets sample rate, 8k or 16k.
              snd_pcm_hw_params_set_period_size_near sets period size, 
              current is 128.
              snd_pcm_hw_params_set_buffer_size_near sets buffer size, 8k is
              2048, 16k is 4096. the unit seems be samples not byte. 
 
          3. the code was based on the following URL.
              http://www.suse.de/~mana/alsa090_howto.html
              http://www.equalarea.com/paul/alsa-audio.html
              open capture and playback at one function, and provide one read 
              and one write interface to up layer. here comes three problems:
              a. the channel opened is just only one, but If I set the 
                  snd_pcm_hw_params_set_access as 
                  SND_PCM_ACCESS_RW_NONINTERLEAVED.
                  using snd_pcm_readn and snd_pcm_writen the code will not 
                  work. what is the wrong? 
                  but if set snd_pcm_hw_params_set_access as
                  SND_PCM_ACCESS_RW_INTERLEAVED
                  and using snd_pcm_readi and snd_pcm_writei. the code work 
                  very well. one channel also have data interleave problem?
                  I don't understand why?
 
              b. in snd_pcm_open the block flag is set as 0. what is the mode 
                 of the operation? blocking or non-blocking? 
 
              c. call the xrun_recovery() timing. currently the xrun_recovery
                 only do on EPIPE. the following is the handling core.
                  err = snd_pcm_prepare(handle);
                  if(err == -ESTRPIPE) {
                      while ((err = snd_pcm_resume(handle)) == -EAGAIN) {
                                nanosleep(&retryTime, &tmpTime);
                                LOG("audio device resume fail, %s\n",
                                    snd_strerror(err));
                      }
                      if(err < 0) {
                              err = snd_pcm_prepare(handle);
                              if(err < 0) LOG("audio data IO fail, %s\n",
                                              snd_strerror(err));
                      }
                  } else {
                      if(err < 0) LOG("audio device prepare fail, %s\n",
                                       snd_strerror(err));
                  }
 
                 Does the code have any missing point to handle? If any 
                 missing, what should I to add? 
 
          4. BTW, I call xrun_recovery both in capture and playback direction.
             After long time test. the test procedure is as the following 
             steps:
                 1. capture voice data as PCM data.
                 2. encoded as amr-wb bit stream.
                 3. decoded as PCM data from encoded bit stream.
                 4. playback PCM data.
              after 16 hours continue tests, there are some delay, about 800 
              mili seconds. is there any way to reduce the delay after long 
              time test. we want make the delay about < 400 mili seconds 
              after one week continue test. BTW, is there any way to prevent 
              xrun_recovery calling? is there any index to monitor ALSA
              device buffer information? 
 
           5. If we want using salsa lib to replace the usage of alsa lib, 
              what do we have to take care? how about the latency and 
              performance between salsa and alsa? how about the stability of 
              salsa?
 
           There are so many problems after many tests. If you found any 
           documents we need to study more detail. please tell us. Thanks in 
           advance. Thank you.
 
Best Regards,
Akio
