From: "Giovanni Maruzzelli" <gmaruzz.lists@gmail.com>
Subject: Re: dsnoop do not works on snd-hda-intel
Date: Mon, 17 Sep 2007 07:53:39 +0200
Message-ID: <7c5010d60709162253p6f44794ew11488e7f52114e7a@mail.gmail.com>
References: <7c5010d60709162221v13d9d4e8w9b481f36cdfe7851@mail.gmail.com>
	<200709170732.46430.maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 7DFD4103839
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Sep 2007 07:53:40 +0200 (CEST)
Received: by mu-out-0910.google.com with SMTP id w8so2074848mue
	for <alsa-devel@alsa-project.org>; Sun, 16 Sep 2007 22:53:39 -0700 (PDT)
In-Reply-To: <200709170732.46430.maximlevitsky@gmail.com>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Maxim,

many many many thanks!

Works perfectly, exactly as you wrote!
(to put the default to -1 is a feature? ;-) )

Many many thanks again,

Giovanni

On 9/17/07, Maxim Levitsky <maximlevitsky@gmail.com> wrote:
> On Monday 17 September 2007 07:21:03 Giovanni Maruzzelli wrote:
> > Hi all,
> >
> > I hope someone can give me an hint on this problem, that is stopping me.
> >
> > On my new laptop (asus f5v) dsnoop do not works, neither I can record
> > at the same moment with more than one application. The second
> > application that want to use the dsnoop, fail to open it.
> >
> > I'm using Ubuntu 7.04 fully updated.
> >
> > lspci gives:
> > 00:0f.0 Audio device: Silicon Integrated Systems [SiS] Azalia Audio Controller
> >
> > cat /proc/asound/card0/codec#* | grep Codec gives:
> > Codec: Realtek ALC660-VD
> > Codec: Motorola Si3054
> >
> > I've upgraded driver, lib, and utils to 1.0.14 but it do not helped.
> >
> > I've put at the end of /etc/modprobe.d/alsa-base
> > options snd-hda-intel model=3stack-660
> >
> > I can always reproduce the behavior, for eg:
> >
> > root@ubuntu-lap:~# arecord -Ddefault ciao.wav &
> > [1] 6923
> > root@ubuntu-lap:~# Recording WAVE 'ciao.wav' : Unsigned 8 bit, Rate
> > 8000 Hz, Mono
> >
> > root@ubuntu-lap:~# arecord -Ddefault ciao2.wav &
> > [2] 6926
> > root@ubuntu-lap:~# ALSA lib pcm_dsnoop.c:606:(snd_pcm_dsnoop_open)
> > unable to open slave
> > arecord: main:545: audio open error: Invalid argument
> >
> > [2]+  Exit 1                  arecord -Ddefault ciao2.wav
> >
> > I can give any additional info is needed.
> >
> > Thank you all in advance,
> >
> > Giovanni Maruzzelli
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
>
> Hi,
>
> I was also hit by this problem
>
> To fix this you need to open /usr/share/alsa/pcm/dsnoop.conf
> and change
>
>         @args.SUBDEV {
>                 type string
>                 default -1
>
> to
>
>         @args.SUBDEV {
>                 type string
>                 default 0
>
> I was told that this is a feature of alsa, not bug, I don't know.
>
> the above will make dsnoop to record from hw:0,0
>
> Also, I bet that your hardware can record more that one stream a time.
> So you can also try recording from hw:0,1 or hw:0,2
>
> you can check how many streams can be recording at same time in /proc/asound/Intel/pcm0c/info
> look at subdevices_count
>
> Each stream can have its own input source, so check your mixer to make sure that
> each stream records what you want, eg: records from same source, or not,
> is enabled or not, and has enough gain.
>
> Best regards,
>         Maxim Levisky
>
>
