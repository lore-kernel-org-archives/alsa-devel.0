From: Laszlo Papp <lpapp@kde.org>
Subject: Re: Internal Speaker problem
Date: Fri, 14 Apr 2017 16:46:34 +0100
Message-ID: <CAOMwXhPyGOHhKWJB7QkGKkzhUUYqyKLme137kjymfY+QNaOeuQ@mail.gmail.com>
References: <CAOMwXhMS0ibwR=3FZO1N0gw2usUFctwXni6XTBgiRJcPCvx+Xw@mail.gmail.com>
 <s5hlgr3zbb6.wl-tiwai@suse.de>
 <CAOMwXhPs7yx7frp9LnJnteriN8OepBSzazDt8xy1wEp0w=YZ4Q@mail.gmail.com>
 <s5hfuhbz3xa.wl-tiwai@suse.de>
 <CAOMwXhPRsXnCGzVvnKmOi-zNqw+V3N522JZYUDaCP7iX7mfBaA@mail.gmail.com>
 <s5ha87jyxer.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f194.google.com (mail-io0-f194.google.com
 [209.85.223.194])
 by alsa0.perex.cz (Postfix) with ESMTP id EE92526696B
 for <alsa-devel@alsa-project.org>; Fri, 14 Apr 2017 17:46:36 +0200 (CEST)
Received: by mail-io0-f194.google.com with SMTP id x86so19146181ioe.3
 for <alsa-devel@alsa-project.org>; Fri, 14 Apr 2017 08:46:36 -0700 (PDT)
In-Reply-To: <s5ha87jyxer.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, arun@arunraghavan.net
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 14, 2017 at 1:41 PM, Takashi Iwai <tiwai@suse.de> wrote:

> On Fri, 14 Apr 2017 12:27:37 +0200,
> Laszlo Papp wrote:
> >
> > On Fri, Apr 14, 2017 at 11:20 AM, Takashi Iwai <tiwai@suse.de> wrote:
> >
> > > On Fri, 14 Apr 2017 12:13:32 +0200,
> > > Laszlo Papp wrote:
> > > >
> > > > On Fri, Apr 14, 2017 at 8:40 AM, Takashi Iwai <tiwai@suse.de> wrote:
> > > >
> > > > > On Fri, 14 Apr 2017 08:44:46 +0200,
> > > > > Laszlo Papp wrote:
> > > > > >
> > > > > > Guys, seriously, no one willing to help with a completely broken
> > > setup?!
> > > > > >
> > > > > > It works fine on Windows, so I would really like to get it
> working on
> > > > > > Linux, too.
> > > > >
> > > > > Well, if it used to work, it's basically a regression, and at best,
> > > > > try to downgrade kernel or whatever to identify at which point it
> > > > > started regression.  It'd be a great help alone to analyze what
> went
> > > > > wrong.
> > > > >
> > > >
> > > >
> > > > I do not think this is a regression. I have just double checked this
> > > with a
> > > > live USB using Ubuntu 16.04 LTS. The same problem happens. The sound
> goes
> > > > off within a couple of seconds.
> > > >
> > > > sudo hda-verb /dev/snd/hwC0D0 0x1f SET_POWER_STATE 0
> > > >
> > > > would bring the node back for less a minute, but that is also not
> > > > acceptable.
> > > >
> > > > So, basically, I would like it to work the same way it does on
> Windows if
> > > > possible. Windows does not switch it off. It could be because they
> > > utilise
> > > > the internal chip better and for other reasons, etc. At the end of
> the
> > > day,
> > > > I would be even happier to persistently tell the node to stay up, no
> > > matter
> > > > what. It may damage the internal speaker, but it is still better
> that I
> > > can
> > > > use it for a while than I cannot use it for any amount of time at
> all.
> > > So,
> > > > is there a way to achieve that bruteforce approach?
> > > >
> > > > The nicer solution would surely be to figure out why Windows can cope
> > > with
> > > > the same hardware. I do not think Windows would break the hardware.
> > >
> > > Check whether power_save is set or not in snd-hda-intel option, see
> > > /sys/module/snd_hda_intel/parameters/power_save.  If disabling the
> > > power-save prevents the issue happening, the cause is the power-save
> > > feature.
> > >
> > > If the problem still happens even if you disable the power-save mode
> > > in the driver, it's possibly a hardware-specific problem.  Some Lenovo
> > > laptops have a known firmware issues that turn off the codec power.
> > > I'm not sure whether it's the case.
> > >
> >
> > cat /sys/module/snd_hda_intel/parameters/power_save
> > 0
> >
> > Back to my previous question: is there a way to permanently tell the node
> > to remain up? As mentioned, some use before the hardware breaks is better
> > than no use. I will not switch to Windows by any means as I really like
> > Linux much better. I would rather buy a new laptop than switching to
> > Windows. But before doing that, I would like to see what can be worked
> out
> > with the current setup.
>
> As I mentioned, it's possibly the BIOS firmware who does it, no the
> Linux kernel driver.  You can watch the driver behavior via tracepoint
> outputs (see Documentation/sound/hd-audio/notes.rtf).  If it shows the
> widget power down, it's the driver issue.  If it still happens even
> though the kernel doesn't touch, it's a hardware firmware problem.
>

