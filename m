From: Irfan Shaikh <irfan.shaikh@sasken.com>
Subject: Not able to set my playback device to mono
Date: Mon, 20 Dec 2010 19:33:40 +0530
Message-ID: <16F32A3F9AF4E441B752BCD79C151ACA635A7480DC@EXGMBX01.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta-blr1.sasken.com (mta-blr1.sasken.com [203.200.200.72])
	by alsa0.perex.cz (Postfix) with ESMTP id 5CF3924152
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 15:08:05 +0100 (CET)
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

Not able to configure my playback device to MONO . But my playback device supports MONO. What is wrong in the below configuration
Error : Channels not available for PLAYBACK device

retVal = snd_pcm_hw_params_set_channels( pcm, hwparams, 1);
  if (retVal < 0){
    printf("Channels not available : %s\n", name);
    return retVal;
  }

/*************************************************************/
int initializeDevice(snd_pcm_t* pcm,snd_pcm_hw_params_t *hwparams, int deviceType)
{
  const char* name = snd_pcm_stream_name( snd_pcm_stream(pcm));
  snd_pcm_uframes_t framecount;
  int retVal = 0;

  retVal = snd_pcm_hw_params_any(pcm, hwparams);
  if (retVal < 0){
    printf( "Configuration FAILED for %s\n", name);
    return retVal;
  }

  retVal = snd_pcm_hw_params_set_format( pcm, hwparams, SND_PCM_FORMAT_S16_LE);
  if (retVal < 0){
    printf( "Sample format not available for %s\n", name);
    return retVal;
  }

  retVal = snd_pcm_hw_params_set_access( pcm, hwparams, SND_PCM_ACCESS_RW_INTERLEAVED);
  if (retVal < 0){
    printf( "Access not available for %s\n", name);
    return retVal;
  }
  /*Set Sampling Frequency*/
  int rate;
  rate= ALSA_SAMPLERATE;
  retVal = snd_pcm_hw_params_set_rate_near( pcm, hwparams, (unsigned int*)&rate, 0);
  if (retVal < 0){
    printf( "Rate %iHz not available for playback\n", rate);
    return retVal;
  }
  if ((unsigned)rate != ALSA_SAMPLERATE){
    printf( "Could not configure requested sampling rate\n");
    return -1;
  }

  retVal = snd_pcm_hw_params_set_period_size(pcm, hwparams, 512, 0);
  if (retVal < 0){
    printf( "Could not configure requested period size : %s", name);
    return retVal;
  }

  /*Get period size and check whether period size requested is configured*/

  retVal = snd_pcm_hw_params_set_periods( pcm, hwparams,4, 0);
  if (retVal < 0){
    printf( "Error : Configuring period count\n");
    return retVal;
  }
  #if 1
  int dir;
  unsigned int val;
  snd_pcm_uframes_t frames;
  snd_pcm_hw_params_get_period_size(hwparams, &frames, &dir);
  printf("period size = %d frames\n", (int)frames);
  snd_pcm_hw_params_get_periods(hwparams, &val, &dir);
  printf("periods per alsa buffer = %d frames\n", val);
  snd_pcm_hw_params_get_buffer_size(hwparams, (snd_pcm_uframes_t *) &val);
  printf("buffer size = %d frames\n", val);
#endif

  retVal = snd_pcm_hw_params_set_channels( pcm, hwparams, 1);
  if (retVal < 0){
    printf("Channels not available : %s\n", name);
    return retVal;
  }

  retVal = snd_pcm_hw_params( pcm, hwparams);
  if (retVal < 0){
    printf( "Error in configuring hw params : %s\n", name);
    return retVal;
  }
  snd_pcm_hw_params_current( pcm, hwparams);
  /*Get ALSA Buffer size and check whether alsa buffer size requested is configured*/

  return 0;
}

/*************************************************************/

SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any 
 virus transmitted by this email.
Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html
