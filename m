From: Alexandre <alxgomz@gmail.com>
Subject: Re: unsupported variant of snd_hda_intel
Date: Fri, 1 Oct 2010 20:44:58 -1000
Message-ID: <AANLkTikO0QKPO0pfbUj7zJq1Em5v_TWY1b-dZu6VhMPA@mail.gmail.com>
References: <AANLkTinDxaesb-=AZi8sALtw6MkERjMr3WK7Nixkv06P@mail.gmail.com>
	<AANLkTik3nGq22b0t+f3NMn23CK7x5b+hLJpaW9rjhr0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9AFC4245A5
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Oct 2010 08:44:59 +0200 (CEST)
Received: by qyk2 with SMTP id 2so5237990qyk.17
	for <alsa-devel@alsa-project.org>; Fri, 01 Oct 2010 23:44:58 -0700 (PDT)
In-Reply-To: <AANLkTik3nGq22b0t+f3NMn23CK7x5b+hLJpaW9rjhr0Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I don't know to read chineese but setting options to
model=3D"acer-aspire-4930g" doen't help.
internal microphone still dont work...
I am not sure if it is alsa or pulseaudio related.
How could I test the internal mic by passing pulseaudio?

2010/10/1 Raymond Yau <superquad.vortex2@gmail.com>:
> 2010/10/2 Alexandre <alxgomz@gmail.com>
>
>> Hello,
>>
>> I have an Acer Aspire 4736G laptop.
>> The soundcard that is shipped in this laptop is intel-hda based as
>> shown (actually it's a realtek):
>>
>> cat /proc/asound/cards
>> =A00 [Intel =A0 =A0 =A0 =A0 =A0]: HDA-Intel - HDA Intel
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0HDA Intel at 0x9b300000 irq 46
>>
>> Basic sound output is correct but few feature are missing:
>> - internal mic seems to be found but do not works.
>> - sound output stop working when trying to send it using HDMI output
>> - heads do not work when plugged neither when forcing pulseaudio to use =
it.
>>
>> I have an ubuntu 10.10 which is shipped with alsa 1.0.23.
>> I have googled around and tried loading the snd-hda-intel with several
>> parameters () as found in HD-Audio-Models.txt to no avail.
>>
>> cat /proc/asound/pcm
>> 00-00: ALC888 Analog : ALC888 Analog : playback 1 : capture 1
>> 00-01: ALC888 Digital : ALC888 Digital : playback 1
>> 00-03: NVIDIA HDMI : NVIDIA HDMI : playback 1
>>
>> Where can I begin to help implement the support for this sound card? I
>> have very skills in developement in general but am ready to try if it
>> is not to hard (I supose I can use previous code for similar models)..
>> I just need a shepherd.
>>
>> Thanks
>>
>
> according to* *wheat0r in
>
> http://forum.ubuntu.com.cn/viewtopic.php?f=3D74&t=3D216956&view=3Dnext
>
> His 4736g work with model=3D"acer-aspire-4930g"
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
