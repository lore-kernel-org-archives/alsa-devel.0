From: Raymond <rayau@netvigator.com>
Subject: aplay - How to use device 3 of card 0 ?
Date: Sun, 06 Mar 2005 13:22:01 +0800
Message-ID: <422A9379.5030809@netvigator.com>
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
To: alsa-devel@lists.sourceforge.net
Cc: openvortex-dev@nongnu.org
List-Id: alsa-devel@alsa-project.org

What is the correct syntax for "aplay" to use device 3 of card 0 ?

# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: au8830 [au8830], device 0: AU88x0 ADB [adb]
   Subdevices: 32/32
   Subdevice #0: subdevice #0
   Subdevice #1: subdevice #1
   Subdevice #2: subdevice #2
   Subdevice #3: subdevice #3
   Subdevice #4: subdevice #4
   Subdevice #5: subdevice #5
   Subdevice #6: subdevice #6
   Subdevice #7: subdevice #7
   Subdevice #8: subdevice #8
   Subdevice #9: subdevice #9
   Subdevice #10: subdevice #10
   Subdevice #11: subdevice #11
   Subdevice #12: subdevice #12
   Subdevice #13: subdevice #13
   Subdevice #14: subdevice #14
   Subdevice #15: subdevice #15
   Subdevice #16: subdevice #16
   Subdevice #17: subdevice #17
   Subdevice #18: subdevice #18
   Subdevice #19: subdevice #19
   Subdevice #20: subdevice #20
   Subdevice #21: subdevice #21
   Subdevice #22: subdevice #22
   Subdevice #23: subdevice #23
   Subdevice #24: subdevice #24
   Subdevice #25: subdevice #25
   Subdevice #26: subdevice #26
   Subdevice #27: subdevice #27
   Subdevice #28: subdevice #28
   Subdevice #29: subdevice #29
   Subdevice #30: subdevice #30
   Subdevice #31: subdevice #31
card 0: au8830 [au8830], device 1: AU88x0 SPDIF [spdif]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 0: au8830 [au8830], device 2: AU88x0 A3D [a3d]
   Subdevices: 16/16
   Subdevice #0: subdevice #0
   Subdevice #1: subdevice #1
   Subdevice #2: subdevice #2
   Subdevice #3: subdevice #3
   Subdevice #4: subdevice #4
   Subdevice #5: subdevice #5
   Subdevice #6: subdevice #6
   Subdevice #7: subdevice #7
   Subdevice #8: subdevice #8
   Subdevice #9: subdevice #9
   Subdevice #10: subdevice #10
   Subdevice #11: subdevice #11
   Subdevice #12: subdevice #12
   Subdevice #13: subdevice #13
   Subdevice #14: subdevice #14
   Subdevice #15: subdevice #15
card 0: au8830 [au8830], device 3: AU88x0 WT [wt]
   Subdevices: 64/64
   Subdevice #0: subdevice #0
   Subdevice #1: subdevice #1
   Subdevice #2: subdevice #2
   Subdevice #3: subdevice #3
   Subdevice #4: subdevice #4
   Subdevice #5: subdevice #5
   Subdevice #6: subdevice #6
   Subdevice #7: subdevice #7
   Subdevice #8: subdevice #8
   Subdevice #9: subdevice #9
   Subdevice #10: subdevice #10
   Subdevice #11: subdevice #11
   Subdevice #12: subdevice #12
   Subdevice #13: subdevice #13
   Subdevice #14: subdevice #14
   Subdevice #15: subdevice #15
   Subdevice #16: subdevice #16
   Subdevice #17: subdevice #17
   Subdevice #18: subdevice #18
   Subdevice #19: subdevice #19
   Subdevice #20: subdevice #20
   Subdevice #21: subdevice #21
   Subdevice #22: subdevice #22
   Subdevice #23: subdevice #23
   Subdevice #24: subdevice #24
   Subdevice #25: subdevice #25
   Subdevice #26: subdevice #26
   Subdevice #27: subdevice #27
   Subdevice #28: subdevice #28
   Subdevice #29: subdevice #29
   Subdevice #30: subdevice #30
   Subdevice #31: subdevice #31
   Subdevice #32: subdevice #32
   Subdevice #33: subdevice #33
   Subdevice #34: subdevice #34
   Subdevice #35: subdevice #35
   Subdevice #36: subdevice #36
   Subdevice #37: subdevice #37
   Subdevice #38: subdevice #38
   Subdevice #39: subdevice #39
   Subdevice #40: subdevice #40
   Subdevice #41: subdevice #41
   Subdevice #42: subdevice #42
   Subdevice #43: subdevice #43
   Subdevice #44: subdevice #44
   Subdevice #45: subdevice #45
   Subdevice #46: subdevice #46
   Subdevice #47: subdevice #47
   Subdevice #48: subdevice #48
   Subdevice #49: subdevice #49
   Subdevice #50: subdevice #50
   Subdevice #51: subdevice #51
   Subdevice #52: subdevice #52
   Subdevice #53: subdevice #53
   Subdevice #54: subdevice #54
   Subdevice #55: subdevice #55
   Subdevice #56: subdevice #56
   Subdevice #57: subdevice #57
   Subdevice #58: subdevice #58
   Subdevice #59: subdevice #59
   Subdevice #60: subdevice #60
   Subdevice #61: subdevice #61
   Subdevice #62: subdevice #62
   Subdevice #63: subdevice #63


