From: Irfan Shaikh <irfan.shaikh@sasken.com>
Subject: Re: Error in configuring playback device
Date: Tue, 15 Mar 2011 19:52:02 +0530
Message-ID: <16F32A3F9AF4E441B752BCD79C151ACA69D0BB56A4@EXGMBX01.sasken.com>
References: <16F32A3F9AF4E441B752BCD79C151ACA69D0BB56A2@EXGMBX01.sasken.com>,
	<4D7F7284.3000002@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta-blr1.sasken.com (mta-blr1.sasken.com [203.200.200.72])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F48D1038E2
	for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2011 15:22:05 +0100 (CET)
In-Reply-To: <4D7F7284.3000002@ladisch.de>
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
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

playback_handle gets initialized to NULL.
Therefore snd_pcm_close() does not gets executed in if condition
My snd_pcm_open() always fails for first time even if i reset my hardware.

Please provide me some hint so that i can over come the above issue

> if(playback_handle)
>       snd_pcm_close(playback_handle);
> snd_pcm_open(playback_handle);

This will work, as long as you ensure that playback_handle is always set
to NULL when the device is actually closed.

SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any 
 virus transmitted by this email.
Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html
