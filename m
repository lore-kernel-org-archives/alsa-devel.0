From: Andreas Hartmann <andihartmann@freenet.de>
Subject: Re: [Realtek ALC260] Can't enable SPDIF out
Date: Fri, 01 Sep 2006 20:05:50 +0200
Message-ID: <44F8767E.4050203@p54A1ACFB.dip0.t-ipconnect.de>
References: <200609010118.k811I1KU028677@auster.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200609010118.k811I1KU028677@auster.physics.adelaide.edu.au>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Jonathan,

Jonathan Woithe wrote:
> Hi Andreas
> 
> First up, please note that my ALC260-equipped laptop doesn't make SPDIF
> output available on the laptop itself, so I am unable to test any theories
> myself.  This is also the reason why my ALC260 patches from early this
> year didn't really touch on SPDIF - I had no way to test them.  The docking
> station might have SPDIF but I don't have one of those.

It's ok. I would be very happy, if you could help me S/PDIF out to get to
work. I'm nearly clueless about soundcards and the programming. But I know
a little bit about C and programming itself, so I think, I could get it
working with you together.

>> I've got some additional information. Meanwhile, I compiled the alsa
>> sources with debug option, which gives this output in /etc/messages:
>> 
>> kernel: ALSA hda_intel.c:665: codec_mask = 0x3
>> kernel: ALSA patch_realtek.c:4278: hda_codec: Unknown model for ALC260,
>> trying auto-probe from BIOS...
>> kernel: ALSA hda_codec.c:2154: autoconfig: line_outs=1 (0xf/0x0/0x0/0x0/0x0)
>> kernel: ALSA hda_codec.c:2158:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
>> kernel: ALSA hda_codec.c:2160:    hp=0x0, dig_out=0x18, din_in=0x0
>> kernel: ALSA hda_codec.c:2168:    inputs: mic=0x12, fmic=0x0, line=0x0,
>> fline=0x0, cd=0x16, aux=0x0
> 
> Hmm, interesting.  I notice that the digital output is in fact being
> identified.  That's a good start; it probably means a pcm interface is
> also being created for it.

I've got one pcm interface (in alsamixer or kmix).

[...]

> Back to your tests: when you tried to get SPDIF output what command line 
> were you using to send audio to it?

I tested it with xmms. xmms has three options:
default
hw:0,0
hw:0,1

No matter what I'm using, the output in the headphone jack is always analog.

alsamixer or kmix do have a switch for S/PDIF. You can switch it on or off
- the output is always analog.

> With the ALC260 chip the digital output is totally separate to the analog
> DAC.  If, for example, you were tryiung to test SPDIF by sending audio data
> to the same pcm interface as you use to get analog audio output there's no
> way SPDIF will work.

Ok - but I have just one pcm interface (in alsamixer and kmix) - nothing
more. Therefore, there seems to be one pcm interface missing.

> This might be something worth looking into if you
> haven't already.  When testing SPDIF output make sure you're sending to the
> pcm interface associated with the SPDIF (digital) output.

Could it be possible, that there is just one pcm interface, which can be
switched to the one (analog) or other (S/PDIF) format?



Now, I tested with aplay.

andreas@notebook1:~> aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: ALC260 Analog [ALC260 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 1: ALC260 Digital [ALC260 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0


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
phoneline 'cards.pcm.phoneline'
default 'cards.pcm.default'
dmix 'cards.pcm.dmix'
dsnoop 'cards.pcm.dsnoop'


If I'm using aplay -D default, the output is analog. If I'm using -D
iec958 or spdif, there isn't any output. Btw.: using -D spdif or iec958
switches on the spdif switch in the mixer.

The result of the above test is the same, no matter with or without your
patch.

> If you have done all the above and are definitely sending audio to the pcm
> associated with the digital output then we have to look deeper.  This will
> involve using the "test" model (available only when alsa is compiled with
> "--enable-debug".

That's what I have already done. The output above from /var/log/messages
is created if the source is compiled with --with-debug=detect.

> However, my quick reading of alsa-driver 1.0.12 seems to
> suggest that the digital I/Os are not active in the test model (which I
> think you've already confirmed).

That's right. I can confirm this. I had a look too to the source and got
the same idea.

>  I will try to have a look at this over the
> weekend.  In the meantime, you could try the following completely
> untested patch and see if it gives you access to digital pcms in
> test mode.

If you like, we could chat (ok, I've never done so far (besides Sametime),
but it would be a chance to learn it :-)).

> --- patch_realtek.c-orig        2006-08-24 04:05:39.000000000 +0930
> +++ patch_realtek.c     2006-09-01 10:27:30.000000000 +0930
> @@ -4028,7 +4028,9 @@
> 		.init_verbs = { alc260_test_init_verbs },
> 		.num_dacs = ARRAY_SIZE(alc260_test_dac_nids),
> 		.dac_nids = alc260_test_dac_nids,
> +		.dig_out_nid = ALC260_DIGOUT_NID, 
> 		.num_adc_nids = ARRAY_SIZE(alc260_test_adc_nids),
> +		.dig_in_nid = ALC260_DIGIN_NID,
> 		.adc_nids = alc260_test_adc_nids,
> 		.num_channel_mode = ARRAY_SIZE(alc260_modes),
> 		.channel_mode = alc260_modes,
> 
> Since I have not looked into the digital I/O side of these codecs at
> all I don't know if this is all that's needed.
> 
> Once we get digital I/O functionality into the test model it will be a case
> of trying the various mixer controls to see if any of them enable SPDIF
> output.  The test model creates alsamixer controls for every "control"
> provided by the ALC260 chip so there's lots to play with.  Given past
> experience with Acer laptops, it would not surprise me to find that your
> laptop uses one of the GPIO controls to switch SPDIF output to the output
> jack.  For this reason I would start with the GPIO controls.

What is GPIO controls? And what is "capture" (I can see two capture
controls in alsamixer or kmix).


Kind regards,
Andreas Hartmann


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
