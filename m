From: Rui Sousa <rui.sousa@laposte.net>
Subject: Re: Midi reverb on Emu10k1
Date: Thu, 27 Jun 2002 01:32:39 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0206270123300.2133-100000@localhost.localdomain>
References: <Pine.LNX.4.33.0206261923510.795-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0206261923510.795-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Nicola Orru' <no@energit.it>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 26 Jun 2002, Jaroslav Kysela wrote:

> On Wed, 26 Jun 2002, Takashi Iwai wrote:
> 
> > Hi,
> > 
> > At Mon, 24 Jun 2002 20:38:00 +0200,
> > Nicola Orru' wrote:
> qq> > 
> > > Hello, people out there!
> > > 
> > > I'm Yet-Another-Programmer-Keyboard player.
> > > I would like to work on MIDI chorus/reverb implementations on the emu10k1 driver in a way 
> > > I can experience as much fun as original Creative driver provide on Windogs.
> > > 
> > > Where should I start from? How much work is needed to complete the sub-project?
> > > Where can I find documentation about that?
> >  
> > this is one of long standing todo's.
> > 
> > the implementation needs to steps.
> > 
> > 1. write a dsp loader program to communicate with the alsa-drivers via
> >    emu10k1's hwdep ioctls.
> > 
> >    there is already an assembler, which was ported from oss driver's
> >    program.  but it's never tested, i think.
> 
> Well, the assembler probably needs more modifications, because my idea of 
> DSP code management and linking is different from the OSS guys.
> 
> > 2. adds a code to assign the dsp codes to certain midi controls in
> >    emu10k1 driver.
> > 
> > once the first one is ready, then it wouldn't take long time to do the
> > 2nd step.  i have already some idea about the latter.
> > 
> > 
> > > Currently, I am trying to learn more about DSP architectures and 
> > > digital filter programming on several online books, but, 
> > > as I have little patience, I would like to "beat the metal" as
> > > soon as possible.
> > > 
> > > Any hints, pointers to TFM, will be sooo happily accepted.
> > 
> > the oss emu10k1 driver has already good examples for dsp codes on sb
> > live.  but the interface is different between alsa and oss drivers, so
> > you cannot use them straightforwardly.
> > the oss emu10k1 archive also includes some documents about dsp codes
> > on emu10k1.
> > 
> > the problem is, as written above, the implementation of loader.
> > how to manage static and dynamic routings, and so on.
> 
> Exactly. OSS code does this management partly in the kernel. In my
> opinion, we should leave in kernel only necessary things, so the
> linker/loader/code manager should be written completely in the user space.
> 

This is basically what we have (the "OSS guys" ;). The information that is
kept in the kernel is not meant to do any managing but instead it 
allows the patch loader/manager (implemented in user space) to 
retrieve the current DSP code state (which patches are loaded, which 
inputs connect to which outputs, ....). This is very difficult 
(impossible, maybe) to deduce by simply retrieving the DSP code.

Rui Sousa



-------------------------------------------------------
This sf.net email is sponsored by: Jabber Inc.
Don't miss the IM event of the season | Special offer for OSDN members! 
JabberConf 2002, Aug. 20-22, Keystone, CO http://www.jabberconf.com/osdn
