From: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>
Subject: Re: Fast Track Ultra mixer - opinions anyone?
Date: Mon, 16 Apr 2012 12:06:23 +0100
Message-ID: <CAE-xCyO1hrewRg8mV8VsfHA+oNG1mLzCRRmocFgo4A+RNAMVzQ@mail.gmail.com>
References: <CAFz=ag4SmifT2jVE-NqcWXg_+go_WYD06c9ZM0HtC1KHKg7k6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C734104094
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Apr 2012 13:06:24 +0200 (CEST)
Received: by vcbf11 with SMTP id f11so3486707vcb.38
	for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2012 04:06:23 -0700 (PDT)
In-Reply-To: <CAFz=ag4SmifT2jVE-NqcWXg_+go_WYD06c9ZM0HtC1KHKg7k6Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felix Homann <linuxaudio@showlabor.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Grant Diffey <gdiffey@gmail.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

> ** Effects **
>
> Essentially, with the attached patch you can control everything but
> the effect program. The switch should not be too hard to implement.
> But before I put any more work on it I would like to ask wether it
> makes sense at all.
>
> IMO, the effect section on the FTUs really sucks. I can't believe that
> anybody can really use it in a reasonable way. So should we really add
> another 40 controls to the mixer which can cause a lot of pain when
> misadjusted (i.e. anything else but 0)?
>
> For those reasons I would prefer not to put effect support in the
> kernel. What do you think?

What if they are activated somehow, and a user would loke to turn them off?

You're completely right, the effects on this soundcard are useless,
but let say they have been turn on in a Windows session, would the FTU
turn them back off at reboot, or would they still be on?

> ** Naming scheme again **
>
> Once again, is everyone pleased with the current naming scheme?
>

The naming scheme is indeed very confusing, but what other solution is
there? I used the FTU mixer under Windows and it is as confusing :)
I'm not sure the problem is with the naming convention though, but
more what the Alsa mixers look like... Gamix used to be perfect for
the FTU with all the controls in a grid, it was very clear how the
levels were setup... Unfortunately it's not maintained anymore, even
in Ubuntu...


So that's my 2 cents...

Aur=E9lien
