From: Raymond <rayau@netvigator.com>
Subject: au8830 - AC3 pass through SPDIF
Date: Sat, 05 Mar 2005 23:13:44 +0800
Message-ID: <4229CCA8.10508@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: openvortex-dev@nongnu.org
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


>> > 1) What is the difference between Consumer mode and Professional mode ?
>> 
>> What do you mean ?
>> 
>> > 2) What change will be needed in order to support the SPDIF IN/OUT of 
>> > Turtle Beach Montego II Quadzilla ?
>> 
>> Reverse engineering :P SPDIF out should work. The required audio routes
>> are known. But we need to know which GPIO pins evetually must be set to
>> enable/operate external optical transceivers.
>> 

SPDIF IN/OUT and rear is only available on Montego II Home Studio and
Montego II Quadzilla has SPDIF OUT and rear only

http://www.watch.impress.co.jp/akiba/hotline/990821/newitem.html#12


 >>
 >> > 5) How can STAC9721 stereo codec provide quad audio ? ( Is it through
 >> > SPDIF-I2S link ? )
 >>
 >> That depends on the hardware. AFAIK, the STAC9721 supports only 2
 >> channels. If we want 4, then obviously, the other two must go through
 >> any other codec. It could be a secondary STAC9721, a I2S codec connected
 >> to the I2S interface, some other kind of codec/DSP connected to any of
 >> the 8 coprocessor I/O interfaces, SPDIF, or whatever interfaces there
 >> might be we don't even know about.
 >>

http://www.io.com/~kazushi/audiocard/montegoII/

Refer to the photo, there is only one ST9721T on Montego II,

1) Is LNLVL_OUT (pin 39,41) just a copy of LINE_OUT (pin 35,36) ?


>
> > 3) Is it correct to return the following value in
> > snd_vortex_spdif_mask_get() ?
> > ucontrol->value.iec958.status[3] = IEC958_AES3_CON_FS;
>
> Yes.

http://sourceforge.net/mailarchive/message.php?msg_id=7644755

Although CS8412 and CS8402a support consumer mode and professional,
there is no professional mode connector. May need to mask off the
IEC958_AES0_PROFESSIONAL.

2) Which of the following code is correct ?

static int snd_vortex_spdif_mask_get(snd_kcontrol_t * kcontrol,
snd_ctl_elem_value_t * ucontrol)
{
     ucontrol->value.iec958.status[0] = ~(IEC958_AES0_PROFESSIONAL);
     ucontrol->value.iec958.status[1] = 0xff;
     ucontrol->value.iec958.status[2] = 0xff;
     ucontrol->value.iec958.status[3] = IEC958_AES3_CON_FS;
     return 0;
}

or

static int snd_vortex_spdif_default_put(snd_kcontrol_t * kcontrol,
snd_ctl_elem_value_t * ucontrol)
{
      vortex_t *vortex = snd_kcontrol_chip(kcontrol);
     vortex->spdif_out.status[0]=ucontrol->value.iec958.status[0] &
~(IEC958_AES0_PROFESSIONAL);
     vortex->spdif_out.status[1]=ucontrol->value.iec958.status[1];
     vortex->spdif_out.status[2]=ucontrol->value.iec958.status[2];
     vortex->spdif_out.status[3]=ucontrol->value.iec958.status[3];
     switch(vortex->spdif_out.status[3] & IEC958_AES3_CON_FS){
     case IEC958_AES3_CON_FS_32000: vortex->spdif_sr = 32000; break;
     case IEC958_AES3_CON_FS_44100: vortex->spdif_sr = 44100; break;
     case IEC958_AES3_CON_FS_48000: vortex->spdif_sr = 48000; break;
     };
     vortex_program_spdif(vortex);
     return 0;
}


>> 
>> > 5) Can any au8810/au8830 owner verify that EN_CODEC1 should/should not 
>> > be used for those au8810/au8830 not using a quad codec ? (e.g Montego II 
>> > using STAC9721 stereo codec, SQ1500, Vortex Advantage, ASUS L8400B 
>> > notebook au8810 with modem)
>> > 
>> > #define VORTEX_CODEC_CTRL    0x29184
>> > #define VORTEX_CODEC_EN        0x29190
>> > #define        EN_CODEC0    0x00000300
>> > #define     EN_AC98        0x00000c00 /* Modem AC98 slots. */
>> > #define        EN_CODEC1    0x00003000
>> > #define        EN_CODEC    (EN_CODEC0 | EN_CODEC1)
>> 
>> The EN_CODEC1 flag, is there to enable the AC97 channels 4 and 5. AFAIK,
>> the bits in that register (VORTEX_CODEC_EN) map as follows:
>> 
>> 8,9: AC97 channels 0 and 1
>> 10,11: AC97 channels 2 and 3 (used as AC98 modem channels)
>> 12,13: AC97 channels 4 and 5 (rear/headphones channels)
>> 
>> For more details:
>> http://galadriel.mat.utfsm.cl/~mjander/aureal/techdoc/techpaper.html

This mean that EN_CODEC1 should only be enabled if au88x0 have a quad codec

>> 
>> > http://lists.gnu.org/archive/html/openvortex-dev/2003-11/msg00008.html
>> > 
>> > 3) Do we need to change the ADB routing when using AC3 passthrough ?
>> 
>> Hmm, good question. Maybe yes, because the current SPDIF PCM device
>> route does stereo deinterlacing (separating two stereo channels). The
>> SPDIF interface has 2 input sinks. For AC3 data, 2 interlaced channels
>> does not make ant sense, because it could be 4, 6 or more, encoded in
>> who knows what. Its just some raw data that must be passed through
>> intact. It may be that in AC3 passthrough mode the SPDIF transmitter
>> just re-joins the 2 data streams resulting in the original raw bit
>> stream, hopefuly not messing it up. Maybe someone with more SPDIF
>> knowledge can comment on this ?
>> 


http://galadriel.mat.utfsm.cl/~mjander/aureal/techdoc/routes.png


3) Do we need to remove the MIXOUT to SPDIFOUT routes or just mute
the corresponding MIXIN to MIXOUT (0x14) when using AC3 pass through SPDIF ?


>>
>> > There is already a parser to parse the sound font au30gm.arl in the
>> > vortex control panel.
>> > http://savannah.nongnu.org/support/?func=detailitem&item_id=103017
>>
>> > 6) What else will be needed for the au88x0 driver to support
>> >wavetable synthesis ?
>>
>> The main problem is, that the audio routes from the WT engine are broken
>> and thus the DMA engine does not seem transfer any data.


# more /proc/asound/card0/pcm3p/info
card: 0
device: 3
subdevice: 0
stream: PLAYBACK
id: AU88x0 WT
name: wt
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 64
subdevices_avail: 64


# aplay -D hw:0,3 test.wav
Playing WAVE 'test.wav' : Unsigned 8 bit, Rate 11025 Hz, Mono
aplay: set_params:857: Sample format non available


4) How can we use "aplay" to play test.wav on the card 0 device 3 ?

>> > >
>> > > > 5) What additional kcontrol and routine are needed for SPDIF IN ?
>> > >
>> 
>> AFAIK, there is no direct SPDIF input interface on the au8830 chip. It
>> looks like that the SPDIF input is implemented using a I2S port or one
>> of the coporecessor interfaces. Since they are all sincronous serial
>> interfaces, they probably are almost the same and almost compatible
>> between each other, requiring little tweaking/additional circuitry on
>> the interface daughter-board.

http://sourceforge.net/projects/aureal

Most likely SPORT interface.













-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
