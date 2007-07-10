From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: dmix and sounds less than 64kb
Date: Tue, 10 Jul 2007 09:57:37 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0707100954280.7300@tm8103.perex-int.cz>
References: <61e8390b0707062028t63c913eeg1ab5a40f830af597@mail.gmail.com>
	<s5hir8tvrvt.wl%tiwai@suse.de>
	<61e8390b0707091240i657f82ev306ac851759c791f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E4D21038B9
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jul 2007 09:57:39 +0200 (CEST)
In-Reply-To: <61e8390b0707091240i657f82ev306ac851759c791f@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Aaron \"Caustik\" Robinson" <caustik@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 9 Jul 2007, Aaron "Caustik" Robinson wrote:

> We actually dumped the pcm data as it was arriving to the driver (via the
> trigger start and irq functions), and it was corrupted at that point. Also I
> have dumped the pcm data after it has been mixed by the dmix plugin, and it
> is fine there as well.

Which hardware and driver? It seems like a driver (wrong pointer 
management) or hardware issue. For example, ARM CPUs does not guarantee 
cache coherency between two virtual address spaces pointing to one 
physical space.

					Jaroslav

> On 7/9/07, Takashi Iwai <tiwai@suse.de> wrote:
> >
> > At Fri, 6 Jul 2007 20:28:13 -0700,
> > Aaron "Caustik" Robinson wrote:
> > >
> > > We have been having one heck of a time tracking down the cause of some
> > ALSA
> > > audio playback issues.
> > >
> > > It appears that any time we play a very short sound (<64kb), either the
> > > sound doesn't play at all, or only a fragment of it plays. We haven't
> > had
> > > much luck finding a solution to this issue, then I found this thread on
> > the
> > > history of this email group:
> > >
> > >
> > http://mailman.alsa-project.org/pipermail/alsa-devel/2007-April/000526.html
> > >
> > > Our problem is pretty much exactly like his issues relating to <64k
> > sounds.
> > >
> > > My question is - has anybody else run into this problem? To the OP of
> > the
> > > above thread, if you're still listening - did you ever find a solution
> > to
> > > your problem? I'd be very interested to hear any help you can provide.
> >
> > It works fine with my systems, so the problem should be pretty
> > driver-specific...

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
