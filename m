From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: [PATCH 0/6] snd-usb endpoint rework, version 7
Date: Fri, 13 Apr 2012 16:10:52 +0200
Message-ID: <CAFz=ag7qsXvCu7wNrb70au3b9cFkBhmsi5xTKsH7ArDib_sYUA@mail.gmail.com>
References: <1334231475-20980-1-git-send-email-zonque@gmail.com>
	<CACckToUX5iLjbdtjsEFOPk1uBw63EBROe=bj9qokaczB6P5LrQ@mail.gmail.com>
	<CACckToU+zq2jrPFRJmYGA05REtfPkRjf05JqiGY+bSyDkk=p+w@mail.gmail.com>
	<4F87C587.9000101@gmail.com>
	<CAFz=ag7_Yj_VkfW9HWnB1=y6s+rFVJZ_VK06-jZ70U_k=Y_Ksw@mail.gmail.com>
	<s5haa2gqdc4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1AC2110B94C
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Apr 2012 16:10:53 +0200 (CEST)
Received: by yhnn12 with SMTP id n12so1706441yhn.38
	for <alsa-devel@alsa-project.org>; Fri, 13 Apr 2012 07:10:53 -0700 (PDT)
In-Reply-To: <s5haa2gqdc4.wl%tiwai@suse.de>
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
Cc: blablack@gmail.com, Grant Diffey <gdiffey@gmail.com>, clemens@ladisch.de, alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

2012/4/13 Takashi Iwai <tiwai@suse.de>:
> At Fri, 13 Apr 2012 09:32:17 +0200,
> Felix Homann wrote:
>> If there aren't any objections to the "everything-muted-by-default"
>> approach, I will prepare a patch this weekend.
>
> It's basically good -- excpet for that it may let people see as a
> regression sometimes. =A0Let's check first whether "alsactl init" or
> whatever distro initialization works properly with the muted USB-audio
> device.

actually it's a bug so it should be fixed.

Having the volumes up after startup is a symptom of wrong value
ranges! Somewhere(*) in the device initialization something(*) tries
to set all volumes to 0. But the FTUs min value is 0x0080. The device
reacts by pulling the volumes up.

I'll prepare a patch (adding volume_control_quirks) over the weekend.

BTW, every single user of the FTUs in Linux will have some kind of
script since the device is unusable without. I don't think that
someone will see it as a regression given that the user base is quite
small and well informed for these devices.

Regards,

Felix

(*) I really could not find where this happens. I observed this
behaviour in usbmon logs.
