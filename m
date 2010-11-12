From: Rajul Kumar <rajul.manit1@gmail.com>
Subject: Re: ALSA error : frame 0 active: -75
Date: Fri, 12 Nov 2010 14:32:20 +0530
Message-ID: <AANLkTikfSDSttXDdaukMHNk+-AeZ6cByCxtmJgFRpCq_@mail.gmail.com>
References: <AANLkTin2wz0U-nociG9qMFP5R8ZhgVdDQASdXsezgzEh@mail.gmail.com>
	<4CDCFEF9.6060700@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 677FB103913
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 10:02:21 +0100 (CET)
Received: by qyk8 with SMTP id 8so28442qyk.17
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 01:02:20 -0800 (PST)
In-Reply-To: <4CDCFEF9.6060700@ladisch.de>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi ,

Thanx for the reply .
i have a few more queries . please find time to guide regarding these .

1)
is it possible to have some software solution from audio class driver
for  -EOVERFLOW condition ?

2)
As depicted from error-codes.txt , -EOVERFLOW can be indicative of
hardware problem also .

Can we be suggested how we can make sure that problem lies in the hardware =
only
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
> -75 =3D -EOVERFLOW
>
>> which is followed by coninous loop of below messages :
>>
>> ALSA sound/usb/usbaudio.c:354: frame 0 active: -71
>
> -71 =3D -EPROTO
>
>> ALSA sound/usb/usbaudio.c:354: frame 0 active: -18
>
> -18 =3D -EXDEV
>
> Documentation/usb/error-codes.txt says:
> | -EOVERFLOW (*) =A0 =A0 =A0 =A0 =A0The amount of data returned by the en=
dpoint was
> | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 greater than either the=
 max packet size of the
> | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 endpoint or the remaini=
ng buffer size. =A0"Babble".
>
> | -EPROTO (*, **) =A0 =A0 =A0 =A0 a) bitstuff error
> | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 b) no response packet r=
eceived within the
> | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0prescribed bus t=
urn-around time
> | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 c) unknown USB error
>
> | -EXDEV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ISO transfer only partially c=
ompleted
> | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 look at individual fram=
e status for details
>
> | (*) Error codes like -EPROTO, -EILSEQ and -EOVERFLOW normally indicate
> | hardware problems such as bad devices (including firmware) or cables.
>
>
> Regards,
> Clemens
>
