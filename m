From: "Ryan Cassidy" <rcassidy@stanford.edu>
Subject: RE: Interrupt-driven (or callback/handler?), Full-duplex (simultaneous capture/playback) without using JACK
Date: Mon, 29 Dec 2003 17:57:21 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000701c3ce78$43939a50$264440ab@roboserv1>
References: <Pine.LNX.4.53.0311090927040.3073@pnote.perex-int.cz>
Reply-To: <rcassidy@stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.53.0311090927040.3073@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: 'Jaroslav Kysela' <perex@suse.cz>
Cc: 'Paul Davis' <paul@linuxaudiosystems.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> On Sat, 8 Nov 2003, Ryan Cassidy wrote:
>=20
> > > Paul Davis wrote:
**************************************************
> > > the ALSA PCM API doesn't have "handlers". it doesn't provide any
kind
> > > of callback mechanism. what it does do is to provide a poll(2)
> > > interface, allowing callback-like mechanisms to be built around it
> > > (like JACK).
> > >

> > Ryan J. Cassidy replies:
*********************************************
> > Will snd_async_add_pcm_handler() not do the trick?  It says
> > "asynchronous," which doesn't sound like what I want, but the
"handler"
> > part sounds promising :).
> >
> > If that doesn't work, it's sort of a bummer that ALSA doesn't offer
a
> > callback-mechanism for simultaneous audio i/o, non?  This means that
to
> > get "what I want" (i.e. allowing my program to do useful work while
> > waiting for new audio samples), I need to use snd_pcm_wait() and
fork
> > off an extra process to do the "useful work," right?


> Jaroslav replies:
******************************************************=20
> Yes, snd_async_add_pcm_handler() might help you and it works. It's
> originated in the interrupt handler. But please note that the handler
is
> in the unix style signal callback thus there are many restrictions
(you
> should avoid to do most of syscalls in this code etc.).
>=20
> But for mmaped access and the standard ALSA transfer mechanism (use
only
> snd_pcm_avail_update() to get the right position) it is the fast way
to
> create an interrupt based handlers in the applications.
>=20
> For the synchronization: You must do it in your application. We work
with
> two diferrent streams and although the streams are hardware
synchronized,
> there might be some buffering issues (FIFOs) so the playback and
capture
> pointers do not match exactly. So the best way is to obtain the
current
> pointer using snd_pcm_avail_update() and compute how many frames you
can
> process for the duplex operation (I mean for both streams).

Just to be sure here: it is possible, then, to add a single PCM handler
(via snd_async_add_pcm_handler()) to a LINKED pair of streams (one for
playback, one for capture)?  Moreover, this handler will be called only
once each period/buffer-time to signal the need for BOTH capture and
playback frames (since the streams are linked)?

(Note to Paul: I realize that no system calls are allowed within the
handler, but I think I could work around this via message-passing to the
main application.  Perhaps this is na=EFve/incorrect?)

Since the streams are hardware synchronized, is there any way to disable
the FIFOs that Jaroslav mentions above?  Why are the FIFOs needed in the
first place?

Cheers, rjc.
--
Ryan J. Cassidy
Electrical Engineering Graduate Student, CCRMA Researcher
Stanford University
E-mail: ryanc@ieee.org



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
