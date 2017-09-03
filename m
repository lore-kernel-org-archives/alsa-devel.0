From: Petr Kulhavy <brain@jikos.cz>
Subject: Raspberry PI reports no channels, period and buffer
Date: Sun, 3 Sep 2017 11:46:17 +0200
Message-ID: <7b5bd5bb-8394-432f-dfa8-d55cac3d52c7@jikos.cz>
Reply-To: brain@jikos.cz
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from twin.jikos.cz (twin.jikos.cz [89.185.236.188])
 by alsa0.perex.cz (Postfix) with ESMTP id 72A5526691F
 for <alsa-devel@alsa-project.org>; Sun,  3 Sep 2017 11:46:24 +0200 (CEST)
Received: from [192.168.100.100] (162.41.150.83.ftth.as8758.net
 [83.150.41.162]) (authenticated bits=0)
 by twin.jikos.cz (8.13.6/8.13.6) with ESMTP id v839kN6N008154
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
 for <alsa-devel@alsa-project.org>; Sun, 3 Sep 2017 11:46:24 +0200
Content-Language: de-CH
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm writing an audio decoding program for ALSA, which among others 
detects audio capabilities.
It uses the snd_pcm_hw_params_get_XXX() functions for that.
This works well on my Ubuntu PC but on Raspberry PI 3 these calls return 
no information. They return success but the min and max values are 
meaningless.

For instance the period:

     err = snd_pcm_hw_params_get_period_size_min(hw_params, 
&m_period_min, NULL);
     if (err < 0) {
         LOG(LOG_ERROR, LOG_OBJ "Failed to get minimum period time: 
%s\n", snd_strerror(err));
         goto fail;
     }
     err = snd_pcm_hw_params_get_period_size_max(hw_params, 
&m_period_max, NULL);
     if (err < 0) {
         LOG(LOG_ERROR, LOG_OBJ "Failed to get maximum period time: 
%s\n", snd_strerror(err));
         goto fail;
     }
     err = snd_pcm_hw_params_get_period_time_min(hw_params, 
&m_period_min_us, NULL);
     if (err < 0) {
         LOG(LOG_ERROR, LOG_OBJ "Failed to get minimum period time: 
%s\n", snd_strerror(err));
         goto fail;
     }
     err = snd_pcm_hw_params_get_period_time_max(hw_params, 
&m_period_max_us, NULL);
     if (err < 0) {
         LOG(LOG_ERROR, LOG_OBJ "Failed to get maximum period time: 
%s\n", snd_strerror(err));
         goto fail;
     }
     LOG(LOG_DEBUG, LOG_OBJ "Supported period: %lu to %lu frames (%u to 
%u us)\n",
             (unsigned long)m_period_min, (unsigned long)m_period_max,
             m_period_min_us, m_period_max_us);


This prints:
Supported period: 0 to 0 frames (1 to 0 us)


     // query buffer size
     err = snd_pcm_hw_params_get_buffer_size_min(hw_params, &m_buffer_min);
     if (err < 0) {
         LOG(LOG_ERROR, LOG_OBJ "Failed get minimum buffer time: %s\n", 
snd_strerror(err));
         goto fail;
     }
     err = snd_pcm_hw_params_get_buffer_size_max(hw_params, &m_buffer_max);
     if (err < 0) {
         LOG(LOG_ERROR, LOG_OBJ "Failed get maximum buffer time: %s\n", 
snd_strerror(err));
         goto fail;
     }
     err = snd_pcm_hw_params_get_buffer_time_min(hw_params, 
&m_buffer_min_us, NULL);
     if (err < 0) {
         LOG(LOG_ERROR, LOG_OBJ "Failed get minimum buffer time: %s\n", 
snd_strerror(err));
         goto fail;
     }
     err = snd_pcm_hw_params_get_buffer_time_max(hw_params, 
&m_buffer_max_us, NULL);
     if (err < 0) {
         LOG(LOG_ERROR, LOG_OBJ "Failed get maximum buffer time: %s\n", 
snd_strerror(err));
         goto fail;
     }
     LOG(LOG_DEBUG, LOG_OBJ "Supported buffer size: %lu to %lu frames 
(%u to %u us)\n",
             (unsigned long)m_buffer_min, (unsigned long)m_buffer_max,
             m_buffer_min_us, m_buffer_max_us);

This prints:
Supported buffer size: 0 to 0 frames (1 to 0 us)


And so on. Same for the number of periods and channels.
On the other hand the snd_pcm_hw_params_test_XXX() calls do work and 
that way I can detect the rates, formats, accesses.
Why is that? Am I doing something wrong? And more importantly, how can I 
get the buffering and channel information?

Thanks
Petr
