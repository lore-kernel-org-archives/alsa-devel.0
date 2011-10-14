From: irfan shaikh <irfan.shaikh@sasken.com>
Subject: snd_pcm_open fails with -16 error
Date: Fri, 14 Oct 2011 12:05:53 +0530
Message-ID: <4E97D849.1080502@sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta-blr1.sasken.com (mta-blr1.sasken.com [203.200.200.72])
	by alsa0.perex.cz (Postfix) with ESMTP id 7627D2448B
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Oct 2011 08:36:51 +0200 (CEST)
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

Hello All,

A)
               In my application i am closing and reopening my device to
configure some hw_params for audio frequency change.
Close of PCM device is success, but reopen the same device fails

I get an below error
snd_pcm_open() FAIL with return value -16 {Device or resource busy}

How can i avoid above error. {I tried putting usleep between open and
close but doesn't work for me}


B)

I have even tried to configure the HW params in run time to avoid above
closing and opening of device.
But run time HW params configuartion failed.
Is there any way to change HW params at run time ? {My PCM device are in
RUNNING state and i want to change HW params at run time}


Thanks and regards,
Irfan



SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any 
 virus transmitted by this email.
Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html