I am not sure whether I have done what you requested, so please let me know
whether this is sufficien information to you:

root /home/lpapp # echo 1 > /sys/kernel/debug/tracing/events/hda/enable
(start mplayer)
root /home/lpapp # cat /sys/kernel/debug/tracing/trace > trace.log
root /home/lpapp # wgetpaste trace.log
Your paste can be seen here:
https://paste.pound-python.org/show/5BBURUwPuYu5SYEpTpa5/
root /home/lpapp #

But please let me ask you one question: if it is a BIOS problem, it should
have happened from day one, or not necessarily? Also, why does the BIOS not
kick in when using Windows?


>
> Takashi
>
> > Yes, I agree with you that something has triggered this issue over time.
> > However, all I can say is that Windows has no such problems if I boot my
> > laptop up with Windows 7. The OS can play sounds without any problems.
> So,
> > I am not yet convinced whether we are in a position to blame the hardware
> > at this point. I would love to see some evidence if that is the case
> >
> > It is needless to say, but I am happy to send any further outputs
> > requested, etc.
> >
> > Thank you for your help so far.
> >
> >
> > >
> > >
> > > Takashi
> > >
> > > >
> > > > Ys, L.
> > > >
> > > >
> > > > > Takashi
> > > > >
> > > > > >
> > > > > > On Mon, Mar 27, 2017 at 8:29 AM, Laszlo Papp <lpapp@kde.org>
> wrote:
> > > > > >
> > > > > > > I am sorry about flooding with my emails. I just thought that I
> > > would
> > > > > > > amend some information that I forgot to mention in my original
> > > email.
> > > > > > >
> > > > > > > The same laptop and internal speaker work ok on Windows 10.
> Also,
> > > the
> > > > > > > setup used to work about 1-2 months ago. I cannot remember what
> > > exactly
> > > > > > > broke, perhaps a system upgrade. If it matters, I am using
> > > Archlinux.
> > > > > > >
> > > > > > > On Mon, Mar 27, 2017 at 8:27 AM, Laszlo Papp <lpapp@kde.org>
> > > wrote:
> > > > > > >
> > > > > > >> Dear Alsa Developers,
> > > > > > >>
> > > > > > >> My internal speaker in the Lenovo Thinkpad T510 laptop stopped
> > > > > working.
> > > > > > >> Normally, it would provide either no sound or just for a
> couple of
> > > > > seconds
> > > > > > >> and then it would go off.
> > > > > > >>
> > > > > > >> I do not have auto-mute enabled. I checked it with alsamixer
> that
> > > it
> > > > > is
> > > > > > >> disabled.
> > > > > > >>
> > > > > > >> My ALSA information is located at
> http://www.alsa-project.org/db
> > > > > > >> /?f=87547de5ff55e44e360aa2382d4e5d3b7bbed091
> > > > > > >>
> > > > > > >> Do you know how I could fix this?
> > > > > > >>
> > > > > > >> Ys, L.
> > > > > > >>
> > > > > > >>
> > > > > > >
> > > > > > _______________________________________________
> > > > > > Alsa-devel mailing list
> > > > > > Alsa-devel@alsa-project.org
> > > > > > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > > > > >
> > > > >
> > >
>
