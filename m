From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: ALSA 1.1.8 Release - POLLRDNORM undefined
Date: Fri, 11 Jan 2019 09:39:42 +0900
Message-ID: <20190111003942.GA19697@workstation>
References: <34543a6f-8123-10e5-ea79-338b82a22818@systech.com>
 <s5htviixf0t.wl-tiwai@suse.de>
 <1e297542-0023-0a92-7407-076ee547b5d9@systech.com>
 <s5hftu1h8qg.wl-tiwai@suse.de> <s5hef9lh8ne.wl-tiwai@suse.de>
 <24afbadf-7c52-1f1c-6fcd-45a1bf8a6657@systech.com>
 <20190110042402.GA7696@workstation>
 <905a26fc-073f-e223-2107-729652ac0c5f@perex.cz>
 <9d5e2de4-46d4-e0fc-9a2e-50925244811d@systech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CA6D2267546
 for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2019 01:39:54 +0100 (CET)
Received: by mail-pl1-f193.google.com with SMTP id t13so5924321ply.13
 for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2019 16:39:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <9d5e2de4-46d4-e0fc-9a2e-50925244811d@systech.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jay Foster <jay@systech.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 10, 2019 at 08:44:34AM -0800, Jay Foster wrote:
> On 1/10/2019 12:31 AM, Jaroslav Kysela wrote:
> > Dne 10.1.2019 v 05:24 Takashi Sakamoto napsal(a):
> > > Hi,
> > > =

> > > I'm an author of axfer.
> > > =

> > > On Tue, 08 Jan 2019 18:00:18 +0100, Jay Foster wrote:
> > > > I am attempting to build the 1.1.8 release of alsa-utils and getting
> > > > an error about POLLRDNORM (and others) undefined.=A0 This error com=
es
> > > > from axfer/waiter-select.c.=A0 axfer/waiter-select.c includes
> > > > "waiter.h", which includes "poll.h".=A0 This build is for a linux
> > > > target.
> > > > On Wed, 09 Jan 2019 17:22:36 +0100, Jay Foster wrote:
> > > > > On 1/9/2019 3:10 AM, Takashi Iwai wrote:
> > > > > > Which libc are you using?  The POSIX man page (man poll.h) ment=
ions
> > > > > > POLLRDNORM defined there, at least, on my system with glibc 2.2=
7.
> > > > > This is a legacy ARM product using glibc 2.9.
> > > I'm sorry for the FTBFS but it's out of my notice to build with too-o=
ld glibc.
> > > =

> > > Here, a history of glibc for related events:
> > > * glibc-2.9: 2008/11/13
> > >    * your version
> > > * glibc-2.10: 2009/5/9
> > >    * support XPG7/POSIX-2008
> > >    * add '__USE_XOPEN2k8' for the avove
> > > * glibc-2.19: 2014/2/7
> > >    * add '_DEFAULT_SOURCE' macro
> > >    * XPG7/POSIX-2008 is a default behaviour
> > > * glibc-2.20: 2014/9/7
> > >    * obsolete '_BSD_SOURCE' and '_SYSV_SOURCE' macros
> > > * glibc-2.28: 2018/8/1
> > >    * used my environment (Ubuntu 18.10)
> > > =

> > > The macros, POLLRDNORM and the others, seems to be defined officially=
 in
> > > POSIX-2008 and nowadays glibc supports POSIX-2008 as a default. This =
is
> > > the reason that I've never faced your issue in my development period.
> > > I guess it's the reason that nothing noted in man of poll(2) and
> > > select(2).
> > > =

> > > I need a bit time to judge whether it's woth to support such old-glib=
c.
> > > Just removal of the newly-introduced macros is a simple solution.
> > We may add those definitions to CFLAGS (-D) through configure for the
> > old libs. Or just used #ifdef in the waiter-select.c - it's only one
> > place which uses this at this moment, but it's only quick workaround.
> > =

> I can resolve the issue by adding -D_GNU_SOURCE to my CFLAGS when building
> alsa-utils.=A0 It would also be acceptable (to me) if you did nothing abo=
ut
> this.
> =

> If you wish to check the version of glibc for support of POLLRDNORM throu=
gh
> configure and add -D_GNU_SOURCE for older versions, that may work too.=A0=
 I
> can report that-D_GNU_SOURCE is not needed with glibc 2.22.=A0 I am not s=
ure
> precisely which version the POLLRDNORM (and friends) were enabled by
> default.=A0 I can imagine a configure test that compiled a test app which
> tries to use POLLRDNORM, and if it compiles successfully, then nothing el=
se
> is needed.=A0 If not, try again with -D_GNU_SOURCE, and if that works, add
> -D_GNU_SOURCE to the CFLAGS.=A0 Such a test might also be conditional on
> selecting waiter-select (the only place this is used).

I filed this issue:
https://github.com/alsa-project/alsa-utils/issues/9


Regards

Takashi Sakamoto
