From: Frank van de Pol <fvdpol@home.nl>
Subject: Re: Sequencer port type flags
Date: Thu, 8 May 2003 19:51:39 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030508175130.GA9743@obelix.fvdpol.dyndns.org>
References: <200305080142.10772.plcl@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200305080142.10772.plcl@telefonica.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, rosegarden-devel <rosegarden-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


On Thu, May 08, 2003 at 01:42:10AM +0200, Pedro Lopez-Cabanillas wrote:
....
> #define SNDRV_SEQ_PORT_TYPE_SYNTH       (1<<10) /* Synth device */
> #define SNDRV_SEQ_PORT_TYPE_APPLICATION (1<<20) /* application (sequencer/editor) */
..... 
> I've checked some software synths that also are ALSA sequencer clients:
> 
> timidity -iA (2.12.0-pre1) reports SND_SEQ_PORT_TYPE_MIDI_GENERIC
> RTSynth (1.9.1) reports SND_SEQ_PORT_TYPE_MIDI_GENERIC
> LegaSynth (0.4.1) reports SND_SEQ_PORT_TYPE_MIDI_GENERIC
> iiwusynth (0.2.5) reports SND_SEQ_PORT_TYPE_APPLICATION
> FluidSynth (1.0.1) reports SND_SEQ_PORT_TYPE_APPLICATION
> amSynth (1.0-rc2) reports SND_SEQ_PORT_TYPE_APPLICATION
> AlsaModularSynth (1.4.12) reports SND_SEQ_PORT_TYPE_APPLICATION
> miniFMSynth, from the ALSA 0.9.0 programming howto, reports 
> SND_SEQ_PORT_TYPE_APPLICATION
> ZynAddSubFX (1.2) reports SND_SEQ_PORT_TYPE_SYNTH
> 
> My question is, shouldn't the soft-synth programs set the 
> SND_SEQ_PORT_TYPE_SYNTH flag?
> What should be the right policy for userspace programs and kernel modules?
> Which set of flags should each program type set?
> 

Hi Pedro,

you are perfectly right, the soft-synth programs should indeed set the
SND_SEQ_PORT_TYPE_SYNTH flag, and possibly the others (GM/XG etc.) if they
support that standard.

The port type is supposed to help applications/users in setting up
connections (eg provide sensible defaults). 

To the clients it does not matter if another clients resides in userland or
kernel space; in fact in the future a part or whole of the alsa sequencer
might transparantly move into userspace.

Regards,
Frank.

-- 
+---- --- -- -  -   -    - 
| Frank van de Pol                  -o)    A-L-S-A
| FvdPol@home.nl                    /\\  Sounds good!
| http://www.alsa-project.org      _\_v
| Linux - Why use Windows if we have doors available?


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
