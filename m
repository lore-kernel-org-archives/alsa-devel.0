Return-Path: <SRS0=Pedv=NE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2F4C4338F
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Aug 2021 17:08:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E724161151
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Aug 2021 17:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E724161151
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AAF5F1849;
	Fri, 13 Aug 2021 19:07:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AAF5F1849
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628874476;
	bh=/e7B2gd5Nt3mPxdSc/yqUO97OjtlzVcDUbxhp1DJxt4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qi6xQissCAONxIlguVbX2U2rro6UsyY43742X8Ow2l01hLbvKEADTv9YvxlGGy6ui
	 PJOg3VLKkBjEXCnX4EXPeu8uTJ6WXLRE7n7M2R+efirnXZ/I/rdHHfdj1k1txIMivj
	 w6wlwAyHJ82d348wtWw4ijfTDEclul6bvKl/RGtY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C7FAAF800AF;
	Fri, 13 Aug 2021 19:07:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0275AF802D2; Fri, 13 Aug 2021 19:07:03 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B77CDF800AF
 for <alsa-devel@alsa-project.org>; Fri, 13 Aug 2021 19:06:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B77CDF800AF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="K6S9uSIQ"
Received: by mail-pj1-x1032.google.com with SMTP id
 hv22-20020a17090ae416b0290178c579e424so16858611pjb.3
 for <alsa-devel@alsa-project.org>; Fri, 13 Aug 2021 10:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=83QMaYgOJJuYsR2kxYZiVuev/+nUJCI6rEb/EnIuDuY=;
 b=K6S9uSIQBUUpZB9iABEX+ve85F1dwCHr3uAQbi8ML1kens9wmCetu9NNuGyJBTWJ+q
 eORIZ01bhl1djBgXHw/+hP6CS+hlHnVZf/3Unt6foZz/mpzZTa/G/5yLXkQBP86p2ryE
 EHxLk6+PReH3k1neFctFbQZDA04Dvx3fTX3vsM0kma6V1iwtbAO5NLiOQoIWi6H6gwp1
 3H03u+zuQ6MaUKhfOhbroQMrBwX1MT84tpLO7wFEpZ39qf403f5048/NtJKbE+ZRozGr
 fPhhXtcASvfhJE2L51NUeMRwCQO1y5kZrhRq0N79lsCAICOJ7Q4RWn2yOneEZJpbDzZZ
 UJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=83QMaYgOJJuYsR2kxYZiVuev/+nUJCI6rEb/EnIuDuY=;
 b=E2fwOxEzagAybCILVe9messy1wMG6zlGQBg4SLjXN+F6Die0m1EClZHVi9Xb/6eDbB
 bqUvVaUEUYN3KXDv+bTXq6OGB34bma1Ld9y6/Xd8i4jcTSqppdwOv8nT1cu5AiWoDNcN
 7L65mkjXYF/9W2biErpKa7VAjIM3GWfciNmeu9Yj/9O0TqUttCOgRCzDAepz/j+h1lKV
 PC3ehPVbJTbuRn8kpzcYc6cjjPhJQZIwaLqHHTRj/aUfA8TKuR3tzO3wde79pRJ8PVO2
 KA/N4tUReMIsoV41PdtQcNJY4E9V8yiWx+NARpiEuQCqtetLwDNEuI92902UPj/CULz/
 2aOg==
X-Gm-Message-State: AOAM530kXhpYcWE/90VhPn3f4NBguJ/x09QqxghVJujEvSjYIAid5Xft
 1ixPkEVgit3nCsoEiNSNpJRg5MBxFsjJEKrmluU=
