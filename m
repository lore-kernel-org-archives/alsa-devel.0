From: Irfan Shaikh <irfan.shaikh@sasken.com>
Subject: Re: ALSA error : frame 0 active: -75
Date: Fri, 12 Nov 2010 15:30:59 +0530
Message-ID: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE332@EXGMBX01.sasken.com>
References: <AANLkTin2wz0U-nociG9qMFP5R8ZhgVdDQASdXsezgzEh@mail.gmail.com>
	<4CDCFEF9.6060700@ladisch.de>,
	<AANLkTikfSDSttXDdaukMHNk+-AeZ6cByCxtmJgFRpCq_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta-blr1.sasken.com (mta-blr1.sasken.com [203.200.200.72])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C45710392C
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 11:02:37 +0100 (CET)
In-Reply-To: <AANLkTikfSDSttXDdaukMHNk+-AeZ6cByCxtmJgFRpCq_@mail.gmail.com>
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
To: Rajul Kumar <rajul.manit1@gmail.com>, Clemens Ladisch <clemens@ladisch.de>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Increase the size of your Capture Buffer in capture device (USB audio class)
I guess this would help you in solving the Overrun problem
________________________________________
From: alsa-devel-bounces@alsa-project.org [alsa-devel-bounces@alsa-project.org] On Behalf Of Rajul Kumar [rajul.manit1@gmail.com]
Sent: Friday, November 12, 2010 2:32 PM
To: Clemens Ladisch
Cc: tiwai@suse.de; alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] ALSA error : frame 0 active: -75

Hi ,

Thanx for the reply .
i have a few more queries . please find time to guide regarding these .

1)
is it possible to have some software solution from audio class driver
for  -EOVERFLOW condition ?

2)
As depicted from error-codes.txt , -EOVERFLOW can be indicative of
hardware problem also .

Can we be suggested how we can make sure that problem lies in the hardware only
( i mean via some code in usb stack or anything else ) .

3)

Are there some mandatory H/W requirements for   iso transfer usb signal
which may not be  required for bulk or other transfers ,
without which iso transfers can report H/W errors  anytime ?

how can usb signal be improved so as to perfectly support iso transfers ?


Thanx & Regards
Rajul




On Fri, Nov 12, 2010 at 2:16 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Rajul Kumar wrote:
>> ALSA sound/usb/usbaudio.c:354: frame 0 active: -75
>
> -75 = -EOVERFLOW
>
>> which is followed by coninous loop of below messages :
>>
>> ALSA sound/usb/usbaudio.c:354: frame 0 active: -71
>
> -71 = -EPROTO
>
>> ALSA sound/usb/usbaudio.c:354: frame 0 active: -18
>
> -18 = -EXDEV
>
> Documentation/usb/error-codes.txt says:
> | -EOVERFLOW (*)          The amount of data returned by the endpoint was
> |                         greater than either the max packet size of the
> |                         endpoint or the remaining buffer size.  "Babble".
>
> | -EPROTO (*, **)         a) bitstuff error
> |                         b) no response packet received within the
> |                            prescribed bus turn-around time
> |                         c) unknown USB error
>
> | -EXDEV                  ISO transfer only partially completed
> |                         look at individual frame status for details
>
> | (*) Error codes like -EPROTO, -EILSEQ and -EOVERFLOW normally indicate
> | hardware problems such as bad devices (including firmware) or cables.
>
>
> Regards,
> Clemens
>
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any 
 virus transmitted by this email.
Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html
