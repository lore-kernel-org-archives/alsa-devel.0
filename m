From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Tue, 31 Aug 2004 10:09:47 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0408310943540.1762@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0408181538550.24798-100000@studcom.urz.uni-halle.de>
 <1092842830.13603.3.camel@localhost.localdomain> <20040818181350.2b38e875@mango.fruits.de>
 <Pine.LNX.4.58.0408181918160.1769@pnote.perex-int.cz>
 <20040818201535.1f49a128@mango.fruits.de> <Pine.LNX.4.58.0408191050220.1779@pnote.perex-int.cz>
 <s5h8ycbv4s9.wl@alsa2.suse.de> <Pine.LNX.4.58.0408191225170.1779@pnote.perex-int.cz>
 <4129D6A2.7020801@pg.gda.pl> <s5hoel1hny9.wl@alsa2.suse.de> <4130D8BF.8030502@pg.gda.pl>
 <Pine.LNX.4.58.0408291135330.1778@pnote.perex-int.cz> <41322209.70900@pg.gda.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3D3DC266
	for <alsa-devel@alsa-project.org>; Tue, 31 Aug 2004 10:20:58 +0200 (MEST)
In-Reply-To: <41322209.70900@pg.gda.pl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?ISO-8859-2?Q?Adam_Tla=B3ka?= <atlka@pg.gda.pl>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 29 Aug 2004, Adam Tla=B3ka wrote:

> Because of latency issues and need for direct access to hardware it's
> sometimes better to have this functions in kernel - if card can mix in
> hardware N streams use that feature for N streams but if you need N+1
> then you must do it in software. If again streams count lowers to N you
> should return to hardware mixing. I can't see this is possible with
> current ALSA dmix plugin.

It can be implemented also in the user space. If open() of raw hw:X,Y=20
device fails, then dmix can be used. We can eventually use a threshold
to leave some voices for wavetable etc.

> >>No mixer calls on dsp stream,
> > Huh, that's new for me. It does not work? It's implemented.
> Maybe with kernel emulation, but not in aoss.

OK, it's right. Please, make a bugreport.

> >>no multichannel streams (4...7.1) are possible with OSS emulation,
> > Additional information which is moved to alsa-lib is required. Anyway,
> > actually almost all new applications requiring this feature support ALS=
A.
> OK, but OSS compability is not full.

Yes, I fixed README which was very old.

> >>DMA mode broken. I just can't abandon using OSS because of that :-(.
> > Could you specify which is broken with the kernel ALSA's OSS mmap=20
> > emulation?
>
> I am not using kernel module. I am using patched aoss lib and dmix
> plugin. I think that we should carefully read OSS pdf doc and look at
> the OSS emulation code to find which is not compatible with documented
> original OSS behaviour. As I can tell there is one thing according to
> DMA mode - buffer size and number of periods. In original OSS for
> example GETOSPACE call reports these values and after that call or any
> of GETxPTR, GETxDELAY, read or write operation these values are fixed.
> So if an app read buffer size and num of periods first and then sets
> stream parameters (format, stereo, rate) buffer size and num of periods
> are not changed - in original OSS. If we changing parameters using ALSA
> lib buffer size and num of periods could change so if we now have
> different OSS values some apps just broke. OK - this app behaviour is
> not quite correct - it should set stream parameters first and ask about
> buffer size after that. But this is an original OSS documented behaviour
> so it should be supported.

Yes, some test utilities will be fine.

> > Note that the direct device access is the major problem with the OSS AP=
I.

> I don't think so. You don't need to link an app with any additional
> libraries and these device open, read, write, select, poll and ioctl are
> just normal Unix filesystem calls. We only should have kernel module
> which could redirect data stream and control to user space (maybe RT)
> daemon which does the rest.

I meant that the library had to be used from the initial stage of the OSS=
=20
API design like we have alsa-lib. Yes, now is too late at least for static=
=20
linked applications.

> program -> OSS dev -> redirector module -> special RT daemon -> alsa lib=
=20
> -> card

I would replace redirector module with network or direct loopback=20
driver module. In this case ALSA applications can benefit as well.

> > If a library which hide the direct syscalls exists, we never had such=
=20
> > problems to redirect OSS calls to our code. The library can be very=20
> > small.
> But we have some closed source proprietary apps which should work too.

Yes, bad initial API design.

> > I feel that it's mainly about fixing bugs. Unfortunately, most of users
> > (including you) point me to quake binaries. I cannot run them on my
> > machines.
> Hmm, I am frequently testing aoss with quake.x11 (quake1) binary which=20
> is plain X11
> app - no OpenGL. I don't now how is accesible quake2 in your country
> but I just bought cheap CD with full version in some multimedia store.
> quake1 and quake2 program sources are accesible on the net.

If we have the sources, could you extract the audio code and prepare a=20
short test command line code? It would be very useful for debugging.

=09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