X-Google-Smtp-Source: ABdhPJzVrUR44aZ5Gl98WYuXTGRBEuaY5gOnseyJaYAFHEgkgt09tShqlq6uLkxrWm/s1RcBJ0Euqu3PM06mRNEHUmE=
X-Received: by 2002:aa7:8757:0:b0:3e0:ff06:aea4 with SMTP id
 g23-20020aa78757000000b003e0ff06aea4mr3122318pfo.38.1628874409176; Fri, 13
 Aug 2021 10:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAHhAz+hQBnUVWBnoQO6y44C-G5CnZdFLJ7v738_Y5Rt6AZSkrA@mail.gmail.com>
 <41bebccc-7940-8379-0108-047bd1cc92f9@perex.cz>
 <CACk2A5ZcrVTv4AVHdmRDh-xWkx=1BHi6SV8yYqX1Z2DzcDR8hA@mail.gmail.com>
 <CAHhAz+gD-UtvXgsWnWx8yPwMbpY4R-ZJqPg9TNNF+iZrmKxQSA@mail.gmail.com>
 <CAHhAz+jVm6_B8Fje5TafKFFXk9x801z07afivsfHw7tWp4eB=w@mail.gmail.com>
In-Reply-To: <CAHhAz+jVm6_B8Fje5TafKFFXk9x801z07afivsfHw7tWp4eB=w@mail.gmail.com>
From: vishnu <vardhanraj4143@gmail.com>
Date: Fri, 13 Aug 2021 22:36:38 +0530
Message-ID: <CACk2A5aq6yu-0+oUcgx-1_D0byOU-0Hj3XdMfu7zsuHPz5oxjw@mail.gmail.com>
Subject: Re: USB-Audio: Device or resource busy (strace log)
To: Muni Sekhar <munisekharrms@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: alsa-devel <alsa-devel@alsa-project.org>,
 kernelnewbies <kernelnewbies@kernelnewbies.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

You can disable pulseaudio by following below link..

https://askubuntu.com/questions/8425/how-to-temporarily-disable-pulseaudio


But need to find why its not working..

On Fri, Aug 13, 2021, 21:59 Muni Sekhar <munisekharrms@gmail.com> wrote:

