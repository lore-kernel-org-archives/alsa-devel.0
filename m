From: "Stanislas Elie" <stanelie@stanelie.com>
Subject: Fwd:  mips problem
Date: Tue, 5 Sep 2006 14:30:53 -0400
Message-ID: <4a2338020609051130q386c5512p34f93ea77a7fd199@mail.gmail.com>
References: <4a2338020609050954h2c1d55cet3ba8027ef85dbb5f@mail.gmail.com>
	<s5h1wqqxmcg.wl%tiwai@suse.de>
	<4a2338020609051024g38a060a3rd9d12530c2c8522a@mail.gmail.com>
	<s5hy7syw78y.wl%tiwai@suse.de>
	<4a2338020609051109u4fb17363k7004b7df6a18a87e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <4a2338020609051109u4fb17363k7004b7df6a18a87e@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I was using version 1.0.11rc4, I havn't had much success building more
recent drivers, some things I can only cross-compile, some things I
can only compile natively.

And I've had to use this patch (
https://dev.openwrt.org/attachment/ticket/486/alsa-lib.tar.bz2 ) to
bypass the use of wordexp.h, which is not in the uclibc configuration.

Has anyone been able to make the whole ALSA package work on a mips platform?

Stanislas


On 9/5/06, Takashi Iwai <tiwai@xxxxx> wrote:
> At Tue, 5 Sep 2006 13:24:29 -0400,
> Stanislas Elie wrote:
> >
> > How can I track this down?
>
> Don't ask me, it's your system :)
>
> At least, this string doesn't appear in the latest ALSA tree.
> You should write what ALSA version you're using.
>
>
> Takashi
>
> > On 9/5/06, Takashi Iwai <tiwai@xxxx> wrote:
> > > At Tue, 5 Sep 2006 12:54:04 -0400,
> > > Stanislas Elie wrote:
> > > >
> > > > Hello.
> > > >
> > > > I am trying to transform a netgear wgt634u wireless router into a
> > > > wireless midi node.
> > > >
> > > > For this to work, I need alsa with sequencer option enabled.
> > > >
> > > > I managed to compile the driver, library and utils on my platform.
> > > >
> > > > However, when I do an aconnect, I get this error message :
> > > >
> > > > root@OpenWrt:/# aconnect
> > > > WARNING: this snd_user_file implementation won't behave as expected.
> > > >          set BROKEN_USERFILE_DEBUG to see all problems, or
> > > >          set BROKEN_USERFILE_SILENT to disable all warnings.
> > >
> > > I don't know who outputs this message...
> > >
> > >
> > > Takashi
> > >
> > > > ALSA lib seq.c:929:(snd_seq_open_noupdate) Unknown SEQ default
> > > > can't open sequencer
> > > > root@OpenWrt:/#
> > > >
> > > > Any hints about resolving this issue?
> > > >
> > > > Thanks!
> > > >
> > > > Stanislas Elie
> > > >
> > > > -------------------------------------------------------------------------
> > > > Using Tomcat but need to do more? Need to support web services, security?
> > > > Get stuff done quickly with pre-integrated technology to make your job easier
> > > > Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> > > > http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> > > > _______________________________________________
> > > > Alsa-devel mailing list
> > > > Alsa-devel@lists.sourceforge.net
> > > > https://lists.sourceforge.net/lists/listinfo/alsa-devel
> > > >
> > >
> >
>

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
