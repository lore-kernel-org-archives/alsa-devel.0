From: Manuel Jander <manuel.jander@gmail.com>
Subject: Re: [PATCH] ALSA au88x0: Fix IRQ fifo error and
 channels swap of 4 channels playback
Date: Sun, 8 Jan 2012 18:45:18 +0100
Message-ID: <CACRof1U=UohMqJWXe108qwwu-zfP4AeDVcjuFOyoVyP3+zadzQ@mail.gmail.com>
References: <CAN8cciYgJ9U0aS6np4nV+uws_0VEgmRXE2ocaLdc_7MgS6_7+w@mail.gmail.com>
	<CACRof1UDjOjw4XUU3q-WTJi4U6Osg=eHLoV6g0bz2yBC1FdjTw@mail.gmail.com>
	<CAN8cciYCHQNET-dVTLL29w4a+yn1xghfHNCb4Y38u8SqqwQCog@mail.gmail.com>
	<s5hsjjql3bt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9ACCB103925
	for <alsa-devel@alsa-project.org>; Sun,  8 Jan 2012 18:45:21 +0100 (CET)
Received: by iaae16 with SMTP id e16so5538461iaa.38
	for <alsa-devel@alsa-project.org>; Sun, 08 Jan 2012 09:45:19 -0800 (PST)
In-Reply-To: <s5hsjjql3bt.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I can't remember why "pause fifo" is being called instead of "stop
fifo". If using the latter fixes channel swap, then I would guess that
the "stop" operation ensures that the DMA starts at an appropriate
aligned address, thus avoiding shifted data when the interleaved
channel get multiplexed to the AC97 codec. But that is just a wild
guess.

Best Regards, and thanks a lot, all of you.
Manuel


On Sun, Jan 8, 2012 at 2:40 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Sat, 7 Jan 2012 15:05:37 +0800,
> Raymond Yau wrote:
>>
>> 2012/1/6, Manuel Jander <manuel.jander@gmail.com>:
>> > Hi,
>> >
>> > thanks a lot. I tried your attached patch to 2.6.39 and in compiles
>> > and works OK as far as I can tell. I have not tested with 4 channel
>> > items though.
>> >
>> > Best Regards,
>> > Manuel
>> >
>> > On Fri, Jan 6, 2012 at 3:22 AM, Raymond Yau <superquad.vortex2@gmail.c=
om>
>> > wrote:
>> >> [PATCH ] ALSA au88x0 - Fix IRQ fifo error and channels swap of 4
>> >> channels playback
>> >>
>> >> - Fix IRQ fifo error when playing stereo by set stereo flag of fifo
>> >> control
>> >> =A0This also fix the swap of front and rear channels on au8830
>> >>
>> >>
>> >> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D1840
>> >>
>> >> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D1726
>> >
>>
>> The patch only fix "IRQ fifo error"
>>
>> Still need the following patch to fix the channel swaping of 4 channels =
playback
>>
>> Is there any reason to use vortex_adbdma_pausefifo() instead of
>> vortex_adbdma_stopfifo() for SNDRV_PCM_TRIGGER_STOP event ?
>>
>> Refer to page 28 of 6167465
>>
>> Stereo flag 505(i) may be set or reset appropriately, depending on the
>> type of DMA channel
>> ...
>> 505(c) The channel valid flag indicates that the particular has been
>> activated and the appropriate sub-buffer table 380, FIFO control
>> register 505 and FIFO 306 are active
>>
>>
>> =A0[PATCH ALSA] Au88x0 - Fix channels swapping of 4 channels playback
>>
>> - Fix channels swapping of 4 channels playback by
>> =A0 using vortex_adbdma_stopfifo instead of vortex_adbdma_pausefifo
>> =A0 for SNDRV_PCM_TRIGGER_STOP event
>
> OK, now applied both patches.
> Let me know if anything gets wrong.
>
>
> thanks,
>
> Takashi
