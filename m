From: Miro Hodak <mhodak127@gmail.com>
Subject: Re: HD-audio regression after commit
	34588709af61be1550b4e2bcee5c85d0ac4f34d4
Date: Fri, 18 Jan 2013 03:14:19 -0500
Message-ID: <CA+S_cwoKMERXHR14t4WK0Him=bjcRQQPJH+tX6BHyeBUv9tntg@mail.gmail.com>
References: <CA+S_cwraM+wofw5Nz_d0ctOget5dY-0nr5pRHCzOJtLX+JM2TA@mail.gmail.com>
 <s5h8v7s2tja.wl%tiwai@suse.de>
 <CA+S_cwowFrLAWSRiQvPX5AZwuyo9DdA4qS7Xn3bMYy=AzzpHdg@mail.gmail.com>
 <s5hvcaw18qf.wl%tiwai@suse.de>
 <CA+S_cwq7mDPkjPCVpRecO93UW2gpYo7BpMfFARu0PZCvNT-w4A@mail.gmail.com>
 <s5hsj6017km.wl%tiwai@suse.de>
 <CA+S_cwo2mZn+5P3JuNWXZ+3taQcSHmvRhm95vjupY1o+FA+cpw@mail.gmail.com>
 <s5hobgo16ct.wl%tiwai@suse.de>
 <CA+S_cwqeP90pFpFviKns-bxxBS6ahunPgRfCG0BQTa5ZLPtE-Q@mail.gmail.com>
 <s5hlibs154t.wl%tiwai@suse.de>
 <CA+S_cwoLe=2tUr=EyFM0TxvbBaB12DCE2yDPwf3OzoRcO8jQug@mail.gmail.com>
 <CAN8cciama4q0EOiUsjp-KyyzehcvjwmdPdBQ9vsitbnR8g1PgA@mail.gmail.com>
 <CA+S_cwrmHguxk6WBxjAJTOaV8xV-4PH0gkpibFKs1P8bRxAsAg@mail.gmail.com>
 <s5hfw1zomf2.wl%tiwai@suse.de> <20130117191224.44794728@gmail.com>
 <s5hfw1z1s6a.wl%tiwai@suse.de> <20130117214043.5a1574ee@gmail.com>
 <s5h7gnb0y5z.wl%tiwai@suse.de>
 <CA+S_cwqE6AgcVjp+wtPuJA_AcJqUvL0Ocoq_QA5JVWQVYCsYSg@mail.gmail.com>
 <20130118090839.4a0725f8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ia0-f176.google.com (mail-ia0-f176.google.com
 [209.85.210.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 31F1B265D75
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2013 09:14:21 +0100 (CET)
Received: by mail-ia0-f176.google.com with SMTP id i18so1173082iac.21
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2013 00:14:20 -0800 (PST)
In-Reply-To: <20130118090839.4a0725f8@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Manolo_D=EDaz?= <diaz.manolo@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Raymond Yau <superquad.vortex2@gmail.com>, basinilya@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 18, 2013 at 3:08 AM, Manolo D=EDaz <diaz.manolo@gmail.com> wrot=
e:

>
> I can confirm Miro's results: auto-mute now does work. But, as Raymond
> says, Mic doesn't.
>
> branch: master
>
> commit 11ccc0c507c07cb3ac1e827a1eca0a2b8b708461
> Merge: d89012b 8a6c21a
> Author: Takashi Iwai <tiwai@suse.de>
> Date:   Fri Jan 18 07:58:34 2013 +0100
>
> Regards,
> --
> Manolo D=EDaz
>

It appears that the Mic is now labeled as a "Digital" capture device.
Increasing its volume (I had to at zero), I have a functional microphone.
