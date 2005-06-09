From: Raymond <rayau@netvigator.com>
Subject: Re: [Openvortex-dev] Re: Re: [ALSA - driver 0001138]:   errors when
 installing au8820 modules
Date: Thu, 09 Jun 2005 16:13:42 +0800
Message-ID: <42A7FA36.8020609@netvigator.com>
References: <add360993204c8039097fe7085524651@bugtrack.alsa-project.org>	<200506071917.42953.alien999999999@users.sourceforge.net>	<42A5DB84.2030407@mail.ru>	<200506072002.49600.alien999999999@users.sourceforge.net>	<s5hacm1kv7f.wl@alsa2.suse.de> <42A6D936.8040101@netvigator.com> <s5h3brtkplx.wl@alsa2.suse.de> <42A7352A.2070502@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42A7352A.2070502@mail.ru>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: openvortex-dev@nongnu.org
List-Id: alsa-devel@alsa-project.org

Igor Kovalenko wrote:
> Takashi Iwai wrote:
> 
>>Raymond wrote:
>>
>>
>>>typedef struct {
>>>	unsigned int *this00;	/*CAsp4HwIO */
>>>	long this04;		/* How many filters for each side (default = 10) */
>>>	long this08;		/* inited to cero. Stereo flag? */
>>>} eqhw_t;
>>>
>>>static void vortex_EqHw_SetLevels(vortex_t * vortex, u16 peaks[])
>>>{
>>>	eqhw_t *eqhw = &(vortex->eq.this04);
>>>	int i;
>>>
>>>	/* set left peaks */
>>>	for (i = 0; i < eqhw->this04; i++) {
>>>		hwwrite(vortex->mmio, 0x2b024 + i * VORTEX_BAND_COEFF_SIZE, peaks[i]);
>>>	}
>>>
>>>	hwwrite(vortex->mmio, 0x2b3cc, peaks[eqhw->this04]);
>>>	hwwrite(vortex->mmio, 0x2b3d8, peaks[eqhw->this04 + 1]);
>>>
>>>	/* set right peaks */
>>>	for (i = 0; i < eqhw->this04; i++) {
>>>		hwwrite(vortex->mmio, 0x2b204 + i * VORTEX_BAND_COEFF_SIZE,
>>>			peaks[i + (eqhw->this04 + 2)]);
>>>	}
>>>
>>>	hwwrite(vortex->mmio, 0x2b3e4, peaks[2 + (eqhw->this04 * 2)]);
>>>	hwwrite(vortex->mmio, 0x2b3f0, peaks[3 + (eqhw->this04 * 2)]);
>>>}
>>>
>>>
>>>	vortex_EqHw_SetLevels(vortex, (u16 *) eq_levels);
>>>
>>>
>>>
>>>
>>>What is the reason to increase the size of the array eq_levels from 32 
>>>to 64 ?  ( eqhw->this04 seem to be 10 )
>>
>>
>>I guess he wants to keep the total array size just to be sure.
>>But it seems not necessary.
> 
> 
> Exactly for that purpose. I do not know if other (au8810 or au8830) use more
> than au8820 in that array.
> 
> 


AFAIK au8820 do not has any Equalizer, only au8810 and au8830 have the
Equalizer.

Those Equalizer offsets 0x2b??? are out of the 128K MMIO of au8820.

Most of the changes related to Equalizer are seem to be WRONG.

Please ask the alsa-team to add your Diamond Sonic Impact S90 (au8820)
to the soundmatrix

http://www.alsa-project.org/alsa-doc/index.php?vendor=vendor-Diamond_Multimedia#matrix


au8820 do not support SPDIF too.

Is  IEC-60958 RCA Output equal to Coaxial SPDIF ?
Is  IEC-60958 TOSLINK Output equal to Optical SPDIF ?
Is  MIDIio both equal to MPU401 ?


#include "au8820.h"
#include "au88x0.h"
static struct pci_device_id snd_vortex_ids[] = {
         {PCI_VENDOR_ID_AUREAL, PCI_DEVICE_ID_AUREAL_VORTEX_1,
          PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0,},
         {0,}
};

#include "au88x0_synth.c"
#include "au88x0_core.c"
#include "au88x0_pcm.c"
#include "au88x0_mpu401.c"
#include "au88x0_game.c"
#include "au88x0_mixer.c"
#include "au88x0.c"


Do anyone know why amixer display 10-bands EQ stereo controls as mono 
controls ( snd_mixer_selem_has_capture_channel(elem, 
SND_MIXER_SCHN_MONO) = 1 ) ?


amixer

Simple mixer control 'Master',0
   Capabilities: pvolume pswitch pswitch-joined
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 31
pmono = 0, cmono = 0 (0, 0, 0, 0)
   Front Left: Playback 22 [71%] [on]
   Front Right: Playback 22 [71%] [on]


