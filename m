From: Raymond <rayau@netvigator.com>
Subject: au88x0 PCM Volume control
Date: Tue, 06 Sep 2005 16:00:15 +0800
Message-ID: <431D4C8F.9010909@netvigator.com>
References: <4315C4BC.7040206@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4315C4BC.7040206@netvigator.com>
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
Cc: Manuel Jander <manuel.jander@gmail.com>, openvortex-dev@nongnu.org
List-Id: alsa-devel@alsa-project.org

The proposed PCM Volume controls of the playback device 0 of au88x0 
driver allow any ALSA application using the PCM Volume control 
(.iface=SNDRV_CTL_ELEM_IFACE_PCM) associated to the sudevice to change 
the volume (-48dB to 6dB) when the audio passing through the hardware 
mixer of au88x0.


Mono
                             0dB
DMA -> FIFO -> SRC -> MIXIN ---> MIXOUT -> Equalizer -> Front Left
                         |   0dB
                         +------> MIXOUT -> Equalizer -> Front Right
                         |   6dB
                         +------> MIXOUT --------------> Rear Left
                         |   6dB
                         +------> MIXOUT --------------> Rear Right

Stereo

                             0dB
DMA -> FIFO -> SRC -> MIXIN ---> MIXOUT -> Equalizer -> Front Left
             |           |   6dB
             |           +------> MIXOUT --------------> Rear Left
             |               0dB
             +> SRC -> MIXIN ---> MIXOUT -> Equalizer -> Front Right
                         |   6dB
                         +------> MIXOUT --------------> Rear Right

Surround40

                             0dB
DMA -> FIFO -> SRC -> MIXIN ---> MIXOUT -> Equalizer -> Front Left
             |               0dB
             +> SRC -> MIXIN ---> MIXOUT -> Equalizer -> Front Right
             |               6dB
             +> SRC -> MIXIN ---> MIXOUT --------------> Rear Left
             |               6dB
             +> SRC -> MIXIN ---> MIXOUT --------------> Rear Right

> 
> Description of the patch (beta)
> - add PCM Volume control by using the hardware mixer of au88x0
> 
> 
> TEST AT YOUR OWN RISK !!!
> 
> The audio will be distorted when total gain exceed the limit of 18-bits
> DAC in AC97 codec.
> 
> 
> Any comment/suggestion or programs to test the feature are welcome.
> 
> 
>> Hi,
> 
> 
>> On Mon, 2005-08-29 at 10:28 +0800, Raymond wrote:

>> > Distortion occur when the combined gain of audio data, hardware
>> > mixer ,  equalizer and 3D effect > 6dB ( limit by the 18-bits DAC i
>> > n AC97 codec)
> 
> 
>> The maximum gain possible for a entire audio pipe should obvisouly not
>> exceeded.
> 

Why the hardware mixer in the current ALSA driver is set to zero gain in 
vortex_adb_allocroute() when capturing audio from 18-bits ADC to 16-bits 
audio ? ( In theory, it should be -6dB )


                                               AC97
16bits Audio                 0dB        18bits   Analog
DMA <- FIFO <- SRC <- MIXOUT <- MIXIN <- ADC  <- MIXER <---- MIC
                                        |           |
DMA <- FIFO <- SRC <- MIXOUT <- MIXIN <+           +---------LINE IN
                                                    |
                                                    +---------VIDEO
                                                    |
                                                    +---------CD
                                                    |
                                                    +---------AUX
                                                    |
                                                    +---------PHONE
                                                    |
                                                    +---------MIX


> 
>> > In the ALSA au88x0 driver, the hardware mixer provide default gain
>> > of  6dB ( 16-bits auido data to 18-bits DAC in AC97 codec ) for the
>> > left/right channels of au8820 and the rear channels of au8810/au8830
>> > (to  SDAC of quad codec),
>>  >
>> > For the front channels of au8810/au8830, zero gain in hardware mixer
>> > and  this 6dB gain is most likely controlled by the equalizer or 3D
>> > effect.
>> >
> 
>> I would suggest using the correct signed or unsigned type instead of
>> doing explicit type conversions.
> 


static void
vortex_mix_setinputvolumebyte(vortex_t * vortex, unsigned char mix,
			      int mixin, unsigned char vol)
{
	int temp;

	hwwrite(vortex->mmio,
		VORTEX_MIX_INVOL_A + (((mix << 5) + mixin) << 2), vol);
	if (1) {		/* this_10, initialized to 1. */
		temp =
		    hwread(vortex->mmio,
			   VORTEX_MIX_INVOL_B + (((mix << 5) + mixin) << 2));
		if ((temp != 0x80) || (vol == 0x80))
			return;
	}
	hwwrite(vortex->mmio,
		VORTEX_MIX_INVOL_B + (((mix << 5) + mixin) << 2), vol);
}


static int snd_vortex_adb_pcm_change_vol(vortex_t *vortex,int mixin,int
mix,int volume)
{
	if ( volume >= 128 )
		vortex_mix_setinputvolumebyte(vortex, mix, mixin, volume-128);
   // GAIN
	else
		if ( volume < 64 )
			vortex_mix_setinputvolumebyte(vortex, mix, mixin, 0x80);        // MUTE
		else
			vortex_mix_setinputvolumebyte(vortex, mix, mixin, volume+128);  // ATTEN
	return 0;
}










-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
