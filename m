From: Lee Revell <rlrevell@joe-job.com>
Subject: low latency/multichannel design for emu10k1
Date: Thu, 08 Jul 2004 20:29:13 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1089332952.16556.10.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hey,

I am working on adding a low latency/multichannel device to the emu10k1
driver, with the goal of providing functionality equivalent to kX ASIO
on Windows (see http://kxproject.lugosoft.com/qguide.php?language=en).  
Here is my design so far.

The FXIO device has 16 channels, corresponding to the first 16 FXBus channels,
though the routing can be changed.  Channel 1 routes to FXBus 1 (plus 3/7
others, which we will ignore for now).

DSP code connects FXBus channels 1-16 to last 16 (of 64 outputs).  This
requires one MACINTS instruction per channel.  An LD10K1 patch could
be used, or this could simply be hardcoded in the driver.

The capture side of the device works exactly like the current FXBus capture
device, hw:x,2 (with Peter Zubaj's patch to enable multichannel recording).  
This would be set to capture the last 16 output channels, which receive input
from the first 16 FX buses as described above.  EFX_BUFFER(HALF)FULL
interrupts are disabled.  Whatever work is currently done in the EFX capture
interrupt handler moves to the voice interrupt handler.

This requires another extra voice, epcm->extra_fxio.  All 16 channels use this
same extra voice to generate the period interrupts.  This means that all users
of this device must use the same period size, which can be set via /proc.

When an application opens FXIO channel 8 for playback, a one channel PCM is
created, one voice is allocated and routed to FXBus 8.  This requires adding
a new member, EMU10K1_FXIO, to the existing types _PCM, _SYNTH, and _MIDI in
emu10k1_voice_type_t, and adding an 'fxio' member to the snd_emu10k1_voice
struct.  Rather than allocating an extra voice per PCM to generate the period
interrupts, like the current driver does, the extra voice is preallocated, 
a linked list of FXIO substreams is maintained, and the new PCM is inserted 
into this list.  When the voice interrupt for the extra FXIO voice occurs, we 
walk the linked list of FXIO PCMs, and do whatever work needs to be done for 
each.  Also in the voice interrupt handler, if voice->fxio is set, we do 
whatever work is done in the current FX capture interrupt handler.

I am fairly certain the above design will work, without extensive changes to the
driver.  Now, some questions:

I am confused about the exact relationship between devices, substreams, and
channels here.  How would I create a device with 16 channels such that a process
can only open channel 8 or channel 15, or all 16?  Multiple processes should be
allowed to open the same channel (until we run out of voices), as the driver
would just allocate another voice with the same FX send routing.  Ideally 
it would look like 16 mono devices.

Also, I think that I should use the snd_pcm_group_* functions for maintaining the
list of FXIO substreams.  Currently this is used in the drivers that support
SNDRV_PCM_INFO_SYNC_START.  In Takashi's driver guide, it mentions that there is an
example of this later, but it does not appear to be present.  Can someone recommend
an example of a driver that uses this?  I believe the above design would support
SNDRV_PCM_INFO_SYNC_START, as the same interrupt is used for playback and capture,
correct?

Thanks,

Lee




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
