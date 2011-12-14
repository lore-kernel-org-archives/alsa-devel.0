From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: _mmap_playback_avail() short (was: Default device
 XRUNs with perriods=2)
Date: Wed, 14 Dec 2011 10:52:34 +0800
Message-ID: <CAN8cciZAvUt1nUu8bDMv=f3Y3OnBuZ4k4yu4Fiw64Fv0Oxpwxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F26D24425
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2011 03:52:35 +0100 (CET)
Received: by wgbdr1 with SMTP id dr1so520344wgb.20
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 18:52:34 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>> Do you require the sound card give you accurate playback position ?

>No.  Just accurate playback (or capture).  But reliably, on any system,
>without hardware-specific tweaks, 'out-of-the-box'.  Ideally with the
>potential for reasonable latency if the user requests that.  And not
>necessarily only on the 'latest' Alsa versions.

at 48000Hz, the hwptr of snd-ymfpci is increase to next boundary (256
frames). so you cannot get accurate playback position. this situation
can be emulated with snd-hda-intel by masking the value return by
pointer callback with 0xffffff00

>> snd-ymfpci only update hwptr in 5.3ms intervals
>>
>> it seem that snd-usb-audio update hwptr in 1ms
>>
>> > It seems the options are:-
>> >
>> > 1. Use 3 periods and accept worse latency, always filling with
>> > avail_frames
>>
>> snd-ymfpci has periods_min 3
>> and there are sound cards with periods_max = 2

>Yes, this is the sort of thing that makes it more difficult to create a good
>workaround.

seem only two drivers have this limitation , so you may ask the author
of those drivers whether it is feasible to change periods_max to a
higher value

drivers/dummy.c:	.periods_max = 2,
soc/samsung/idma.c:	.periods_max = 2,
