From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: IEC switch issues
Date: Wed, 23 Jun 2010 10:01:16 -0500
Message-ID: <AANLkTik4XvRinUEUjqpqXdnxXFIcPGs9zcRk-_yf1xHW@mail.gmail.com>
References: <AANLkTinpl5hs7NRAm38uF7FbGCOuIOxCvohD70jOQxam@mail.gmail.com>
	<4C21F88C.6000200@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f200.google.com (mail-yw0-f200.google.com
	[209.85.211.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 0752624394
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jun 2010 17:01:17 +0200 (CEST)
Received: by ywh38 with SMTP id 38so3899077ywh.23
	for <alsa-devel@alsa-project.org>; Wed, 23 Jun 2010 08:01:16 -0700 (PDT)
In-Reply-To: <4C21F88C.6000200@ladisch.de>
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

>> If I play my AC3 data on my HDAudio/SPDIF output using the hw:0,1
>> device, I can use alsamixer/amixer to mute/unmute.
>>
>> Now if I use the iec958: plugin, I can't control the mute switch any longer:
>
> Muting an AC-3 stream would require encoding a stream of silent PCM
> samples (no data is not the same as silence); therefore, the iec958
> plugin disallows muting.

Actually the problem happens also with plain PCM rendered on the
iec958 device.There's no way to use the IEC switch.
So why do we have an S/PDIF switch in the first place? If it cannot be
used when you sent IEC-formatted data (be that PCM or AC3-formatted
data), then why bother?
Allowing for mute doesn't have any impact on functionality, and it
prevents the user from muting with alsamixer or a gui. I find this
silly, or I am missing something.
