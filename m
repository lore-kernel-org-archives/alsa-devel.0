From: Nazo <nazosan@gmail.com>
Subject: Re: [Alsa-user] Problem with several Creative Labs soundcards, possibly more?
Date: Sat, 22 Oct 2005 20:43:43 -0500
Message-ID: <a5a496a90510221843l359116c0n7770d60710257016@mail.gmail.com>
References: <a5a496a90510190840v7f7d2345s133b06eaad0a4719@mail.gmail.com>
	 <a5a496a90510191414n651099e8x9d9952638ce84729@mail.gmail.com>
	 <4356C875.5030607@superbug.co.uk>
	 <a5a496a90510191845w55200b77y927dc92470b15784@mail.gmail.com>
	 <a5a496a90510211519y15711764ode0a2fe4053695d8@mail.gmail.com>
	 <1129939134.4724.26.camel@mindpipe>
	 <a5a496a90510211958s1252b5fds1e91c699c3bfe7dc@mail.gmail.com>
	 <1130012992.7717.16.camel@mindpipe>
	 <a5a496a90510221800l18eda48dqa9d3d966ccf9276a@mail.gmail.com>
	 <Pine.LNX.4.61.0510221803140.3551@info.physics.ubc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0510221803140.3551@info.physics.ubc.ca>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Bill Unruh <unruh@physics.ubc.ca>
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

linux 3 fails on the Mandriva installer.  It says that it does not
have a normal init and goes into a kernel panic.  Also, I meant it
when I said that it is the installer which gets stuck.  X starts up,
runs smoothly, the installation begins, I configure language,
partitions, etc, and, every single time, it gets stuck at the point
where it's checking packages (I can't say for sure if this is before
or after it finishes, only that all drive access stops and it stays
there for as long as I can wait.)  I do not get as far as selecting
what packages to install, so, at this stage, nothing has actually been
written to my harddrive.  I also still have the original unmodified
kernel that Mandriva defaulted to and it's default initrd on my boot
partition, so if it installed the files, I could still boot into it
sucessfully using that.  Anyway, when it sticks, bear in mind that the
mouse can still move, so the system is not frozen and X is still at
least acting somewhat properly.  Unfortunately, they block out things
such as CTRL+ALT+F1 (probably doesn't even support multiple consoles)
and CTRL+ALT+BACKSPACE.  I think X isn't to blame here.  I'm pretty
sure something gets stuck in the installer itself.  Thing is, the disc
appears to be fully readable, so I'm just not sure what could have
happened.  I don't think I changed anything on any of the partitions
it's supposd to NOT be accessing, and the partition I'm trying to
install to is blank and verified to be undamaged (by three different
tools I might add.)  At this point, I just give up on getting that to
work.

Kubuntu and FC4's installer both ignore me hitting things like
CTRL+ALT+BACKSPACE and CTRL+ALT+F1.  Again, X itself seems to be ok I
suspect.  At the point they get stuck, I would tend to say that if
they use a window manager, it is that which is having troubles.

Can any of these diagnostics be done in GeeXBoX, or have we pretty
well hit the limit of what can be done with it's meagre debugging
abilities?

On 10/22/05, Bill Unruh <unruh@physics.ubc.ca> wrote:
> On Sat, 22 Oct 2005, Nazo wrote:
>
> > That said, Revell, I tried pci=3Drouteirq on GeeXBoX and it made no
> > obvious changes.  It occurs to me that maybe the two systems actually
> > have seperate problems that just happen to have nearly the same
> > effect.  Unfortunately, my attempts to install Mandriva all fail
> > horribly.  It gets stuck every single time.  I've had a similar issue
>
> It sounds like not that the Mandrake installation gets stuck but that reb=
ooting
> afterwards gets stuck.
>
> When you see the boot prompt asking which of the kernels to boot, press e=
sc
> and then type
> linux 3
>
> This will bring you up in console, not X mode. Now you can log in, and ru=
n
> startx 2>/tmp/X
> If it still gets stuck, do alt-ctrl-F1 and hit ctrl-C to stop the X tryin=
g
> to come up.
> Look in the file /tmp/X and see if there is something which gives you a
> clue as to where the problem is.
>
>
> > with Fedora Core 4.  Kubuntu gets stuck after starting X.  In each of
> > these cases, the system is not frozen (I can move the mouse) but
> > nothing ever comes up and I'm unable to do anything.  At this point,
>
> alt-ctrl-bksp to kill off X or alt-ctrl-F2 to get a console to log in on
> and try to figure out what the problem is.
>
>
> > all I have left for diagnosing this problem is GeeXBoX.  (And yes, my
>
> Whatever thatis
>
> > system is 100% stable.  Prime95 stable.)  Other than the filesystem
> > being damaged (and I've tried completely reformatting it, and, even
> > changed the partition table so that it's no longer even in the same
> > place, then reformatted again) I really can't think of a single thing
> > that changed between the first installation and this most recent
> > attempt.  I don't know if I can continue to diagnose this issue with
> > just GeeXBoX, but, right now it's all that's left.
> >
> > One thing that is important to note about the issue in GeeXBoX is the
> > fact that when I try to change the volume control, it doesn't work.
> > It defaults to zero, and when I try to raise it, nothing happens.  It
> > stays at zero.  I forgot this because most of the versions I get no
> > sound on show the volume changing, but, I still get no sound even if I
> > raise it to 100%.
> >
> >
> > On 10/22/05, Lee Revell <rlrevell@joe-job.com> wrote:
> >> On Fri, 2005-10-21 at 21:58 -0500, Nazo wrote:
> >>> If I boot with pci=3Dnoacpi, the normal mandriva kernel hangs just af=
ter
> >>> it says hit I for interactive setup.
> >>
> >> OK, try "pci=3Drouteirq".
> >>
> >> Lee
> >>
> >>
> >
> >
> > -------------------------------------------------------
> > This SF.Net email is sponsored by the JBoss Inc.
> > Get Certified Today * Register for a JBoss Training Course
> > Free Certification Exam for All Training Attendees Through End of 2005
> > Visit http://www.jboss.com/services/certification for more information
> > _______________________________________________
> > Alsa-user mailing list
> > Alsa-user@lists.sourceforge.net
>


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
