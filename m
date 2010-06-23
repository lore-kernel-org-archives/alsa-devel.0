From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: IEC switch issues
Date: Wed, 23 Jun 2010 12:04:53 -0500
Message-ID: <AANLkTilfyscblzlCkI2lBGR88uk33S_ZEUEbkahhPeS-@mail.gmail.com>
References: <AANLkTinpl5hs7NRAm38uF7FbGCOuIOxCvohD70jOQxam@mail.gmail.com>
	<4C21F88C.6000200@ladisch.de>
	<AANLkTik4XvRinUEUjqpqXdnxXFIcPGs9zcRk-_yf1xHW@mail.gmail.com>
	<4C2223C9.2080602@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 73DB4103809
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jun 2010 19:04:55 +0200 (CEST)
Received: by iwn8 with SMTP id 8so6037987iwn.38
	for <alsa-devel@alsa-project.org>; Wed, 23 Jun 2010 10:04:54 -0700 (PDT)
In-Reply-To: <4C2223C9.2080602@ladisch.de>
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

>> Actually the problem happens also with plain PCM rendered on the
>> iec958 device.There's no way to use the IEC switch.
>> So why do we have an S/PDIF switch in the first place?
>
> Because the hardware has this switch; the driver just exposes all
> hardware features.

Then why not use it if it is supported by the hardware? Usually we use
software as a workaround for hw limitations, not software to prevent
use of hardware features.

> Some codecs allow looping back the ADC output to the SPDIF transmitter.
> In these cases, disabling the SPDIF transmitter might be useful.

I am not sure I understand how your remark is related to the problem I
reported. Yes disabling SPDIF whenever needed is a must. And no
there's no risk with enabling the IEC switch when rendering on the
iec958 device. I have IEC-formatted data, with C,U,V,P bits and
preambles, this could not possibly be sent to anything else than the
digital output.
Again the IEC switch is functionally equivalent to a mute, and it
shows as such in alsamixer with the MM symbol: the data keeps being
rendered, only the receiver doesn't detect valid data (no sync
detected) and will go to silence with an appropriate ramp. For AC3
passthrough, the filter history will be reset when the sync is lost,
and that will cause an implicit fade-out/fade-in in addition to the
PCM ramp. There is no need as you asserted to send zeroes instead.
Removing the 'lock true' in /usr/share/alsa/cards/HDA-Intel.conf h
works just fine to enable IEC controls. Thanks Pavel for the pointer.
I suggest we modify this to remove artificial functionality
limitations.
