From: Irfan Shaikh <irfan.shaikh@sasken.com>
Subject: ALSA buffer query
Date: Thu, 11 Nov 2010 12:46:29 +0530
Message-ID: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE320@EXGMBX01.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta-blr1.sasken.com (mta-blr1.sasken.com [203.200.200.72])
	by alsa0.perex.cz (Postfix) with ESMTP id 255791037EE
	for <alsa-devel@alsa-project.org>; Thu, 11 Nov 2010 08:16:31 +0100 (CET)
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


      1) My understanding :  snd_pcm_writei() takes the allocated buffer from applications and passes the buffer beneath to the ASLA library and then to the ALSA driver for rendering Audio.

      2) Query 1 : Instead of me allocating the buffer in ALSA application and passing the pointer in snd_pcm_writei, Can ALSA allocate the buffer and give to my application, so that i can copy my data into it.

      3) Query 2 : Is there any wayto diirectly get hardware ALSA buffer from the ALSA driver to application so that i can copy PCM data to this buffer directly.
                          If not, is there any way can we do this ?



Thanks in Advance !

Regards
Irfan

SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any 
 virus transmitted by this email.
Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html
