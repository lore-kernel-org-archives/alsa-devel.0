From: Ivan Middleton <ivan_middleton@yahoo.com>
Subject: Re: problems with external MIDI port
Date: Thu, 19 Sep 2002 20:14:00 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020920031400.53365.qmail@web13406.mail.yahoo.com>
References: <s5hy99you7x.wl@alsa2.suse.de>
Reply-To: ivan_middleton@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hy99you7x.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--- Takashi Iwai <tiwai@suse.de> wrote:
> Hi,
> 
> At Wed, 18 Sep 2002 14:10:19 -0700 (PDT),
> Ivan Middleton wrote:
> > 
> > Hi all,
> > 
> > I'm having a problem with the ALSA sequencer.  First I was using
> > 0.9.0rc2, and then I switched to cvs, hoping that things would be
> fixed
> > there.  But alas, the problems occur in both.  I was going to try
> the
> > 0.5 release, but it didn't want to compile for me.
> > 
> > The problem is as follows: I am running a program (called Linux
> Pipe
> > Organ) which reads from the external MIDI port (64:0) via an ALSA
> > sequencer connection, and which also starts a TiMidity process and
> > sends events to it via ALSA sequencer connections.  (Basically, the
> > program is just relaying MIDI events, after some modifications.) 
> This
> > works fine for a few minutes, and then suddenly... nothing.  The
> ALSA
> > sequencer stops relaying events from the external MIDI port.  Now,
> my
> > digital piano is connected to the MIDI port, and it sends something
> > like 30 MIDI events per second (I don't know exactly what these
> are)
> > even when no keys are being pressed.  The problem I just described
> > occurs even if I never press any keys on the piano; I can tell by
> > watching /proc/asound/seq/clients, looking at the following lines
> > 
> > Client 132 : "Linux Organ" [User]
> >   Port   0 : "Linux Organ" (rWe-)
> >     Connected From: 64:0
> >   Input pool :
> >     Pool size          : 200
> >     Cells in use       : 0
> >     Peak cells in use  : 30
> >     Alloc success      : 27513
> >     Alloc failures     : 0
> > 
> > and noticing that after a while the "Alloc success" number stops
> > changing (when everything is working it goes up by about 30 every
> > second).
> 
> this could be due to the timer routine.
> could you check /proc/asound/seq/queue and /proc/asound/seq/timer
> whether the timer and queue are still running correctly in such a
> situation?

am I doing something wrong?  I don't see anything in either
/proc/asound/seq/queue or /proc/asound/seq/timer, no matter what.

Ivan


__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
