From: Irfan Shaikh <irfan.shaikh@sasken.com>
Subject: Re: Unable to open CAPTURE device
Date: Tue, 30 Nov 2010 15:35:46 +0530
Message-ID: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE3C1@EXGMBX01.sasken.com>
References: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE3B4@EXGMBX01.sasken.com>,
	<4CF4CA44.7010409@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta-blr1.sasken.com (mta-blr1.sasken.com [203.200.200.72])
	by alsa0.perex.cz (Postfix) with ESMTP id 9DF9224455
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 11:07:22 +0100 (CET)
In-Reply-To: <4CF4CA44.7010409@ladisch.de>
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

But Since ipod is connected using USB interface (USB Audio Class device).  Wont it be treated as USB Audio capture device ?

________________________________________
From: Clemens Ladisch [clemens@ladisch.de]
Sent: Tuesday, November 30, 2010 3:26 PM
To: Irfan Shaikh
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Unable to open CAPTURE device

Irfan Shaikh wrote:
> I have connected ipod to my hardware (using USB) and i want to read
> the audio pcm data from ipod. I am running following section of code
> to detect connection of ipod. But i am not finding any capture device
> connected.

The iPod is not a USB audio capture device.

> SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by an
 y virus transmitted by this email.
> Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html

This e-mail contains public information intended for any subscriber of
this mailing list and for anybody else who bothers to read it; it will
be copied, disclosed and distributed to the public.  If you think you
are not the intended recipient, please commit suicide immediately.
These terms apply also to any e-mails quoted in, referenced from, or
answering this e-mail, and supersede any confidentiality notices in
those e-mails.  Additionally, confidentiality notices in those e-mails
will incur legal processing fees of $42 per line; you have agreed to
this by reading this confidentiality notice.
