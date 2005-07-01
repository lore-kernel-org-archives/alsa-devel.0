From: Raymond <rayau@netvigator.com>
Subject: Re: au88x0_synth
Date: Fri, 01 Jul 2005 21:42:35 +0800
Message-ID: <42C5484B.7040201@netvigator.com>
References: <423CCDAC.80401@netvigator.com> <s5h4qf44vna.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4qf44vna.wl@alsa2.suse.de>
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
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Sun, 20 Mar 2005 09:11:08 +0800,
> Raymond wrote:
> 
>>
>>>>Lee Revell wrote:
>>>>Looks like this chipset has a wavetable synth.  And I noticed some
>>>>references to a driver on the openvortex list.  Would it be possible 
>>>>for ALSA to support it?
>>
>>>Manuel Jander wrote:
>>> Of course, but there are some unresolved hardware issues. The
>>> WaveTable helper hardware is very similar to the trident
>>> Wavetable helper hardware. It does not interpret MIDI directly, but
>>> at least does some effect processing in hardware.
>>
>>
>>http://sourceforge.net/mailarchive/message.php?msg_id=6004190
>>
>>1) Is the Trident Wavetable working ?
> 
> 
> Very limited.  It's no proper "MIDI" wavetable implementation.
> IIRC, only a module player worked with trident driver.
> 
> 
> 

If WT code compiled as a separate module au88x0-synth , it cannot direct 
call those functions in au88x0 module (e.g vortex_mix_setvolumebyte() )

Also there are a lot of warning messages "static function declared 
static but never defined" in au88x0.h because WT code need to include 
au88x0.h to get the definition of vortex_t.

#define SNDRV_SEQ_DEV_ID_AU88X0_SYNTH CARD_NAME_SHORT "-synth"

	if (snd_seq_device_new(card, 1, SNDRV_SEQ_DEV_ID_AU88X0_SYNTH,
			       sizeof(snd_vortex_synth_arg_t), &wt) < 0
	    || wt == NULL) {
		printk(KERN_INFO "Can't initialize au88x0 wavetable synth\n");
	} else {
		snd_vortex_synth_arg_t *arg;
		arg = SNDRV_SEQ_DEVICE_ARGPTR(wt);
		sprintf(wt->name, "%s Synth",CARD_NAME_SHORT);
		arg->chip = chip;
		arg->index = 1;
	}


As WT is present on the au8820/au8830 chip and not on another chip of
the sound card. (WT registers can be accessed by using vortex->mmio )

Is there any alternative way for keeping the WT code within module
au88x0 instead of a seperate module au88x0-synth ?


	if ((err = snd_device_new(card, SNDRV_DEV_SEQUENCER, wt, &ops)) < 0) {
		return err;
	}














-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
