From: Irfan shaikh <irfan.shaikh@sasken.com>
Subject: ALSA Underrun / Silence playback
Date: Mon, 5 Dec 2011 12:10:10 +0530
Message-ID: <4EDC674A.4030302@sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta-blr1.sasken.com (mta-blr1.sasken.com [203.200.200.72])
	by alsa0.perex.cz (Postfix) with ESMTP id A948F2434C
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 07:42:45 +0100 (CET)
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

Hello devel,

          I am trying to implement s/w params for ALSA playback device 
such that there is SILENCE playback for UNDERRUN (-32).
          To achieve above i used below s/w params API's. But still i 
observe UNDERRUN in my AUDIO Playback.
          Please correct me if i am mising somenting.
{When i do get boundry, i get some weird value 1572864000. Thus i tried 
to use alsa buffer size for threshold}

/*************************************************************************************/ 

   if (snd_pcm_sw_params_get_boundary (alsaParams->p_swparams, 
&boundary) < 0)
         {
                 printf ("Could not gete snd_pcm_sw_params_get_boundary");
                 return NULL;
         }

//      threshold = boundary;
         threshold = alsaParams->periodsize * alsaParams->no_of_periods;

         if (snd_pcm_sw_params_set_stop_threshold 
(alsaParams->pcm_handle, alsaParams->p_swparams, threshold) < 0)
         {
                 printf("Could not gete snd_pcm_sw_params_get_boundary");
                 return NULL;
         }

         if (snd_pcm_sw_params_set_silence_threshold 
(alsaParams->pcm_handle, alsaParams->p_swparams, 0) < 0 ||
                         snd_pcm_sw_params_set_silence_size 
(alsaParams->pcm_handle, alsaParams->p_swparams, boundary) < 0)      /* 
play silence on XRUN */
         {
                 printf("Could not set silence params");
                 return NULL;
         }
/*************************************************************************************/

Thanks in advance !!

Regards,
