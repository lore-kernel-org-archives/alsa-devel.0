From: Amit Nagal <helloin.amit@gmail.com>
Subject: Re: reset of kernel input buffer for /dev/dsp
Date: Mon, 29 Nov 2010 17:40:03 +0900
Message-ID: <AANLkTimAqNDjnFpumTQrTC2+9wcA=N9g72ccVvrqTXMY@mail.gmail.com>
References: <AANLkTi=EzbQc__Z+4JCrMNbGpWoKWKmyX+BFhuLcKt7T@mail.gmail.com>
	<4CF35D9B.40202@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 110B0103853
	for <alsa-devel@alsa-project.org>; Mon, 29 Nov 2010 09:40:03 +0100 (CET)
Received: by qyk11 with SMTP id 11so4293602qyk.17
	for <alsa-devel@alsa-project.org>; Mon, 29 Nov 2010 00:40:03 -0800 (PST)
In-Reply-To: <4CF35D9B.40202@ladisch.de>
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
Cc: alsa-user@lists.sourceforge.net, tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi ,

Thanx for the reply .

we tried SNDCTL_DSP_RESET , but it is not flushing  the kernel pcm
buffer for us  .

any other method which we can use ?

also please lets us the function available with alsa - lib which
serves the purpose of flushing
the kernel pcm buffer .

thanx & regards
amit nagal






On Mon, Nov 29, 2010 at 5:00 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Amit Nagal wrote:
>> we want to flush =A0kernel input pcm buffer =A0without using close() sys=
tem call .
>>
>> does OSS supports in userspace any ioctl call which can flush kernel
>> pcm buffer at any time .
>
> SNDCTL_DSP_RESET
>
>
> Regards,
> Clemens
>