> On Wed, Aug 11, 2021 at 6:48 PM Muni Sekhar <munisekharrms@gmail.com>
> wrote:
> >
> > On Wed, Aug 11, 2021 at 6:19 PM vishnu <vardhanraj4143@gmail.com> wrote:
> > >
> > > can you paste output of
> > > arecord -l (list of capture devices).
> > $ arecord -l
> > **** List of CAPTURE Hardware Devices ****
> > card 0: USB [Plantronics .Audio 628 USB], device 0: USB Audio [USB Audio]
> >   Subdevices: 1/1
> >   Subdevice #0: subdevice #0
> >
> >
> > > Which device you are using and os.
> > > Does this instance is already open by default? like any video playing
> or something like that?
> > lsof does not catch it.
> >
> > >
> > > Yes you can stop pulse audio and try..
> > >
> > > On Wed, Aug 11, 2021 at 6:17 PM Jaroslav Kysela <perex@perex.cz>
> wrote:
> > >>
> > >> On 11. 08. 21 14:36, Muni Sekhar wrote:
> > >> > Hi All,
> > >> >
> > >> > $ cat /proc/asound/cards
> > >> >  0 [USB            ]: USB-Audio - Plantronics .Audio 628 USB
> > >> >                       Plantronics Plantronics .Audio 628 USB at
> > >> > usb-0000:00:14.0-2, full speed
> > >> >
> > >> > I am using a Plantronics USB Audio headset.
> > >> >
> > >> > $ arecord --device hw:0,0 --channels 2 --format S16_LE --rate
> 44100Hz x.wav
> > >> > arecord: main:722: audio open error: Device or resource busy
> > >> >
> > >> >
> > >> > 'arecord' command always fails the first time after system boot in
> my
> > >> > system. But subsequent execution of the 'arecord' command runs fine.
> > >> >
> > >> >
> > >> > I've attached the strace log for the "audio open error: Device or
> > >> > resource busy" failure. Is there any fix available for this issue?
> > >>
> > >> You may check which other task blocks the PCM device:
> > >>
> > >>   lsof /dev/snd/pcmC0D0c
> > It does not output any process.
> > $ lsof /dev/snd/pcmC0D0c
> >
> > 1st run:
> > ----------
> > $ arecord --device hw:0,0 --channels 2 --format S16_LE --rate 44100Hz
> x.wav
> > arecord: main:722: audio open error: Device or resource busy
> >
> > 2nd run:
> > ----------
> > $ arecord --device hw:0,0 --channels 2 --format S16_LE --rate 44100Hz
> x.wav
> > Recording WAVE 'x.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
> Stereo
> > ^CAborted by signal Interrupt...
> >
> >
> > >>
> > >> I guess that it will be pulseaudio (device enumeration).
> I see that pulseaudio is getting loaded on invoking the 1st run of
> 'arecord' command. Here is the log:
>
> After system boot I verified that pulseaudio is not in the memory.
>
> test@test594:~$ uptime
>  21:39:27 up 0 min,  1 user,  load average: 0.70, 0.25, 0.09
> test@test594:~$ ls -ltr /dev/snd/controlC1
> crw-rw---- 1 root audio 116, 2 Aug 13 21:38 /dev/snd/controlC1
> test@test594:~$ ls -ltr /dev/snd/
> total 0
> crw-rw---- 1 root audio 116, 33 Aug 13 21:38 timer
> crw-rw---- 1 root audio 116,  1 Aug 13 21:38 seq
> crw-rw---- 1 root audio 116,  3 Aug 13 21:38 pcmC1D0p
> crw-rw---- 1 root audio 116,  4 Aug 13 21:38 pcmC1D0c
> crw-rw---- 1 root audio 116,  2 Aug 13 21:38 controlC1
> drwxr-xr-x 2 root root       60 Aug 13 21:38 by-path
> drwxr-xr-x 2 root root       60 Aug 13 21:38 by-id
> test@test594:~$ lsof /dev/snd/controlC1
> test@test594:~$ lsof /dev/snd/pcmC1D0c
> test@test594:~$
>
>
> 1st run of 'arecord':
> -------------------------
> I triggered 'arecord' after 2 mins of the system boot. In the 1st run,
> it failed with "Device or resource busy" and I see that pulseaudio
> loaded in the memory.
> Why does pulseaudio get triggered on running the alsa-utils command?
> How is the failure message "Device or resource busy" from the kernel code?
>
>
> test@test594:~$ arecord --device hw:1,0 --channels 2 --format S16_LE
> --rate 44100Hz x.wav
> arecord: main:722: audio open error: Device or resource busy
> test@test594:~$
> test@test594:~$ lsof /dev/snd/pcmC1D0c
> COMMAND    PID   USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
> pulseaudi 1550 test  mem    CHR  116,4           463 /dev/snd/pcmC1D0c
> pulseaudi 1550 test   27u   CHR  116,4      0t0  463 /dev/snd/pcmC1D0c
> test@test594:~$ lsof /dev/snd/controlC1
> COMMAND    PID   USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
> pulseaudi 1550 test   20u   CHR  116,2      0t0  461 /dev/snd/controlC1
> pulseaudi 1550 test   26u   CHR  116,2      0t0  461 /dev/snd/controlC1
> test@test594:~$ lsof /dev/snd/pcmC1D0p
> test@test594:~$
> test@test594:~$ uptime
>  21:41:06 up 2 min,  1 user,  load average: 0.20, 0.19, 0.08
>
>
> 2nd run of 'arecord':
> -------------------------
> The subsequent run of arecord runs fine without any issues even though
> pulseaudio is still in memory.
>
> test@test594:~$ arecord --device hw:1,0 --channels 2 --format S16_LE
> --rate 44100Hz x.wav
> Recording WAVE 'x.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
> ^CAborted by signal Interrupt...
> test@test594:~$ uptime
>  21:41:22 up 2 min,  1 user,  load average: 0.14, 0.18, 0.08
> test@test594:~$
>
> What is the role of pulseaudio? Is there a way to disable it from running
> it?
> Disabling pulseaudio causes any issues while testing audio drivers?
>
>
> > >>
> > >>                                         Jaroslav
> > >>
> > >> --
> > >> Jaroslav Kysela <perex@perex.cz>
> > >> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
> >
> >
> >
> > --
> > Thanks,
> > Sekhar
>
>
>
> --
> Thanks,
> Sekhar
>