Simple mixer control 'EQ0 31Hz',0
   Capabilities: volume
   Playback channels: Front Left - Front Right
   Limits: 0 - 32767
pmono = 0, cmono = 1 (1, 0, 0, 0)
   Mono: 32767 [100%]
   Front Left:
   Front Right:
Simple mixer control 'EQ1 63Hz',0
   Capabilities: volume
   Playback channels: Front Left - Front Right
   Limits: 0 - 32767
pmono = 0, cmono = 1 (1, 0, 0, 0)
   Mono: 16022 [49%]
   Front Left:
   Front Right:
Simple mixer control 'EQ2 125Hz',0
   Capabilities: volume
   Playback channels: Front Left - Front Right
   Limits: 0 - 32767
pmono = 0, cmono = 1 (1, 0, 0, 0)
   Mono: 16022 [49%]
   Front Left:
   Front Right:
Simple mixer control 'EQ3 250Hz',0
   Capabilities: volume
   Playback channels: Front Left - Front Right
   Limits: 0 - 32767
pmono = 0, cmono = 1 (1, 0, 0, 0)
   Mono: 16022 [49%]
   Front Left:
   Front Right:
Simple mixer control 'EQ4 500Hz',0
   Capabilities: volume
   Playback channels: Front Left - Front Right
   Limits: 0 - 32767
pmono = 0, cmono = 1 (1, 0, 0, 0)
   Mono: 16022 [49%]
   Front Left:
   Front Right:
Simple mixer control 'EQ5 1KHz',0
   Capabilities: volume
   Playback channels: Front Left - Front Right
   Limits: 0 - 32767
pmono = 0, cmono = 1 (1, 0, 0, 0)
   Mono: 16022 [49%]
   Front Left:
   Front Right:
Simple mixer control 'EQ6 2KHz',0
   Capabilities: volume
   Playback channels: Front Left - Front Right
   Limits: 0 - 32767
pmono = 0, cmono = 1 (1, 0, 0, 0)
   Mono: 16022 [49%]
   Front Left:
   Front Right:
Simple mixer control 'EQ7 4KHz',0
   Capabilities: volume
   Playback channels: Front Left - Front Right
   Limits: 0 - 32767
pmono = 0, cmono = 1 (1, 0, 0, 0)
   Mono: 16022 [49%]
   Front Left:
   Front Right:
Simple mixer control 'EQ8 8KHz',0
   Capabilities: volume
   Playback channels: Front Left - Front Right
   Limits: 0 - 32767
pmono = 0, cmono = 1 (1, 0, 0, 0)
   Mono: 16022 [49%]
   Front Left:
   Front Right:
Simple mixer control 'EQ9 16KHz',0
   Capabilities: volume
   Playback channels: Front Left - Front Right
   Limits: 0 - 32767
pmono = 0, cmono = 1 (1, 0, 0, 0)
   Mono: 16022 [49%]
   Front Left:
   Front Right:



amixer contents

numid=16,iface=MIXER,name='Master Playback Volume'
   ; type=INTEGER,access=rw---,values=2,min=0,max=31,step=0
   : values=22,22

numid=2,iface=MIXER,name='EQ0 31Hz'
   ; type=INTEGER,access=rw---,values=2,min=0,max=32767,step=0
   : values=32767,16022
numid=3,iface=MIXER,name='EQ1 63Hz'
   ; type=INTEGER,access=rw---,values=2,min=0,max=32767,step=0
   : values=16022,16022
numid=4,iface=MIXER,name='EQ2 125Hz'
   ; type=INTEGER,access=rw---,values=2,min=0,max=32767,step=0
   : values=16022,16022
numid=5,iface=MIXER,name='EQ3 250Hz'
   ; type=INTEGER,access=rw---,values=2,min=0,max=32767,step=0
   : values=16022,16022
numid=6,iface=MIXER,name='EQ4 500Hz'
   ; type=INTEGER,access=rw---,values=2,min=0,max=32767,step=0
   : values=16022,16022
numid=7,iface=MIXER,name='EQ5 1KHz'
   ; type=INTEGER,access=rw---,values=2,min=0,max=32767,step=0
   : values=16022,16022
numid=8,iface=MIXER,name='EQ6 2KHz'
   ; type=INTEGER,access=rw---,values=2,min=0,max=32767,step=0
   : values=16022,16022
numid=9,iface=MIXER,name='EQ7 4KHz'
   ; type=INTEGER,access=rw---,values=2,min=0,max=32767,step=0
   : values=16022,16022
numid=10,iface=MIXER,name='EQ8 8KHz'
   ; type=INTEGER,access=rw---,values=2,min=0,max=32767,step=0
   : values=16022,16022
numid=11,iface=MIXER,name='EQ9 16KHz'
   ; type=INTEGER,access=rw---,values=2,min=0,max=32767,step=0
   : values=16022,32767






-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
