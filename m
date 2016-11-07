From: Alan Young <Alan.Young@IEE.org>
Subject: Locking/mutex for snd_pcm_update_hw_ptr0() call
Date: Mon, 7 Nov 2016 12:53:08 +0000
Message-ID: <58207934.8080006@IEE.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 788E6265D2B
 for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2016 13:53:10 +0100 (CET)
Received: by mail-wm0-f43.google.com with SMTP id a197so180391040wmd.0
 for <alsa-devel@alsa-project.org>; Mon, 07 Nov 2016 04:53:10 -0800 (PST)
Received: from [192.168.11.11] (13.110.6.51.dyn.plus.net. [51.6.110.13])
 by smtp.googlemail.com with ESMTPSA id o62sm13394636wmg.12.2016.11.07.04.53.08
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Nov 2016 04:53:08 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

As far as I can see, snd_pcm_update_hw_ptr0() is a critical section of 
code that is protected by some form of mutex in all its call paths:

     snd_pcm_period_elapsed() - snd_pcm_stream_lock_irqsave()

     snd_pcm_update_hw_ptr()

         snd_pcm_lib_ioctl_reset() - snd_pcm_stream_lock_irqsave()

         snd_pcm_lib_write1() - snd_pcm_stream_lock_irq()

         snd_pcm_lib_read1() - snd_pcm_stream_lock_irq()

         snd_pcm_status() - snd_pcm_stream_lock_irq()

         snd_pcm_do_pause - I think via the locking in snd_pcm_action()

         snd_pcm_playback_rewind() - snd_pcm_stream_lock_irq()

         snd_pcm_capture_rewind() - snd_pcm_stream_lock_irq()

         snd_pcm_playback_forward() - snd_pcm_stream_lock_irq()

         snd_pcm_capture_forward() - snd_pcm_stream_lock_irq()

         snd_pcm_hwsync() - snd_pcm_stream_lock_irq()

         snd_pcm_delay() - snd_pcm_stream_lock_irq()



However, I am not familiar with how kernel locking mechanisms work. It 
is possible that the DMA interrupt handler (snd_pcm_period_elapsed()), 
could call snd_pcm_update_hw_ptr0() while it is part way through a call 
from snd_pcm_status(), or vice versa?

Alan.
