From: Irfan Shaikh <irfan.shaikh@sasken.com>
Subject: Re: Unable to open CAPTURE device
Date: Wed, 1 Dec 2010 11:03:55 +0530
Message-ID: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE3C8@EXGMBX01.sasken.com>
References: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE3B4@EXGMBX01.sasken.com>,
	<4CF4CA44.7010409@ladisch.de>
	<16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE3C1@EXGMBX01.sasken.com>,
	<4CF519D6.8050601@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta-blr1.sasken.com (mta-blr1.sasken.com [203.200.200.72])
	by alsa0.perex.cz (Postfix) with ESMTP id 5233D1037F3
	for <alsa-devel@alsa-project.org>; Wed,  1 Dec 2010 06:36:18 +0100 (CET)
In-Reply-To: <4CF519D6.8050601@ladisch.de>
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

Now i am able to open ipod as capture device.
The problem was ipod was been shown as the mass storage device (/dev/sda1).   //snd_pcm_open was failing
I reconfigured my ipod so that is is being showed as usbaudio class device.            // Works fine now

Thanks for your inputs,
Regards
Irfan
________________________________________
From: Clemens Ladisch [clemens@ladisch.de]
Sent: Tuesday, November 30, 2010 9:05 PM
To: Irfan Shaikh
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Unable to open CAPTURE device

Irfan Shaikh wrote:
> But Since ipod is connected using USB interface (USB Audio Class
> device).  Wont it be treated as USB Audio capture device ?

In that case, yes.

Does the device show up in /proc/asound/cards?


Regards,
Clemens

SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any 
 virus transmitted by this email.
Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html
