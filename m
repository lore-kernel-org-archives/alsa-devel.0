From: Irfan Shaikh <irfan.shaikh@sasken.com>
Subject: Getting played tsms in ALSA
Date: Fri, 19 Aug 2011 15:09:12 +0530
Message-ID: <16F32A3F9AF4E441B752BCD79C151ACA69DC1B32F8@EXGMBX01.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta-blr1.sasken.com (mta-blr1.sasken.com [203.200.200.72])
	by alsa0.perex.cz (Postfix) with ESMTP id 515C410391D
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Aug 2011 11:39:58 +0200 (CEST)
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


Hello all

                  At setup time, when we create alsa handle and get the pcm_status object from it.

/******************************/
snd_pcm_status *status;
snd_pcm_status_alloca(&status);
At run time:
snd_timestamp_t timestamp = {0};
snd_pcm_status(pcm_handle, status);
snd_pcm_status_get_tstamp(status, &timestamp);
print timestamp.tv_sec and timestamp.tv_usec
/******************************/

Here when we start first instance, timestamp.tv_sec goes incrementing as we play as expected.
But we when shutdown (destroy alsa handle, re-init) , the timestamps increase from the same point.
i.e if we stopped playback at time x secs, the next instance starts showing the time from x secs.
The time reported by snd_pcm_status_get_tstamp() resets after we reboot the board.

Another observation is that when we have two instances. We start the first instance , pause it after x secs.
And then start the next instance, the time given by ALSA again starts at x secs.

I think the snd_pcm_get_tstamp should be handle based but it seems it's not the case.

How can we reset the timestamp values ?


Regards

SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any 
 virus transmitted by this email.
Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html
