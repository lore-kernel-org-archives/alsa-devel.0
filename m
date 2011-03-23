From: Irfan Shaikh <irfan.shaikh@sasken.com>
Subject: Bad file descriptor : -EBADFD
Date: Wed, 23 Mar 2011 16:44:24 +0530
Message-ID: <16F32A3F9AF4E441B752BCD79C151ACA69D0BB56B7@EXGMBX01.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta-blr1.sasken.com (mta-blr1.sasken.com [203.200.200.72])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F15524480
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2011 12:14:28 +0100 (CET)
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

Hello

           In the below logic, snd_pcm_write always returns -EBADFD . snd_pcm_writei not at all recovers from this state infinitly.
How can i solve this problem.

while(1)
{
     /*Read from capture device*/
    snd_pcm_writei(()
   if(error)
       xrun_recovery(pAlsaConfigP->playback_handle, retVal);
}

**** ERROR values returned from snd_pcm_writei:
Only forst time : -11
Follwed by  -EBADFD always



static int xrun_recovery(snd_pcm_t *handle, int err)
{
    if (err == -EPIPE) {    /* under-run */
        err = snd_pcm_prepare(handle);
        if (err < 0)
            printf("Can't recovery from underrun, prepare failed: %s\n", snd_strerror(err));
        return 0;
     }
     else if (err == -ESTRPIPE) {
         while ((err = snd_pcm_resume(handle)) == -EAGAIN)
             sleep(1);       /* wait until the suspend flag is released */
             if (err < 0)
             {
                 err = snd_pcm_prepare(handle);
                 if (err < 0)
                     printf("Can't recovery from suspend, prepare failed: %s\n", snd_strerror(err));
             }
             return 0;
     }
     return err;
}


SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any 
 virus transmitted by this email.
Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html
