From: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Subject: Sequencer port type flags
Date: Thu, 8 May 2003 01:42:10 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200305080142.10772.plcl@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: rosegarden-devel <rosegarden-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi all,

There are some flags defined in alsa-kernel/include/asequencer.h to describe 
sequencer ports.

/* port type */
#define SNDRV_SEQ_PORT_TYPE_SPECIFIC    (1<<0)  /* hardware specific */
#define SNDRV_SEQ_PORT_TYPE_MIDI_GENERIC (1<<1) /* generic MIDI device */
#define SNDRV_SEQ_PORT_TYPE_MIDI_GM     (1<<2)  /* General MIDI compatible 
device */
#define SNDRV_SEQ_PORT_TYPE_MIDI_GS     (1<<3)  /* GS compatible device */
#define SNDRV_SEQ_PORT_TYPE_MIDI_XG     (1<<4)  /* XG compatible device */
#define SNDRV_SEQ_PORT_TYPE_MIDI_MT32   (1<<5)  /* MT-32 compatible device */

/* other standards...*/
#define SNDRV_SEQ_PORT_TYPE_SYNTH       (1<<10) /* Synth device */
#define SNDRV_SEQ_PORT_TYPE_DIRECT_SAMPLE (1<<11)       /* Sampling device 
(support sample download) */
#define SNDRV_SEQ_PORT_TYPE_SAMPLE      (1<<12) /* Sampling device (sample can 
be downloaded at any time) */
/*...*/
#define SNDRV_SEQ_PORT_TYPE_APPLICATION (1<<20) /* application 
(sequencer/editor) */

I've checked recently some synth drivers included in ALSA: trident, gus and 
opl3 are sequencer clients and they set the flag SNDRV_SEQ_PORT_TYPE_SYNTH 
among others.

The emu synth driver sets several flags but not SNDRV_SEQ_PORT_TYPE_SYNTH. 
Shouldn't it set also this flag? 
See alsa-kernel/synth/emux/emux_seq.c:55

I don't understand why some synth drivers set the flags GM/GS/XG/MT32.

OTOH, the flags for userspace programs using ALSA library are explained here 
(snd_seq_create_port)
http://www.alsa-project.org/alsa-doc/alsa-lib/group___seq_port.html#a27

I've checked some software synths that also are ALSA sequencer clients:

timidity -iA (2.12.0-pre1) reports SND_SEQ_PORT_TYPE_MIDI_GENERIC
RTSynth (1.9.1) reports SND_SEQ_PORT_TYPE_MIDI_GENERIC
LegaSynth (0.4.1) reports SND_SEQ_PORT_TYPE_MIDI_GENERIC
iiwusynth (0.2.5) reports SND_SEQ_PORT_TYPE_APPLICATION
FluidSynth (1.0.1) reports SND_SEQ_PORT_TYPE_APPLICATION
amSynth (1.0-rc2) reports SND_SEQ_PORT_TYPE_APPLICATION
AlsaModularSynth (1.4.12) reports SND_SEQ_PORT_TYPE_APPLICATION
miniFMSynth, from the ALSA 0.9.0 programming howto, reports 
SND_SEQ_PORT_TYPE_APPLICATION
ZynAddSubFX (1.2) reports SND_SEQ_PORT_TYPE_SYNTH

My question is, shouldn't the soft-synth programs set the 
SND_SEQ_PORT_TYPE_SYNTH flag?
What should be the right policy for userspace programs and kernel modules?
Which set of flags should each program type set?

Thanks in advance.

Regards,
Pedro

-- 
ALSA Library Bindings for Pascal
http://alsapas.alturl.com



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
