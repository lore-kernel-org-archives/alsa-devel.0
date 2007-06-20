From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Using aplay and arecord on an ARM
Date: Wed, 20 Jun 2007 12:16:58 -0400
Message-ID: <75b66ecd0706200916i2105cb49xf40313e0440bc821@mail.gmail.com>
References: <61c0054e0706191237n666fd422wcf13f874f108e64a@mail.gmail.com>
	<8d6898730706200354vf5195e1u95c0484a89fe472a@mail.gmail.com>
	<61c0054e0706200727s1648cde3y578ae0c230ad1616@mail.gmail.com>
	<8d6898730706200732u60eed3b3l52a141d7e7a151c4@mail.gmail.com>
	<61c0054e0706200739k2b934a9avbffb133937adba4c@mail.gmail.com>
	<61c0054e0706200824v444d6c8dr6b6023b16043fa7@mail.gmail.com>
	<61c0054e0706200827h389e2c6v46dfc544def95e82@mail.gmail.com>
	<61c0054e0706200840k2b0f13c9q57581c380d39d2fc@mail.gmail.com>
	<s5hwsxyaa5r.wl%tiwai@suse.de>
	<61c0054e0706200912m1779bef8gfab9da178bd888b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 7010424340
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jun 2007 18:17:00 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so184506wag
	for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2007 09:16:59 -0700 (PDT)
In-Reply-To: <61c0054e0706200912m1779bef8gfab9da178bd888b4@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Kavan <pkavan@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Nobin Mathew <nobin.mathew@gmail.com>
List-Id: alsa-devel@alsa-project.org

FWIW, alsamixer is the only thing that needs curses, when I did an
embedded linux + ALSA project I just passed --disable-alsamixer to
work around it, and used amixer.

Lee

On 6/20/07, Paul Kavan <pkavan@gmail.com> wrote:
> >
> > --with-alsa-inc-prefix=$HOME/Linux_Builds/buildroot/build_arm/root/usr/include
> >
> >         --with-alsa-prefix=$HOME/Linux_Builds/buildroot/build_arm/root/usr/lib
> >
> >
> > Takashi
> >
>
>
> Takashi:
>
> Thank you. That got me a little further. Now, I am hitting this error:
>
> ...
> checking for libasound headers version >= 1.0.12... found.
> checking for snd_ctl_open in -lasound... yes
> checking how to run the C preprocessor... arm-linux-gcc -E
> checking for grep that handles long lines and -e... /bin/grep
> checking for egrep... /bin/grep -E
> checking for ANSI C header files... yes
> checking for initscr in -lncurses... no
> checking for initscr in -lcurses... no
> configure: error: this packages requires a curses library
>
> ...which I could swear I have....will look into this.
>
> Paul
> --
> ***************************************
> Paul David Kavan
> Project Engineer
> GRH Electronics, Inc.
> 402-734-4900
> pkavan@gmail.com
> ***************************************
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
