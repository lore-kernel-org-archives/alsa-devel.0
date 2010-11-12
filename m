From: Rajul Kumar <rajul.manit1@gmail.com>
Subject: Re: ALSA error : frame 0 active: -75
Date: Fri, 12 Nov 2010 15:40:22 +0530
Message-ID: <AANLkTi=-2gdXf-JJjVFdkmGbdNq_zN+NJezCgYudx6W4@mail.gmail.com>
References: <AANLkTin2wz0U-nociG9qMFP5R8ZhgVdDQASdXsezgzEh@mail.gmail.com>
	<4CDCFEF9.6060700@ladisch.de>
	<AANLkTikfSDSttXDdaukMHNk+-AeZ6cByCxtmJgFRpCq_@mail.gmail.com>
	<16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE332@EXGMBX01.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 62836103920
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 11:10:24 +0100 (CET)
Received: by qwj8 with SMTP id 8so21715qwj.38
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 02:10:23 -0800 (PST)
In-Reply-To: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE332@EXGMBX01.sasken.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Irfan Shaikh <irfan.shaikh@sasken.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Hi ,

Thanx for your reply .

We are simply using audio class driver and linux usb host stack .
Can u let me know more regarding which capture buffer size to increase
we are doing usb audio streaming on usb host side .

Thanx & Regards
Rajul

On Fri, Nov 12, 2010 at 3:30 PM, Irfan Shaikh <irfan.shaikh@sasken.com> wro=
te:
> Increase the size of your Capture Buffer in capture device (USB audio cla=
ss)
> I guess this would help you in solving the Overrun problem
> ________________________________________
> From: alsa-devel-bounces@alsa-project.org [alsa-devel-bounces@alsa-projec=
t.org] On Behalf Of Rajul Kumar [rajul.manit1@gmail.com]
> Sent: Friday, November 12, 2010 2:32 PM
> To: Clemens Ladisch
> Cc: tiwai@suse.de; alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] ALSA error : frame 0 active: -75
>
> Hi ,
>
> Thanx for the reply .
> i have a few more queries . please find time to guide regarding these .
>
> 1)
> is it possible to have some software solution from audio class driver
> for =A0-EOVERFLOW condition ?
>
> 2)
> As depicted from error-codes.txt , -EOVERFLOW can be indicative of
> hardware problem also .
>
> Can we be suggested how we can make sure that problem lies in the hardwar=
e only
> ( i mean via some code in usb stack or anything else ) .
>
> 3)
>
> Are there some mandatory H/W requirements for =A0 iso transfer usb signal
> which may not be =A0required for bulk or other transfers ,
> without which iso transfers can report H/W errors =A0anytime ?
>
> how can usb signal be improved so as to perfectly support iso transfers ?
>
>
> Thanx & Regards
> Rajul
>
>
>
>
> On Fri, Nov 12, 2010 at 2:16 PM, Clemens Ladisch <clemens@ladisch.de> wro=
te:
>> Rajul Kumar wrote:
>>> ALSA sound/usb/usbaudio.c:354: frame 0 active: -75
>>
>> -75 =3D -EOVERFLOW
>>
>>> which is followed by coninous loop of below messages :
>>>
>>> ALSA sound/usb/usbaudio.c:354: frame 0 active: -71
>>
>> -71 =3D -EPROTO
>>
>>> ALSA sound/usb/usbaudio.c:354: frame 0 active: -18
>>
>> -18 =3D -EXDEV
>>
>> Documentation/usb/error-codes.txt says:
>> | -EOVERFLOW (*) =A0 =A0 =A0 =A0 =A0The amount of data returned by the e=
ndpoint was
>> | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 greater than either th=
e max packet size of the
>> | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 endpoint or the remain=
ing buffer size. =A0"Babble".
>>
>> | -EPROTO (*, **) =A0 =A0 =A0 =A0 a) bitstuff error
>> | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 b) no response packet =
received within the
>> | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0prescribed bus =
turn-around time
>> | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 c) unknown USB error
>>
>> | -EXDEV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ISO transfer only partially =
completed
>> | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 look at individual fra=
me status for details
>>
>> | (*) Error codes like -EPROTO, -EILSEQ and -EOVERFLOW normally indicate
>> | hardware problems such as bad devices (including firmware) or cables.
>>
>>
>> Regards,
>> Clemens
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
> SASKEN BUSINESS DISCLAIMER: This message may contain confidential, propri=
etary or legally privileged information. In case you are not the original i=
ntended Recipient of the message, you must not, directly or indirectly, use=
, disclose, distribute, print, or copy any part of this message and you are=
 requested to delete it and inform the sender. Any views expressed in this =
message are those of the individual sender unless otherwise stated. Nothing=
 contained in this message shall be construed as an offer or acceptance of =
any offer by Sasken Communication Technologies Limited ("Sasken") unless se=
nt with that express intent and with due authority of Sasken. Sasken has ta=
ken enough precautions to prevent the spread of viruses. However the compan=
y accepts no liability for any damage caused by any virus transmitted by th=
is email.
> Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html
>
