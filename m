From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Sequencer port type flags
Date: Thu, 8 May 2003 22:00:35 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305082159360.1435-100000@pnote.perex-int.cz>
References: <20030508175130.GA9743@obelix.fvdpol.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030508175130.GA9743@obelix.fvdpol.dyndns.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Frank van de Pol <fvdpol@home.nl>
Cc: Pedro Lopez-Cabanillas <plcl@telefonica.net>, alsa-devel <alsa-devel@lists.sourceforge.net>, rosegarden-devel <rosegarden-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 8 May 2003, Frank van de Pol wrote:

> 
> On Thu, May 08, 2003 at 01:42:10AM +0200, Pedro Lopez-Cabanillas wrote:
> ....
> > #define SNDRV_SEQ_PORT_TYPE_SYNTH       (1<<10) /* Synth device */
> > #define SNDRV_SEQ_PORT_TYPE_APPLICATION (1<<20) /* application (sequencer/editor) */
> ..... 
> > I've checked some software synths that also are ALSA sequencer clients:
> > 
> > timidity -iA (2.12.0-pre1) reports SND_SEQ_PORT_TYPE_MIDI_GENERIC
> > RTSynth (1.9.1) reports SND_SEQ_PORT_TYPE_MIDI_GENERIC
> > LegaSynth (0.4.1) reports SND_SEQ_PORT_TYPE_MIDI_GENERIC
> > iiwusynth (0.2.5) reports SND_SEQ_PORT_TYPE_APPLICATION
> > FluidSynth (1.0.1) reports SND_SEQ_PORT_TYPE_APPLICATION
> > amSynth (1.0-rc2) reports SND_SEQ_PORT_TYPE_APPLICATION
> > AlsaModularSynth (1.4.12) reports SND_SEQ_PORT_TYPE_APPLICATION
> > miniFMSynth, from the ALSA 0.9.0 programming howto, reports 
> > SND_SEQ_PORT_TYPE_APPLICATION
> > ZynAddSubFX (1.2) reports SND_SEQ_PORT_TYPE_SYNTH
> > 
> > My question is, shouldn't the soft-synth programs set the 
> > SND_SEQ_PORT_TYPE_SYNTH flag?
> > What should be the right policy for userspace programs and kernel modules?
> > Which set of flags should each program type set?
> > 
> 
> Hi Pedro,
> 
> you are perfectly right, the soft-synth programs should indeed set the
> SND_SEQ_PORT_TYPE_SYNTH flag, and possibly the others (GM/XG etc.) if they
> support that standard.

Note that the SYNTH ports should support SNDRV_SEQ_EVENT_SAMPLE* events. 
It means direct wavetable synthesis not MIDI event communication.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
