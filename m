From: Irfan Shaikh <irfan.shaikh@sasken.com>
Subject: Re: Query about Playback device name
Date: Wed, 9 Mar 2011 20:33:13 +0530
Message-ID: <16F32A3F9AF4E441B752BCD79C151ACA69D0BB5690@EXGMBX01.sasken.com>
References: <16F32A3F9AF4E441B752BCD79C151ACA69D0BB5681@EXGMBX01.sasken.com>,
	<4D776867.9040905@ladisch.de>
	<16F32A3F9AF4E441B752BCD79C151ACA69D0BB568D@EXGMBX01.sasken.com>,
	<4D778D18.8070603@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta-blr1.sasken.com (mta-blr1.sasken.com [203.200.200.72])
	by alsa0.perex.cz (Postfix) with ESMTP id 5531A1039BF
	for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2011 16:04:29 +0100 (CET)
In-Reply-To: <4D778D18.8070603@ladisch.de>
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

YES....
I am running my application as well as aplay on the same embedded platform with same user

________________________________________
From: Clemens Ladisch [clemens@ladisch.de]
Sent: Wednesday, March 09, 2011 7:52 PM
To: Irfan Shaikh
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Query about Playback device name

Irfan Shaikh wrote:
> I get following error on console if i use  plug:mcasp3  instead  plughw:0,0
> ALSA lib pcm.c:2211:(snd_pcm_open_noupdate) Unknown PCM mcasp3

Do aplay and your program run on same computer as the same user?


Regards,
Clemens

SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any 
 virus transmitted by this email.
Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html
