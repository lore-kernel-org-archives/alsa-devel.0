From: Philip Prindeville <philipp_subx@redfish-solutions.com>
Subject: Re: Fixes for identifying VT1617 codec and MSI-7142
 mobo
Date: Fri, 12 Aug 2005 12:12:28 -0600
Message-ID: <42FCE68C.3080609@redfish-solutions.com>
References: <42F655E2.5040504@redfish-solutions.com>	<20050807192732.GA3079@procyon.home>	<42F78569.5070604@redfish-solutions.com>	<s5hmzns1iud.wl%tiwai@suse.de>	<42F8F69D.2050302@redfish-solutions.com>	<s5hpssk69ge.wl%tiwai@suse.de>	<42FBA554.3040604@redfish-solutions.com>	<s5h1x4z5ic1.wl%tiwai@suse.de>	<s5hzmrn43d1.wl%tiwai@suse.de>	<42FCD781.3070306@redfish-solutions.com>	<s5hpssj3w1g.wl%tiwai@suse.de>	<42FCDCE7.20702@redfish-solutions.com>	<s5hmznn3vsw.wl%tiwai@suse.de>	<42FCDE94.70901@redfish-solutions.com> <s5hk6ir3vep.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hk6ir3vep.wl%tiwai@suse.de>
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

>At Fri, 12 Aug 2005 11:38:28 -0600,
>Philip Prindeville wrote:
>  
>
>>Takashi Iwai wrote:
>>
>>    
>>
>>>At Fri, 12 Aug 2005 11:31:19 -0600,
>>>Philip Prindeville wrote:
>>> 
>>>
>>>      
>>>
>>>>Takashi Iwai wrote:
>>>>
>>>>   
>>>>
>>>>        
>>>>
>>>>>At Fri, 12 Aug 2005 11:08:17 -0600,
>>>>>Philip Prindeville wrote:
>>>>>
>>>>>
>>>>>     
>>>>>
>>>>>          
>>>>>
>>>>>>Well, this is what I get when I try the patch:
>>>>>>  
>>>>>>
>>>>>>       
>>>>>>
>>>>>>            
>>>>>>
>>>>>Hmm, what happens with "aplay -Dhw:0,0" ?
>>>>>If this fails, the problem must be in the wrong DXS entry.
>>>>>
>>>>>
>>>>>Takashi
>>>>>
>>>>>
>>>>>     
>>>>>
>>>>>          
>>>>>
>>>>No sound at all.
>>>>   
>>>>
>>>>        
>>>>
>>>This can't happen with a proper mixer setting if you can hear from
>>>hw:0,1.
>>>
>>>My question was whether aplay complains about the sample rate like
>>>spdif PCM.
>>>
>>>
>>>Takashi
>>> 
>>>
>>>      
>>>
>>Actually, with "aplay -Dhw:0,1 ..." I don't hear any sound either.
>>    
>>
>
>Then it's a problem of mixer configuration or physical connection.
>  
>

Ah, sorry...  Should I have been listening on an analogue input on
my receiver instead?  Ok, switched...  with -Dhw0,1 on an analogue
port (and keeping VIA_DXS_SRC) I hear signal.  My settings are:

[root@media ~]# amixer -c0
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 31 [100%] [on]
  Front Right: Playback 31 [100%] [on]
Simple mixer control 'Master Mono',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 31 [100%] [on]
Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 22 [71%] [on]
  Front Right: Playback 22 [71%] [on]
Simple mixer control '3D Control - Center',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 15
  Mono: 0 [0%]
Simple mixer control '3D Control - Depth',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 15
  Mono: 0 [0%]
Simple mixer control '3D Control - Switch',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 23 [74%] [on]
  Front Right: Playback 23 [74%] [on]
Simple mixer control 'Surround',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 0 [0%] [off]
  Front Right: Playback 0 [0%] [off]
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 0 [0%] [off]
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 0 [0%] [off]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined 
cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 22 [71%] [on] Capture [off]
  Front Right: Playback 22 [71%] [on] Capture [off]
Simple mixer control 'CD',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined 
cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 22 [71%] [on] Capture [off]
  Front Right: Playback 22 [71%] [on] Capture [off]
Simple mixer control 'Mic',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch 
cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono: Playback 0 [0%] [off]
  Front Left: Capture [on]
  Front Right: Capture [on]
Simple mixer control 'Mic Boost (+20dB)',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Mic Select',0
  Capabilities:
  Mono:
Simple mixer control 'Video',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'Phone',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch 
cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono: Playback 22 [71%] [on]
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958 Output',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958 Playback AC97-SPSA',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 3
  Mono: 3 [100%]
Simple mixer control 'PC Speaker',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 15
  Mono: Playback 15 [100%] [on]
Simple mixer control 'Aux',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined 
cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 22 [71%] [on] Capture [off]
  Front Right: Playback 22 [71%] [on] Capture [off]
Simple mixer control 'Mono Output Select',0
  Capabilities:
  Mono:
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch cswitch-joined
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 15
  Front Left: Capture 0 [0%] [on]
  Front Right: Capture 0 [0%] [on]
Simple mixer control 'Mix',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'Mix Mono',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'External Amplifier',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Input Source Select',0
  Capabilities:
  Mono:
Simple mixer control 'Input Source Select',1
  Capabilities:
  Mono:
[root@media ~]#

Also get signal with -Dhw0,0 on an analogue port...


(Still the same warning about the rate mismatch, though...)


> 
>  
>
>>BTW:  How does aplay detect which bitrates the card will support?
>>    
>>
>
>It checks the value of snd_pcm_hw_params_set_rate_near().
>  
>

I tried not changing ac97->rates[AC97_RATES_SPDIF] at all, but that
didn't make any difference...

 

>  
>
>>It keeps
>>telling me the card won't do 44100Hz:
>>
>>Playing WAVE '/usr/share/system-config-soundcard/sound-sample.wav' : 
>>Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
>>Warning: rate is not accurate (requested = 44100Hz, got = 48000Hz)
>>         please, try the plug plugin (-Dplug:spdif)
>>    
>>
>
>Well I see this message in your ealier mail.  What about the result of
>"aplay -Dhw0,0" regarding this?
>
>
>Takashi
>  
>

Ditto:

[root@media ~]# aplay -v  -Dhw:0,0 
/usr/share/system-config-soundcard/sound-sample.wav
Playing WAVE '/usr/share/system-config-soundcard/sound-sample.wav' : 
Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Warning: rate is not accurate (requested = 44100Hz, got = 48000Hz)
         please, try the plug plugin (-Dplug:hw:0,0)
Hardware PCM card 0 'VIA 8237' device 0 subdevice 0

Its setup is:
stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 48000
exact rate   : 48000 (48000/1)
msbits       : 16
buffer_size  : 16384
period_size  : 4096
period_time  : 85333
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
[root@media ~]#





-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
