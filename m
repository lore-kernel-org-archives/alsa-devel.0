From: Amit Nagal <helloin.amit@gmail.com>
Subject: Re: regarding setting of fragment size in usbaudio
	driver
Date: Mon, 13 Dec 2010 18:56:41 +0900
Message-ID: <AANLkTi=S732=Wj572Th860PpBYE0fkJ97JH2CwitZ4ah@mail.gmail.com>
References: <AANLkTimCg0kxCU1By9eg0Qba5hKMseS5rAZXsE_a4hOF@mail.gmail.com>
	<4D05E19D.7010405@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9EDA410381A
	for <alsa-devel@alsa-project.org>; Mon, 13 Dec 2010 10:56:42 +0100 (CET)
Received: by qwj8 with SMTP id 8so6121515qwj.38
	for <alsa-devel@alsa-project.org>; Mon, 13 Dec 2010 01:56:41 -0800 (PST)
In-Reply-To: <4D05E19D.7010405@ladisch.de>
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
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi ,

Thanx for the reply .

Actually on my embedded target ,  i am not using arecord , but reading
from (/dev/dsp0) capture data .

i have 2 question :

i used SNDCTL_DSP_GETBLKSIZE ioctl to find the fragment size of driver
. i found it to be 16k .

1) now if the application reads 4k data from userspace , read call
will remain blocked for audio driver's fragment size usb data read (
16k)
 or app_request_size(4k) ?

2)time taken for read(4k) =3D time_taken(fragment size read ) or
time_taken(app_request_size=3D4k) ?

thanx & regards
amit nagal


On Mon, Dec 13, 2010 at 6:04 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Amit Nagal wrote:
>> i am using a OSS based usbaudio application for usb audio streaming .
>>
>> my usb audio device is capture only device .
>>
>> i want to set the fragment size of usbaudio alsa driver to reduce
>> latency problem coming in my application .
>>
>> currently even if my application reads 4k data from userspace , i
>> observed driver will buffer for 100 ms data ( period size data )=3D 16 k
>> at 44100 frquency
>>
>> and after driver =A0reads 16k data , read call will return with 4k data
>> . =A0so read() call remains blocked for 100ms which is causing some
>> latency problem .
>
> There is no extra buffer in the driver.
> There seems to be something wrong with your algorithm.
>
> Does recording with the arecord tool work?
>
>
> Regards,
> Clemens
>
