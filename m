From: Ramya Desai <ramya.desai@gmail.com>
Subject: Re: Linux USB audio driver - sample code / link /
	documentation
Date: Fri, 26 Nov 2010 15:30:40 +0530
Message-ID: <AANLkTinfsCEq2ejnGnewY2fvYL-uztSV83z2_yhZbuQU@mail.gmail.com>
References: <AANLkTi=R_2dPhOGCB+5Dv_KUG3PrESg+Z+x1A_bhiTjr@mail.gmail.com>
	<4CEF66FA.3090405@ladisch.de>
	<AANLkTind0TDg=gcE0Pfu2BDaadk64FKgvM-3SNVLcobd@mail.gmail.com>
	<4CEF8412.8040002@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id C1B802449D
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 11:00:41 +0100 (CET)
Received: by ywg8 with SMTP id 8so987548ywg.38
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 02:00:41 -0800 (PST)
In-Reply-To: <4CEF8412.8040002@ladisch.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 26, 2010 at 3:25 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Ramya Desai wrote:
>> On Fri, Nov 26, 2010 at 1:21 PM, Clemens Ladisch <clemens@ladisch.de> wr=
ote:
>> > The simplest sample driver is this one:
>> > http://www.alsa-project.org/~clemens/ua1a.patch
>>
>> the source is also available at sound/usb/misc/ua101.c.
>
> No, that is for a different device. =A0The UA-101 requires
> synchronization between capture and playback stream; because
> of this, the UA-1A's driver is somewhat simpler.
>
> And there is no ALSA USB audio documentation.

Thanks again, Clemens.  I will post if I get any problem while
developing the driver.

Thanks and Regards,
Ramya.