# aplay --list-pcms
PCM list:
hw {
         @args.0 CARD
         @args.1 DEV
         @args.2 SUBDEV
         @args.CARD {
                 type string
                 default {
                         @func getenv
                         vars {
                                 0 ALSA_PCM_CARD
                                 1 ALSA_CARD
                         }
                         default {
                                 @func refer
                                 name 'defaults.pcm.card'
                         }
                 }
         }
         @args.DEV {
                 type integer
                 default {
                         @func igetenv
                         vars {
                                 0 ALSA_PCM_DEVICE
                         }
                         default {
                                 @func refer
                                 name 'defaults.pcm.device'
                         }
                 }
         }
         @args.SUBDEV {
                 type integer
                 default {
                         @func refer
                         name 'defaults.pcm.subdevice'
                 }
         }
         type hw
         card $CARD
         device $DEV
         subdevice $SUBDEV
}
plughw {
         @args.0 CARD
         @args.1 DEV
         @args.2 SUBDEV
         @args.CARD {
                 type string
                 default {
                         @func getenv
                         vars {
                                 0 ALSA_PCM_CARD
                                 1 ALSA_CARD
                         }
                         default {
                                 @func refer
                                 name 'defaults.pcm.card'
                         }
                 }
         }
         @args.DEV {
                 type integer
                 default {
                         @func igetenv
                         vars {
                                 0 ALSA_PCM_DEVICE
                         }
                         default {
                                 @func refer
                                 name 'defaults.pcm.device'
                         }
                 }
         }
         @args.SUBDEV {
                 type integer
                 default {
                         @func refer
                         name 'defaults.pcm.subdevice'
                 }
         }
         type plug
         slave.pcm {
                 type hw
                 card $CARD
                 device $DEV
                 subdevice $SUBDEV
         }
}
plug {
         @args.0 SLAVE
         @args.SLAVE {
                 type string
         }
         type plug
         slave.pcm $SLAVE
}
dmix {
         @args.0 SLAVE
         @args.1 FORMAT
         @args.2 RATE
         @args.SLAVE {
                 type string
                 default 'hw:0,0'
         }
         @args.FORMAT {
                 type string
                 default S16_LE
         }
         @args.RATE {
                 type integer
                 default 48000
         }
         type dmix
         ipc_key 5678293
         ipc_key_add_uid yes
         slave {
                 pcm $SLAVE
                 format $FORMAT
                 rate $RATE
         }
}
dsnoop {
         @args.0 SLAVE
         @args.1 FORMAT
         @args.2 RATE
         @args.SLAVE {
                 type string
                 default 'hw:0,0'
         }
         @args.FORMAT {
                 type string
                 default S16_LE
         }
         @args.RATE {
                 type integer
                 default 48000
         }
         type dsnoop
         ipc_key 5778293
         ipc_key_add_uid yes
         slave {
                 pcm $SLAVE
                 format $FORMAT
                 rate $RATE
         }
}
shm {
         @args.0 SOCKET
         @args.1 PCM
         @args.SOCKET {
                 type string
         }
         @args.PCM {
                 type string
         }
         type shm
         server $SOCKET
         pcm $PCM
}
tee {
         @args.0 SLAVE
         @args.1 FILE
         @args.2 FORMAT
         @args.SLAVE {
                 type string
         }
         @args.FILE {
                 type string
         }
         @args.FORMAT {
                 type string
                 default raw
         }
         type file
         slave.pcm $SLAVE
         file $FILE
         format $FORMAT
}
file {
         @args.0 FILE
         @args.1 FORMAT
         @args.FILE {
                 type string
         }
         @args.FORMAT {
                 type string
                 default raw
         }
         type file
         slave.pcm null
         file $FILE
         format $FORMAT
}
null {
         type null
}
cards 'cards.pcm'
front 'cards.pcm.front'
rear 'cards.pcm.rear'
center_lfe 'cards.pcm.center_lfe'
side 'cards.pcm.side'
surround40 'cards.pcm.surround40'
surround41 'cards.pcm.surround41'
surround50 'cards.pcm.surround50'
surround51 'cards.pcm.surround51'
surround71 'cards.pcm.surround71'
iec958 'cards.pcm.iec958'
spdif 'cards.pcm.iec958'
modem 'cards.pcm.modem'
default 'cards.pcm.default'



>
>> # more /proc/asound/card0/pcm3p/info
>> card: 0
>> device: 3
>> subdevice: 0
>> stream: PLAYBACK
>> id: AU88x0 WT
>> name: wt
>> subname: subdevice #0
>> class: 0
>> subclass: 0
>> subdevices_count: 64
>> subdevices_avail: 64
>>
>>
>> # aplay -D hw:0,3 test.wav
>> Playing WAVE 'test.wav' : Unsigned 8 bit, Rate 11025 Hz, Mono
>> aplay: set_params:857: Sample format non available
>>
>>
>> 4) How can we use "aplay" to play test.wav on the card 0 device 3 ?

> The problem with the WT device is either a bug in the DMA code or a
> bad route. The WT DMA works almost indentical to the ADB DMA engine,
> but with its separate set of registers. I have looked over and over
> uncountable times, without finding any clue. The most uncertainty is
> in regard of the WT routes. The only thing i know is that each WT bank
> has 32 channels, each channel with some processing capabilities
> (pitch, delay, filter, gain, etc) and there are 32 + 6 sources toward
> the routing bus for each bank. I guess that the first 32 sources are
> mapped to each individual WT dma channel and the other extra 6 sources
> are some kind of downmix of the entire bank. But i am still clueless
> about why having 32 individual sources for each channel, if we have
> only 32 mixer inputs, and many of them are already being used ? There
> is no way to make use of all of them, thats why i guess that there
> must be some downmix of each WT block available somehow.


http://www.3dsoundsurge.com/drivers/a3d.html#WINDOWS 9x DRIVER ISSUES


2) How did you perform your "WT DMA" test ?





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
