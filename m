From: Philip Prindeville <philipp_subx@redfish-solutions.com>
Subject: Re: Fixes for identifying VT1617 codec and MSI-7142
 mobo
Date: Fri, 12 Aug 2005 13:37:20 -0600
Message-ID: <42FCFA70.90407@redfish-solutions.com>
References: <42F655E2.5040504@redfish-solutions.com>	<20050807192732.GA3079@procyon.home>	<42F78569.5070604@redfish-solutions.com>	<s5hmzns1iud.wl%tiwai@suse.de>	<42F8F69D.2050302@redfish-solutions.com>	<s5hpssk69ge.wl%tiwai@suse.de>	<42FBA554.3040604@redfish-solutions.com>	<s5h1x4z5ic1.wl%tiwai@suse.de>	<s5hzmrn43d1.wl%tiwai@suse.de>	<42FCD781.3070306@redfish-solutions.com>	<s5hpssj3w1g.wl%tiwai@suse.de>	<42FCDCE7.20702@redfish-solutions.com>	<s5hmznn3vsw.wl%tiwai@suse.de>	<42FCDE94.70901@redfish-solutions.com>	<s5hk6ir3vep.wl%tiwai@suse.de>	<42FCE68C.3080609@redfish-solutions.com> <s5hd5oj3t6p.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd5oj3t6p.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>At Fri, 12 Aug 2005 12:12:28 -0600,
>Philip Prindeville wrote:
>  
>
>>>Well I see this message in your ealier mail.  What about the result of
>>>"aplay -Dhw0,0" regarding this?
>>>
>>>
>>>Takashi
>>> 
>>>
>>>      
>>>
>>Ditto:
>>
>>[root@media ~]# aplay -v  -Dhw:0,0 
>>/usr/share/system-config-soundcard/sound-sample.wav
>>Playing WAVE '/usr/share/system-config-soundcard/sound-sample.wav' : 
>>Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
>>Warning: rate is not accurate (requested = 44100Hz, got = 48000Hz)
>>         please, try the plug plugin (-Dplug:hw:0,0)
>>Hardware PCM card 0 'VIA 8237' device 0 subdevice 0
>>    
>>
>
>This means that dxs_support is still set to DXS_48K, not DXS_SRC as
>expected.
>
>
>Takashi
>  
>

Zowie, you're right:

[root@media alsa]# lspci -v -n -s 0:11.5
00:11.5 Class 0401: 1106:3059 (rev 60)
        Subsystem: 1462:0430
        Flags: medium devsel, IRQ 185
        I/O ports at ec00 [size=256]
        Capabilities: [c0] Power Management version 2

[root@media alsa]#

So for whatever reason, the sound device has a different ID than the
motherboard...

via82xx: pci-id 0x1462:0x430
via82xx: Assuming DXS channels with 48k fixed sample rate.
         Please try dxs_support=1 or dxs_support=4 option
         and report if it works on your machine.

Ok, so I patched the PCI id, and now I'm not seeing the above warning
any more, but I *still* get:

[root@media alsa]# aplay -v  -D spdif 
/usr/share/system-config-soundcard/sound-sample.wav
Playing WAVE '/usr/share/system-config-soundcard/sound-sample.wav' : 
Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Warning: rate is not accurate (requested = 44100Hz, got = 48000Hz)
         please, try the plug plugin (-Dplug:spdif)
Hooks PCM
...

But when I play hw:0,0 out an analogue port, it works:

[root@media alsa]# aplay -v  -Dhw:0,0 
/usr/share/system-config-soundcard/sound-sample.wav
Playing WAVE '/usr/share/system-config-soundcard/sound-sample.wav' : 
Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Hardware PCM card 0 'VIA 8237' device 0 subdevice 0

Its setup is:
stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 16384
period_size  : 4096
period_time  : 92879
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 4096
xfer_align   : 4096
start_threshold  : 16384
stop_threshold   : 16384
silence_threshold: 0
silence_size : 0
boundary     : 4611686018427387904
[root@media alsa]#


I took out the setting of the speed from patch_vt1617a:

+ int patch_vt1617a(ac97_t * ac97)
+ {
+       ac97->ext_id |= AC97_EI_SPDIF;  /* force the detection of spdif */
+       return 0;
+ }
+
+ /*

so now it defaults to 32kHz, 44.1kHz, and 48kHz....  no idea why playing
via -D spdif should fail, unless the config files in /etc/alsa/ are wrong.

-Philip



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
