From: Irfan Shaikh <irfan.shaikh@sasken.com>
Subject: snd_pcm_prepare FAILS
Date: Tue, 1 Mar 2011 14:28:32 +0530
Message-ID: <16F32A3F9AF4E441B752BCD79C151ACA69D0BB5669@EXGMBX01.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta-blr1.sasken.com (mta-blr1.sasken.com [203.200.200.72])
	by alsa0.perex.cz (Postfix) with ESMTP id 7ED5724769
	for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2011 09:58:36 +0100 (CET)
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

Hello,

        I have been using following section of code, my snd_pcm_prepare() always fails and i am not able to  play audio using snd_pcm_writei().

    /******************************Code*********************************/
    err=snd_pcm_prepare(handle);
    if (err < 0)
        RSE_TRACE_ERROR(MP_ALSA_TRACE,("Can't recovery from underrun, prepare failed: %s\n", snd_strerror(err)));
    /**********************************************************************/

    $$$$$$$$$$$$    Output : Can't recovery from underrun, prepare failed: Device or resource busy  $$$$$$$$$$$$$


    Can some one please share there comments on the above. What is going run above.

Regards,





SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any 
 virus transmitted by this email.
Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html
