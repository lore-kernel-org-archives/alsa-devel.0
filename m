From: Bill Unruh <unruh@physics.ubc.ca>
Subject: Re: [Alsa-user] regarding setting of fragment size in
 usbaudio driver
Date: Mon, 13 Dec 2010 02:05:31 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1012130159430.31302@info.physics.ubc.ca>
References: <AANLkTimCg0kxCU1By9eg0Qba5hKMseS5rAZXsE_a4hOF@mail.gmail.com>
	<4D05E19D.7010405@ladisch.de>
	<27661_1292234220_1292234220_AANLkTi=S732=Wj572Th860PpBYE0fkJ97JH2CwitZ4ah@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="1737365482-172054269-1292234731=:31302"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from info.physics.ubc.ca (info.physics.ubc.ca [142.103.234.23])
	by alsa0.perex.cz (Postfix) with ESMTP id E65F810381E
	for <alsa-devel@alsa-project.org>; Mon, 13 Dec 2010 11:05:34 +0100 (CET)
In-Reply-To: <27661_1292234220_1292234220_AANLkTi=S732=Wj572Th860PpBYE0fkJ97JH2CwitZ4ah@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Amit Nagal <helloin.amit@gmail.com>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1737365482-172054269-1292234731=:31302
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 13 Dec 2010, Amit Nagal wrote:

> Hi ,
>
> Thanx for the reply .
>
> Actually on my embedded target ,  i am not using arecord , but reading
> from (/dev/dsp0) capture data .

He asked you if arecord works, not whether you are using it.=20
Why are you using the OSS emulation in alsa, rather than using the native
alsa? That adds an extra layer and more code.

>
> i have 2 question :
>
> i used SNDCTL_DSP_GETBLKSIZE ioctl to find the fragment size of driver
> . i found it to be 16k .
>
> 1) now if the application reads 4k data from userspace , read call
> will remain blocked for audio driver's fragment size usb data read (
> 16k)
> or app_request_size(4k) ?

So read in all 16K into your buffer. But you do not say how your applicatio=
n
reads that 4k in?

Why do you not publish the fragment of you code that you use so people can =
see
what y ou do.
As I understand OSS, the driver reads the usb and puts the output into a
buffer. YOur call to the oss system, then reads from that buffer and delive=
rs
it to you. That should not block, unless there is nothing in the buffer (ie
you forgot to tell the driver to start reading the sound card).

>
> 2)time taken for read(4k) =3D time_taken(fragment size read ) or
> time_taken(app_request_size=3D4k) ?
>
> thanx & regards
> amit nagal
>
>
> On Mon, Dec 13, 2010 at 6:04 PM, Clemens Ladisch <clemens@ladisch.de> wro=
te:
>> Amit Nagal wrote:
>>> i am using a OSS based usbaudio application for usb audio streaming .
>>>
>>> my usb audio device is capture only device .
>>>
>>> i want to set the fragment size of usbaudio alsa driver to reduce
>>> latency problem coming in my application .
>>>
>>> currently even if my application reads 4k data from userspace , i
>>> observed driver will buffer for 100 ms data ( period size data )=3D 16 =
k
>>> at 44100 frquency
>>>
>>> and after driver =A0reads 16k data , read call will return with 4k data
>>> . =A0so read() call remains blocked for 100ms which is causing some
>>> latency problem .
>>
>> There is no extra buffer in the driver.
>> There seems to be something wrong with your algorithm.
>>
>> Does recording with the arecord tool work?
>>
>>
>> Regards,
>> Clemens
>>
>
> -------------------------------------------------------------------------=
-----
> Oracle to DB2 Conversion Guide: Learn learn about native support for PL/S=
QL,
> new data types, scalar functions, improved concurrency, built-in packages=
,
> OCI, SQL*Plus, data movement tools, best practices and more.
> http://p.sf.net/sfu/oracle-sfdev2dev
> _______________________________________________
> Alsa-user mailing list
> Alsa-user@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-user
>

--=20
William G. Unruh   |  Canadian Institute for|     Tel: +1(604)822-3273
Physics&Astronomy  |     Advanced Research  |     Fax: +1(604)822-5324
UBC, Vancouver,BC  |   Program in Cosmology |     unruh@physics.ubc.ca
Canada V6T 1Z1     |      and Gravity       |  www.theory.physics.ubc.ca/
--1737365482-172054269-1292234731=:31302
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--1737365482-172054269-1292234731=:31302--
