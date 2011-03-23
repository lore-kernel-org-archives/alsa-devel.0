From: Irfan Shaikh <irfan.shaikh@sasken.com>
Subject: Re: Bad file descriptor : -EBADFD
Date: Wed, 23 Mar 2011 22:49:47 +0530
Message-ID: <16F32A3F9AF4E441B752BCD79C151ACA69D0BB56BA@EXGMBX01.sasken.com>
References: <16F32A3F9AF4E441B752BCD79C151ACA69D0BB56B7@EXGMBX01.sasken.com>,
	<4D89D9DB.3060001@ladisch.de>
	<16F32A3F9AF4E441B752BCD79C151ACA69D0BB56B8@EXGMBX01.sasken.com>,
	<4D8A17D2.6040305@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta-blr1.sasken.com (mta-blr1.sasken.com [203.200.200.72])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F11F103941
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2011 18:24:12 +0100 (CET)
In-Reply-To: <4D8A17D2.6040305@ladisch.de>
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

Hi Clemens,

Thanks for your reply

It is in PREPARED state at time of configuration.
But later when i use snd_pcm_writei first returns -11, then -77 then continous -EBADFD infinitely

To fix this i close my playback device and reconfigure it when above happens, then plays fine...This is fix. but not the solution.

Is there any other way of comming out of EBADFD to normal PREPARE state.

Regards,
Irfan


________________________________________
From: Clemens Ladisch [clemens@ladisch.de]
Sent: Wednesday, March 23, 2011 9:24 PM
To: Irfan Shaikh
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Bad file descriptor : -EBADFD

Irfan Shaikh wrote:
> I have used following check and it is success.
>
>  if (snd_pcm_hw_params(alsaParams->playback_handle,                                  \
>                           alsaParams->hwparams_playback) < 0)

Check the device's current state with snd_pcm_state(); it should be PREPARED.


Regards,
Clemens

SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any 
 virus transmitted by this email.
Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html
