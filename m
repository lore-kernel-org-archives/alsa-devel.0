From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Re: Using aplay and arecord on an ARM
Date: Wed, 20 Jun 2007 20:02:14 +0530
Message-ID: <8d6898730706200732u60eed3b3l52a141d7e7a151c4@mail.gmail.com>
References: <61c0054e0706191237n666fd422wcf13f874f108e64a@mail.gmail.com>
	<75b66ecd0706191307m2a93ae4mdf9b1b6dd4ee425a@mail.gmail.com>
	<61c0054e0706191328y76f64570ne6a28108abafc2d5@mail.gmail.com>
	<75b66ecd0706191331y52ccc60dlc2634987c7309aba@mail.gmail.com>
	<s5hzm2vaqs7.wl%tiwai@suse.de>
	<8d6898730706200354vf5195e1u95c0484a89fe472a@mail.gmail.com>
	<61c0054e0706200727s1648cde3y578ae0c230ad1616@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7641C1037FA
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jun 2007 16:32:16 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so137227wag
	for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2007 07:32:15 -0700 (PDT)
In-Reply-To: <61c0054e0706200727s1648cde3y578ae0c230ad1616@mail.gmail.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Lee Revell <rlrevell@joe-job.com>
List-Id: alsa-devel@alsa-project.org

Yes, but take care of permissions. you need root permissions in ARM
root file system.

On 6/20/07, Paul Kavan <pkavan@gmail.com> wrote:
> On 6/20/07, Nobin Mathew <nobin.mathew@gmail.com> wrote:
>
> > Build alsa-lib and alsa-utils with prefix option
> >
> > --prefix=/usr
> >
> > while installing give the destination directory
> >
> > make install DESTDIR=$MYINSTALLDIR
> >
> > Then copy the installed executables to ARM root file sytem
> >
> > This should solve the issue.
> >
> > On 6/20/07, Takashi Iwai <tiwai@suse.de> wrote:
> > > At Tue, 19 Jun 2007 16:31:31 -0400,
> > > Lee Revell wrote:
> > > >
> > > > On 6/19/07, Paul Kavan < pkavan@gmail.com> wrote:
> > > > > it should not be looking in this directory, but rather in
> > > > > "usr/share/alsa/alsa.conf". Might be why it cannot find the
> alsa.conf
> > > >
> > > > I struggled with the exact same problem about a year ago, I don't
> > > > remember the solution but it's in the list archives.
> > >
> > > The problem is likely you pass --prefix=$MYROOT/usr or so.
> > > The prefix option should be unchanged.
> > >
> > > Anyway, alsa-lib-1.0.14a has extra configure options,
> > > --with-configdir and --with-plugindir, with which you can specify the
> > > exact paths, independent from $prefix.
> > >
> > >
> > > Takashi
>
> Thanks Takashi and  Mathew. I just want to make sure I am clear on this. I
> create my embedded rfs for an ARM9 processor on my host machine. The path to
> the rfs is:
>
> $HOME/buildroot/build_arm/root/...
>
> So, you are saying that when I configure alsa-libs, I should be using:
>
>  CC=arm-linux-gcc ./configure --target=arm-linux --with-versioned=no
> --prefix=/usr
>
> and then
>
> make install DESTDIR=$HOME/buildroot/build_arm/root
>
> Is this correct? I just want to make sure the libs will get into my target's
> rfs that way.
>
> Thanks.
>
> Paul
>
>
>
>
> --
> ***************************************
> Paul David Kavan
> Project Engineer
> GRH Electronics, Inc.
> 402-734-4900
> pkavan@gmail.com
> ***************************************
