From: "J. Gordon Rankin" <waudio-P3U7sUXGDiZeoWH0uzbU5w@public.gmane.org>
Subject: Re: Problem with USB Class 2 Audio Driver
Date: Mon, 23 Aug 2010 16:34:50 -0400
Message-ID: <4C72DB6A.5080601@cinti.net>
References: <054801cb40c9$70349710$509dc530$@com> <20100821092700.GS17833@buzzloop.caiaq.de> <060e01cb4255$007593b0$0160bb10$@com> <20100823191209.GF17833@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100823191209.GF17833-ahpEBR4enfnCULTFXS99ULNAH6kLmebB@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Cc: Demian Martin <demianm_1-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Daniel,

Part of the problem could be that everything is working synchronously. 
The reading of the USB drive and the outputting to the USB converter are 
both happening  in sync because the application would work this way.

High End Audio is usually nuts... but I have experienced that this type 
of combination results in poor output even when it works 100%. I have 
yet had time to figure out why... same reason that FLAC never sounds as 
good as a WAV file in my experience, though there I can verify that the 
CPU usage does go up higher than most people and engineers would suspect.

Thanks
Gordon

Daniel Mack wrote:
> Hi,
>
> FWIW, I currently have no clue what could be the reason for this issue.
> I copied the linux-usb mailing list, maybe anyone over there has an
> idea.
>
> Summary is: Demian is trying to play back an audio file over an USB
> connected soundcard, and the file itself is also stored on a media
> connected via USB. The transfer alone seems to be reasonably fast
> (tested with 'dd'), and the card itself also works fine (tested with a
> file stored on a different media), but the combination of them both
> fails. At least for high sample rates - iow, high data throughput.
>
> Could there be anything wrong with the isochronous bandwith reservation?
>
>
> Thanks,
> Daniel
>
>
> On Sun, Aug 22, 2010 at 04:51:55PM -0700, Demian Martin wrote:
>   
>> Daniel:
>> I'll try to provide all the info you want. I'll need some prompting for some
>> details, please be patient with me.
>>
>> First the system.
>> I have tested on both an intel D945GSEJT atom based MB and an Alis 3.3 AMD
>> Geode based mb.
>> OS: Linux auraliti-player 2.6.32auraliti-2.0 #1 PREEMPT Fri Jul 30 06:48:14
>> GMT 2010 i686 GNU/Linux
>> Distro Voyage Linux 0.6.1
>> It's a dedicated headless 2 channel audio player, sort of a high performance
>> squeezebox. Details here: www.auraliti.com
>>
>> When I play a file from a network source (connected through nfs) I have no
>> problems with either .wav or .flac. 
>>
>> I don't know how to tell with certainty if the USB devices are connecting
>> through a common or separate root hubs.
>>
>> USB stick speed- It took 6.2 seconds to pass a 1 minute 19 second 192/24
>> file to dev/null so USB speed is not a problem. 
>>
>> It seems there is a collision when there is a high speed USB storage device
>> and the USB class 2 audio on the same host port both moving data at the same
>> time. 
>>
>> All of the following were done with the Alix board (Geode 500 MHz
>> processor). The Intel does similar but seems more likely to work.
>>
>> Under some conditions the system loses connection to the USB audio device:
>> auraliti-player:~# aplay -v -Dplughw:1
>> /media/usb0/Trio-Mytek8X192ADDA-192k.WAV
>> Playing WAVE '/media/usb0/Trio-Mytek8X192ADDA-192k.WAV' : Signed 24 bit
>> Little Endian in 3bytes, Rate 192000 Hz, Stereo
>> aplay: set_params:1116: Unable to install hw params:
>> ACCESS:  RW_INTERLEAVED
>> FORMAT:  S24_3LE
>> SUBFORMAT:  STD
>> SAMPLE_BITS: 24
>> FRAME_BITS: 48
>> CHANNELS: 2
>> RATE: 192000
>> PERIOD_TIME: 125000
>> PERIOD_SIZE: 24000
>> PERIOD_BYTES: 144000
>> PERIODS: 4
>> BUFFER_TIME: 500000
>> BUFFER_SIZE: 96000
>> BUFFER_BYTES: 576000
>> TICK_TIME: 0
>> auraliti-player:~#
>>
>> Fixed by disconnecting and reconnecting the device.
>>
>>
>> Here is what I get playing a 44.1 file, after about 15 seconds:
>>
>> Playing WAVE '/media/usb0/Piano_44_1.wav' : Signed 24 bit Little Endian in
>> 3bytes, Rate 44100 Hz, Stereo
>> Plug PCM: Linear conversion PCM (S32_LE)
>> Its setup is:
>>   stream       : PLAYBACK
>>   access       : RW_INTERLEAVED
>>   format       : S24_3LE
>>   subformat    : STD
>>   channels     : 2
>>   rate         : 44100
>>   exact rate   : 44100 (44100/1)
>>   msbits       : 24
>>   buffer_size  : 22050
>>   period_size  : 5513
>>   period_time  : 125011
>>   tstamp_mode  : NONE
>>   period_step  : 1
>>   avail_min    : 5513
>>   period_event : 0
>>   start_threshold  : 22050
>>   stop_threshold   : 22050
>>   silence_threshold: 0
>>   silence_size : 0
>>   boundary     : 1445068800
>> Slave: Hardware PCM card 1 'WaveLink HS SPDIF' device 0 subdevice 0
>> Its setup is:
>>   stream       : PLAYBACK
>>   access       : MMAP_INTERLEAVED
>>   format       : S32_LE
>>   subformat    : STD
>>   channels     : 2
>>   rate         : 44100
>>   exact rate   : 44100 (44100/1)
>>   msbits       : 32
>>   buffer_size  : 22050
>>   period_size  : 5513
>>   period_time  : 125011
>>   tstamp_mode  : NONE
>>   period_step  : 1
>>   avail_min    : 5513
>>   period_event : 0
>>   start_threshold  : 22050
>>   stop_threshold   : 22050
>>   silence_threshold: 0
>>   silence_size : 0
>>   boundary     : 1445068800
>>   appl_ptr     : 0
>>   hw_ptr       : 0
>> underrun!!! (at least 0.015 ms long)
>> Status:
>>   state       : XRUN
>>   trigger_time: 903.806908643
>>   tstamp      : 903.807038997
>>   delay       : 0
>>   avail       : 0
>>   avail_max   : 11028
>> aplay: xrun:1259: xrun: prepare error: File descriptor in bad state
>> auraliti-player:~#
>>
>> And the system stops playing.
>>
>> And very quickly on a 176.4 file:
>>
>> Playing WAVE '/media/usb0/01_Rimsky-Korsakov Dance of the Tumblers.wav' :
>> Signed 24 bit Little Endian in 3bytes, Rate 176400 Hz, Stereo
>> Plug PCM: Linear conversion PCM (S32_LE)
>> Its setup is:
>>   stream       : PLAYBACK
>>   access       : RW_INTERLEAVED
>>   format       : S24_3LE
>>   subformat    : STD
>>   channels     : 2
>>   rate         : 176400
>>   exact rate   : 176400 (176400/1)
>>   msbits       : 24
>>   buffer_size  : 88200
>>   period_size  : 22050
>>   period_time  : 125000
>>   tstamp_mode  : NONE
>>   period_step  : 1
>>   avail_min    : 22050
>>   period_event : 0
>>   start_threshold  : 88200
>>   stop_threshold   : 88200
>>   silence_threshold: 0
>>   silence_size : 0
>>   boundary     : 1445068800
>> Slave: Hardware PCM card 1 'WaveLink HS SPDIF' device 0 subdevice 0
>> Its setup is:
>>   stream       : PLAYBACK
>>   access       : MMAP_INTERLEAVED
>>   format       : S32_LE
>>   subformat    : STD
>>   channels     : 2
>>   rate         : 176400
>>   exact rate   : 176400 (176400/1)
>>   msbits       : 32
>>   buffer_size  : 88200
>>   period_size  : 22050
>>   period_time  : 125000
>>   tstamp_mode  : NONE
>>   period_step  : 1
>>   avail_min    : 22050
>>   period_event : 0
>>   start_threshold  : 88200
>>   stop_threshold   : 88200
>>   silence_threshold: 0
>>   silence_size : 0
>>   boundary     : 1445068800
>>   appl_ptr     : 0
>>   hw_ptr       : 0
>> underrun!!! (at least 0.010 ms long)
>> Status:
>>   state       : XRUN
>>   trigger_time: 1050.313984810
>>   tstamp      : 1050.314067000
>>   delay       : 0
>>   avail       : 1413
>>   avail_max   : 22071
>> aplay: xrun:1259: xrun: prepare error: File descriptor in bad state
>> auraliti-player:~#
>>
>> If in interpose a USB 1 hub on the usb storage I get this:
>>
>> auraliti-player:~# aplay -v -Dplughw:1 /media/usb0/01_Rimsky-Korsakov\
>> Dance\ of\ the\ Tumblers.wav
>> Playing WAVE '/media/usb0/01_Rimsky-Korsakov Dance of the Tumblers.wav' :
>> Signed 24 bit Little Endian in 3bytes, Rate 176400 Hz, Stereo
>> Plug PCM: Linear conversion PCM (S32_LE)
>> Its setup is:
>>   stream       : PLAYBACK
>>   access       : RW_INTERLEAVED
>>   format       : S24_3LE
>>   subformat    : STD
>>   channels     : 2
>>   rate         : 176400
>>   exact rate   : 176400 (176400/1)
>>   msbits       : 24
>>   buffer_size  : 88200
>>   period_size  : 22050
>>   period_time  : 125000
>>   tstamp_mode  : NONE
>>   period_step  : 1
>>   avail_min    : 22050
>>   period_event : 0
>>   start_threshold  : 88200
>>   stop_threshold   : 88200
>>   silence_threshold: 0
>>   silence_size : 0
>>   boundary     : 1445068800
>> Slave: Hardware PCM card 1 'WaveLink HS SPDIF' device 0 subdevice 0
>> Its setup is:
>>   stream       : PLAYBACK
>>   access       : MMAP_INTERLEAVED
>>   format       : S32_LE
>>   subformat    : STD
>>   channels     : 2
>>   rate         : 176400
>>   exact rate   : 176400 (176400/1)
>>   msbits       : 32
>>   buffer_size  : 88200
>>   period_size  : 22050
>>   period_time  : 125000
>>   tstamp_mode  : NONE
>>   period_step  : 1
>>   avail_min    : 22050
>>   period_event : 0
>>   start_threshold  : 88200
>>   stop_threshold   : 88200
>>   silence_threshold: 0
>>   silence_size : 0
>>   boundary     : 1445068800
>>   appl_ptr     : 0
>>   hw_ptr       : 0
>> underrun!!! (at least 1.537 ms long)
>> Status:
>>   state       : XRUN
>>   trigger_time: 1219.804905467
>>   tstamp      : 1219.820257912
>>   delay       : 0
>>   avail       : 88220
>>   avail_max   : 88220
>> underrun!!! (at least 13.900 ms long)
>> Status:
>>   state       : XRUN
>>   trigger_time: 1222.763695807
>>   tstamp      : 1222.902684537
>>   delay       : 0
>>   avail       : 66169
>>   avail_max   : 88219
>> underrun!!! (at least 1.279 ms long)
>> Status:
>>   state       : XRUN
>>   trigger_time: 1225.972436940
>>   tstamp      : 1225.985216250
>>   delay       : 0
>>   avail       : 88221
>>   avail_max   : 88221
>> underrun!!! (at least 14.141 ms long)
>>
>> etc. until I stop the playback. 
>>
>> 44.1 playback is fine under these conditions (but then why USB audio class
>> 2?)
>>
>> Further, using MPD for playback I have discovered that the high bit rate
>> flac files play fine but the same files as wave have the same type of
>> stall/stop problems.
>>
>> I tried Windows on the Intel platform with similar problems using windows
>> media player but no problems with VLC. However with Windows it is not easy
>> to know what is really going on inside.
>>
>> Is it possible that the essentially synchronous nature of playing a wave
>> file from USB source to USB Audio device causes a collision since the data
>> is going both ways at essentially the same rate and timing?
>>
>> Let me know what other info you need.
>>
>> Thanks for looking at this.
>>             -Demian
>>
>>
>>
>>
>> -----Original Message-----
>> From: Daniel Mack [mailto:daniel-rDUAYElUppE@public.gmane.org] 
>> Sent: Saturday, August 21, 2010 2:27 AM
>> To: Demian Martin
>> Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
>> Subject: Re: Problem with USB Class 2 Audio Driver
>>
>> On Fri, Aug 20, 2010 at 05:40:22PM -0700, Demian Martin wrote:
>>     
>>> I'm testing an early sample of the Wavelength Wavelink, a USB to S/PDIF
>>> adapter that supports 44.1-192 KHz sample rates and uses async usb to talk
>>> to ALSA. It works and plays all of the sample rates correctly with the git
>>> version of Alsa from 7/30/2010 whenthe files are sourced from the network.
>>>       
>> What do you mean by "from the network"? How does your test setup look
>> like?
>>
>>     
>>> However if I try to play from a usb source to the usb dac it doesn't work
>>> and the whole system gets unstable. 
>>>       
>> You could also be more precise here :) What doesn't work, how are you
>> testing, and in which regard does the system get unstable?
>>
>>     
>>> The platforms I have tested it on seem
>>> to have a single USB host interface but with USB 2 there should be enough
>>> bandwidth to pass the data from a USB stick to the cpu and back. If I use
>>>       
>> an
>>     
>>> older 96 only usb dac on the same system it works (unless the down
>>> conversion isn't a direct divide, which overloads the CPU, but that is a
>>> different issue). The problem seems to be sample rate independent and hits
>>> the moment I try to access the file. This is using MPD as a player.
>>>       
>> Ah, so your data file is stored on a media which is also connected to
>> USB? Did you connect the two devices to different USB ports or do they
>> share one uplink with a hub?
>>
>>     
>>> What additional info do you need to troubleshoot this? Is it an intrinsic
>>> limitation to the interface? What additional tests should I do? It's
>>> possible it's a hardware issue but how do I divide them so I can go back
>>>       
>> to
>>     
>>> the hardware guy if it's his issue? 
>>>       
>> I'm not aware of any limitation, but there could be such issues as
>> exceeded bandwith on the bus and the like. How many audio channels are
>> we talking about?
>>
>> You could measure the speed of your USB media by using something like
>> this:
>>
>> 	$ time dd if=/path/to/192khz.file of=/dev/null
>>
>> This should take significantly less time than - let's say - half the
>> real-time audio playback time of the file, so there's enough headroom to
>> transport the audio data back to the USB DAC.
>>
>> What kind of system is this, after all? Did you try other OS on the same
>> hardware for comparsion?
>>
>>
>> Daniel
>>
>>
>>     
>
>
>   

-- 
J. Gordon Rankin
Owner and Chief Scientist
====== Wavelength Audio, ltd ======
High-End Audio since 1981
SET Tube Amplifiers, DACS & Preamps
http://www.WavelengthAudio.com
===================================
Computer USB DACS
http://www.USBDacs.com
===================================
SET Tube Guitar Amplifiers
NAMM Member since 1998
http://www.Guitar-Engines.com
===================================
3703 Petoskey Avenue
Cincinnati, Ohio 45227 USA
mailto:waudio-P3U7sUXGDiZeoWH0uzbU5w@public.gmane.org
mailto:wavelength-rDkNP/OoUoU@public.gmane.org
(513) 271-4186 phone/voicemail

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
