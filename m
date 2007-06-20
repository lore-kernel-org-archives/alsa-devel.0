From: "Paul Kavan" <pkavan@gmail.com>
Subject: Re: Using aplay and arecord on an ARM
Date: Wed, 20 Jun 2007 11:12:21 -0500
Message-ID: <61c0054e0706200912m1779bef8gfab9da178bd888b4@mail.gmail.com>
References: <61c0054e0706191237n666fd422wcf13f874f108e64a@mail.gmail.com>
	<s5hzm2vaqs7.wl%tiwai@suse.de>
	<8d6898730706200354vf5195e1u95c0484a89fe472a@mail.gmail.com>
	<61c0054e0706200727s1648cde3y578ae0c230ad1616@mail.gmail.com>
	<8d6898730706200732u60eed3b3l52a141d7e7a151c4@mail.gmail.com>
	<61c0054e0706200739k2b934a9avbffb133937adba4c@mail.gmail.com>
	<61c0054e0706200824v444d6c8dr6b6023b16043fa7@mail.gmail.com>
	<61c0054e0706200827h389e2c6v46dfc544def95e82@mail.gmail.com>
	<61c0054e0706200840k2b0f13c9q57581c380d39d2fc@mail.gmail.com>
	<s5hwsxyaa5r.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 4FEBA24340
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jun 2007 18:12:22 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id o2so376499uge
	for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2007 09:12:21 -0700 (PDT)
In-Reply-To: <s5hwsxyaa5r.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Nobin Mathew <nobin.mathew@gmail.com>
List-Id: alsa-devel@alsa-project.org

>
> --with-alsa-inc-prefix=$HOME/Linux_Builds/buildroot/build_arm/root/usr/include
>
>         --with-alsa-prefix=$HOME/Linux_Builds/buildroot/build_arm/root/usr/lib
>
>
> Takashi
>


Takashi:

Thank you. That got me a little further. Now, I am hitting this error:

...
checking for libasound headers version >= 1.0.12... found.
checking for snd_ctl_open in -lasound... yes
checking how to run the C preprocessor... arm-linux-gcc -E
checking for grep that handles long lines and -e... /bin/grep
checking for egrep... /bin/grep -E
checking for ANSI C header files... yes
checking for initscr in -lncurses... no
checking for initscr in -lcurses... no
configure: error: this packages requires a curses library

...which I could swear I have....will look into this.

Paul
-- 
***************************************
Paul David Kavan
Project Engineer
GRH Electronics, Inc.
402-734-4900
pkavan@gmail.com
***************************************
