From: Irfan Shaikh <irfan.shaikh@sasken.com>
Subject: Unable to set ALSA buffer size
Date: Fri, 10 Dec 2010 16:33:52 +0530
Message-ID: <16F32A3F9AF4E441B752BCD79C151ACA635A7480C5@EXGMBX01.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta-blr1.sasken.com (mta-blr1.sasken.com [203.200.200.72])
	by alsa0.perex.cz (Postfix) with ESMTP id 30EAA2442B
	for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2010 12:08:07 +0100 (CET)
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

Hello All,

             I am trying to set my alsa buffer size as 1024*8. But my playback device is not able to set to requested ALSA buffer size.

  snd_pcm_hw_params_set_periods(handle, params, 8, 0);
  snd_pcm_hw_params_set_period_size(handle, params, 1024, 0);
  snd_pcm_uframes_t frames1;
  frames1=1024*8;
  retVal=snd_pcm_hw_params_set_buffer_size_near(handle, params, &frames1);


  snd_pcm_hw_params_get_buffer_size(params,
                         (snd_pcm_uframes_t *) &val);

/*Expected Output*/
==============>>>>>>>  buffer size = 8192 frames

/*Output*/
==============>>>>>>>  buffer size = 1325 frames

           Return value for above APIs is coming as zero. but still i am unable to get expected result. Is there any other forcible way to do the above.

Regards,


SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any 
 virus transmitted by this email.
Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html
