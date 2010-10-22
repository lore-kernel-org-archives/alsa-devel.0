From: Adam Rosenberg <adam@alcorn.com>
Subject: Re: Constraining the number of frames per period
Date: Fri, 22 Oct 2010 16:45:27 -0400
Message-ID: <AANLkTikr0ttrWCOiJEO-7GLvfLLUfRMA8Bii6wSD7qV6@mail.gmail.com>
References: <AANLkTi=v2DKXfptubtwEPfH_4eZJ-vwLqVHAkmf3iE2D@mail.gmail.com>
	<alpine.LNX.2.00.1010211649160.29422@eeebox2.perex-int.cz>
	<AANLkTikAf+o7e-=hosi+dwEywK-Mt5UTvJtqzT=i_5Fz@mail.gmail.com>
	<4CC13153.7040002@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B3711103863
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 22:45:52 +0200 (CEST)
Received: by wye20 with SMTP id 20so1313974wye.38
	for <alsa-devel@alsa-project.org>; Fri, 22 Oct 2010 13:45:47 -0700 (PDT)
In-Reply-To: <4CC13153.7040002@ladisch.de>
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

> > I am trying to constrain the number of frames per period (not the numbe=
r of
> > periods). =A0The DMA transfer creates an interrupt every 512 frames (1 =
frame =3D
> > 16 channels with 32bits per channel) . =A0I am having a difficult time
> > understanding how to properly write the ALSA driver so that it will work
> > with many different formats and between 1 and 2 channels.
>
> Using period_bytes_min/max doesn't work for this situation; these fields
> are intended for hardware that has constraints on the number of bytes.
>
> Set the snd_pcm_hardware fields so that all sample formats are supported.


I do not understand why I need to add all of the sample formats, but I
went ahead and changed snd_pcm_hardware to:
.formats =3D (SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S8 |
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0=A0 SNDRV_PCM_FMTBIT_U16_LE | SNDRV_PCM_=
FMTBIT_S16_LE |
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0=A0 SNDRV_PCM_FMTBIT_U16_BE | SNDRV_PCM_=
FMTBIT_S16_BE |
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0=A0 SNDRV_PCM_FMTBIT_U24_LE | SNDRV_PCM_=
FMTBIT_S24_LE |
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0=A0 SNDRV_PCM_FMTBIT_U24_BE | SNDRV_PCM_=
FMTBIT_S24_BE |
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0=A0 SNDRV_PCM_FMTBIT_U24_3LE | SNDRV_PCM=
_FMTBIT_S24_3LE |
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0=A0 SNDRV_PCM_FMTBIT_U24_3BE | SNDRV_PCM=
_FMTBIT_S24_3BE |
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0=A0 SNDRV_PCM_FMTBIT_U32_LE | SNDRV_PCM_=
FMTBIT_S32_LE |
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0=A0 SNDRV_PCM_FMTBIT_U32_BE | SNDRV_PCM_=
FMTBIT_S32_BE),


> In the PCM device's open callback, add another constraint by calling
> snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 512=
, 512);


Thank you!  This worked as you described and the applications now
select a period of 512 frames.


>> =A0 =A0 // the max number of bytes in one PCM stream
>> =A0 =A0 // must allow for a minimum of 4 periods with
>> =A0 =A0 // 512 frames per period and up to 2 channels of
>> =A0 =A0 // 32 bit data per frame
>> =A0 =A0 .buffer_bytes_max =3D 32768, =A0// this value allows 8 periods o=
f the max frame size

> Are the minimum 4 and maximum 8 periods actual hardware constraints?

Not really.  Mark Brown of WolfsonMicro helped me discover that I
needed at least 3 periods so that there would always be one playing in
the DMA buffer, one ready to play, and one able to be written to.  I
selected 4 periods as a minimum because it made it easier for me to
figure out good sizes for the DMA buffer.  There is no true hardware
constraint on the max number of periods but I do need to keep my DMA
period buffer size smaller than 64kb because the 2d transfer mode that
is implemented by the blackfin BF537 sport driver (bf5xx-sport.c)
doesn't seem to work properly.  If I stay below 64kb it doesn't need
to use 2d DMA mode.

I have had much better results after these changes but am still not
100% happy with the driver.  There is still some choppiness when
playing a wav file using aplay.  It seems like there are some xrun
conditions that occur just at the start of playback and then work
themselves out.  I am not sure if I have latest aplay because it came
with the Blackfin distribution of uClinux. I'll look into it further.
I also have some problems with the OSS emulation not working properly
every time.  I do not plan to use OSS in my actual application so I
can ignore that for now.

Thank you Clemens and Jaroslav for your help.  I will email again if I
have any more questions.

-Adam
