From: Jacopo De Simoi <jacopods@gmail.com>
Subject: Conexant CX20561 on HP Pavilion dv2700
Date: Wed, 20 Jan 2010 13:27:50 +0100
Message-ID: <201001201327.50727.jacopods@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id ECAC62451D
	for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2010 13:26:33 +0100 (CET)
Received: by ewy23 with SMTP id 23so4412421ewy.4
	for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2010 04:26:33 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear alsa-devs 
  I'm trying to have CX20561 in working order on my laptop; I'll be glad to send a patch once I figure out what is going on there, and for this I need your help.

There are a number of issues, mostly regarding the internal mic, as I'm sure you know considering the bugs volume on the subject :)

1a) There are three capture sources listed in alsamixer (Digital excluded): Docking External Internal; the only one that has any influence in recording (both from internal and external mics) is "External" 

1b) Why does Node 0x14 shows two volume controls? the first one doesn't seem to have any effect.

2) The input from the internal mic device has very low volume and is very noisy; I tried to optimize fiddling around with hda_verb and the values in alsa-info; the output of codec#0 below shows the optimal ones. (the only relevant ones were gains on node 0x17).
I managed, however, to saturate it by blowing directly into it, which shows that it is not really an amplification issue. Rather the real issue here is noise; Audacity shows ~-24dB and in 16bits the noise background gets up to ~+/-500 versus +/-50 with an external mic. 
The internal mic is indeed a stereo mic; the left channel only produces noise, the right channel seems to work, with the caveats above. (this could be very well that my mic is broken, even if I remember that at some point during my fiddling with hda_verb it started to work properly :)
in any case I noticed that the noise background  is very much correlated between R and L; would it be possible to write an alsa-plugin to mix the two channels with an inversion to mix away the noise? It sounds fairly simple, but I couldn't find any documentation on how to make a plugin

I'm willing to invest some time on fixing this, so maybe I can get some help here to start with. 
Judging from the patch_conexant code it should be at least possible to fix #1. I'd like to hear your thoughts about #2; especially about fiddling around with hda_verb or making the described alsa-plugin. 
Thanks a lot
 Jacopo De Simoi


!!################################                                         
!!ALSA Information Script v 0.4.58                                         
!!################################                                         

!!Script ran on: Wed Jan 20 08:49:43 UTC 2010


!!Linux Distribution
!!------------------

Gentoo Base System release 2.0.0


!!DMI Information
!!---------------

Manufacturer:      Hewlett-Packard
Product Name:      HP Pavilion dv2700 Notebook PC


!!Kernel Information
!!------------------

Kernel release:    2.6.30-tuxonice-r9
Operating System:  GNU/Linux         
Architecture:      x86_64            
Processor:         AMD Turion(tm) 64 X2 TL-62
SMP Enabled:       Yes                       


!!ALSA Version
!!------------

Driver version:     1.0.22.1
Library version:    1.0.22  
Utilities version:  1.0.22  


!!Loaded ALSA modules
!!-------------------

snd_hda_intel


!!Sound Servers on this system
!!----------------------------

No sound servers found.


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [NVidia         ]: HDA-Intel - HDA NVidia
                      HDA NVidia at 0xfc480000 irq 20


!!PCI Soundcards installed in the system
!!--------------------------------------

00:07.0 Audio device: nVidia Corporation MCP67 High Definition Audio (rev a1)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:07.0 0403: 10de:055c (rev a1)
        Subsystem: 103c:30d6    


!!Modprobe options (Sound related)
!!--------------------------------

snd-hda-intel: model=laptop
snd-hda-intel: model=auto  


!!Loaded sound module options
!!-------------------------- 

!!Module: snd_hda_intel
        bdl_pos_adj : 32,-1,-1,-1,-1,-1,-1,-1
        beep_mode : 1,1,1,1,1,1,1,1          
        enable : Y,Y,Y,Y,Y,Y,Y,Y             
        enable_msi : -1                      
        id : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
        index : -1,-1,-1,-1,-1,-1,-1,-1                             
        model : laptop,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
        patch : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
        position_fix : 0,0,0,0,0,0,0,0                                 
        power_save : 0                                                 
        power_save_controller : Y                                      
        probe_mask : -1,-1,-1,-1,-1,-1,-1,-1                           
        probe_only : N,N,N,N,N,N,N,N                                   
        single_cmd : N                                                 


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--            

Codec: Conexant CX20561 (Hermosa)
Address: 0                       
Function Id: 0x2                 
Vendor Id: 0x14f15051            
Subsystem Id: 0x103c30d6         
Revision Id: 0x100000            
Modem Function Group: 0x2        
Default PCM:                     
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24            
    formats [0x1]: PCM              
Default Amp-In caps: N/A            
Default Amp-Out caps: N/A           
GPIO: io=4, o=0, i=0, unsolicited=1, wake=0
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[3]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Node 0x10 [Audio Output] wcaps 0xc1d: Stereo Amp-Out R/L   
  Control: name="Master Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0               
  Device: name="CONEXANT Analog", type="Audio", device=0   
  Amp-Out caps: ofs=0x4a, nsteps=0x4a, stepsize=0x03, mute=0
  Amp-Out vals:  [0x3b 0x3b]                                
  Converter: stream=0, channel=0                            
  PCM:                                                      
    rates [0x560]: 44100 48000 96000 192000                 
    bits [0xe]: 16 20 24                                    
    formats [0x1]: PCM                                      
  Power states:  D0 D1 D2 D3                                
  Power: setting=D0, actual=D0                              
Node 0x11 [Audio Output] wcaps 0xc1d: Stereo Amp-Out R/L    
  Amp-Out caps: ofs=0x4a, nsteps=0x4a, stepsize=0x03, mute=0
  Amp-Out vals:  [0x4a 0x4a]                                
  Converter: stream=0, channel=0                            
  PCM:                                                      
    rates [0x560]: 44100 48000 96000 192000                 
    bits [0xe]: 16 20 24                                    
    formats [0x1]: PCM                                      
  Power states:  D0 D1 D2 D3                                
  Power: setting=D0, actual=D0                              
Node 0x12 [Audio Output] wcaps 0x211: Stereo Digital        
  Converter: stream=0, channel=0                            
  Digital:                                                  
  Digital category: 0x0                                     
  PCM:                                                      
    rates [0x160]: 44100 48000 96000                        
    bits [0xe]: 16 20 24                                    
    formats [0x5]: PCM AC3                                  
Node 0x13 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x03, nsteps=0x03, stepsize=0x17, mute=0  
  Amp-Out vals:  [0x00]                                       
Node 0x14 [Audio Input] wcaps 0x100d1b: Stereo Amp-In R/L     
  Control: name="Internal Mic Volume", index=0, device=0      
    ControlAmp: chs=3, dir=In, idx=0, ofs=0                   
  Control: name="Internal Mic Switch", index=0, device=0      
    ControlAmp: chs=3, dir=In, idx=0, ofs=0                   
  Control: name="External Mic Volume", index=0, device=0      
    ControlAmp: chs=3, dir=In, idx=1, ofs=0                   
  Control: name="External Mic Switch", index=0, device=0      
    ControlAmp: chs=3, dir=In, idx=1, ofs=0                   
  Device: name="CONEXANT Analog", type="Audio", device=0      
  Amp-In caps: ofs=0x4a, nsteps=0x50, stepsize=0x03, mute=0   
  Amp-In vals:  [0x00 0x00] [0x50 0x50]                       
  Converter: stream=0, channel=0                              
  SDI-Select: 0                                               
  PCM:                                                        
    rates [0x160]: 44100 48000 96000                          
    bits [0xe]: 16 20 24                                      
    formats [0x1]: PCM                                        
  Power states:  D0 D1 D2 D3                                  
  Power: setting=D0, actual=D0                                
  Connection: 2                                               
     0x1d 0x17*                                               
Node 0x15 [Audio Input] wcaps 0x100d1b: Stereo Amp-In R/L     
  Control: name="Docking Mic Volume", index=0, device=0       
    ControlAmp: chs=3, dir=In, idx=0, ofs=0                   
  Control: name="Docking Mic Switch", index=0, device=0       
    ControlAmp: chs=3, dir=In, idx=0, ofs=0                   
  Amp-In caps: ofs=0x4a, nsteps=0x50, stepsize=0x03, mute=0   
  Amp-In vals:  [0x00 0x00]                                   
  Converter: stream=0, channel=0                              
  SDI-Select: 0                                               
  PCM:                                                        
    rates [0x160]: 44100 48000 96000                          
    bits [0xe]: 16 20 24                                      
    formats [0x1]: PCM                                        
  Power states:  D0 D1 D2 D3                                  
  Power: setting=D0, actual=D0                                
  Connection: 1                                               
     0x18                                                     
Node 0x16 [Pin Complex] wcaps 0x400581: Stereo                
  Pincap 0x0000001c: OUT HP Detect                            
  Pin Default 0x01214030: [Jack] HP Out at Ext Rear           
    Conn = 1/8, Color = Green                                 
    DefAssociation = 0x3, Sequence = 0x0                      
  Pin-ctls: 0xc0: OUT HP                                      
  Unsolicited: tag=37, enabled=1                              
  Power states:  D0 D1 D2 D3                                  
  Power: setting=D0, actual=D0                                
  Connection: 2                                               
     0x10* 0x11                                               
Node 0x17 [Pin Complex] wcaps 0x40048b: Stereo Amp-In         
  Amp-In caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0   
  Amp-In vals:  [0x04 0x04]                                   
  Pincap 0x00001224: IN Detect                                
    Vref caps: 50 80                                          
  Pin Default 0x01a19020: [Jack] Mic at Ext Rear              
    Conn = 1/8, Color = Pink                                  
    DefAssociation = 0x2, Sequence = 0x0                      
  Pin-ctls: 0x24: IN VREF_80                                  
  Unsolicited: tag=38, enabled=1                              
  Power states:  D0 D1 D2 D3                                  
  Power: setting=D0, actual=D0                                
Node 0x18 [Pin Complex] wcaps 0x40048b: Stereo Amp-In         
  Amp-In caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0   
  Amp-In vals:  [0x00 0x00]                                   
  Pincap 0x00001224: IN Detect                                
    Vref caps: 50 80                                          
  Pin Default 0x400001f0: [N/A] Line Out at Ext N/A           
    Conn = Unknown, Color = Unknown                           
    DefAssociation = 0xf, Sequence = 0x0                      
    Misc = NO_PRESENCE                                        
  Pin-ctls: 0x00: VREF_HIZ                                    
  Unsolicited: tag=39, enabled=1                              
  Power states:  D0 D1 D2 D3                                  
  Power: setting=D0, actual=D0                                
Node 0x19 [Pin Complex] wcaps 0x400581: Stereo                
  Pincap 0x00000014: OUT Detect                               
  Pin Default 0x400001f0: [N/A] Line Out at Ext N/A           
    Conn = Unknown, Color = Unknown                           
    DefAssociation = 0xf, Sequence = 0x0                      
    Misc = NO_PRESENCE                                        
  Pin-ctls: 0x00:                                             
  Unsolicited: tag=00, enabled=0                              
  Power states:  D0 D1 D2 D3                                  
  Power: setting=D0, actual=D0                                
  Connection: 2                                               
     0x10 0x11*                                               
Node 0x1a [Pin Complex] wcaps 0x400501: Stereo                
  Pincap 0x00010010: OUT EAPD                                 
  EAPD 0x0:                                                   
  Pin Default 0x92170110: [Fixed] Speaker at Int Front        
    Conn = Analog, Color = Unknown                            
    DefAssociation = 0x1, Sequence = 0x0                      
    Misc = NO_PRESENCE                                        
  Pin-ctls: 0x00:                                             
  Power states:  D0 D1 D2 D3                                  
  Power: setting=D0, actual=D0                                
  Connection: 2                                               
     0x10* 0x11                                               
Node 0x1b [Pin Complex] wcaps 0x400500: Mono                  
  Pincap 0x00010010: OUT EAPD                                 
  EAPD 0x0:                                                   
  Pin Default 0x400001f0: [N/A] Line Out at Ext N/A           
    Conn = Unknown, Color = Unknown                           
    DefAssociation = 0xf, Sequence = 0x0                      
    Misc = NO_PRESENCE                                        
  Pin-ctls: 0x40: OUT                                         
  Power states:  D0 D1 D2 D3                                  
  Power: setting=D0, actual=D0                                
  Connection: 2                                               
     0x10* 0x11                                               
Node 0x1c [Pin Complex] wcaps 0x400701: Stereo Digital        
  Control: name="IEC958 Playback Con Mask", index=0, device=0 
  Control: name="IEC958 Playback Pro Mask", index=0, device=0 
  Control: name="IEC958 Playback Default", index=0, device=0  
  Control: name="IEC958 Playback Switch", index=0, device=0   
  Control: name="IEC958 Default PCM Playback Switch", index=0, device=0
  Device: name="Conexant Digital", type="SPDIF", device=1              
  Pincap 0x00000010: OUT                                               
  Pin Default 0x400001f0: [N/A] Line Out at Ext N/A                    
    Conn = Unknown, Color = Unknown                                    
    DefAssociation = 0xf, Sequence = 0x0                               
    Misc = NO_PRESENCE                                                 
  Pin-ctls: 0x00:                                                      
  Power states:  D0 D1 D2 D3                                           
  Power: setting=D0, actual=D0                                         
  Connection: 1                                                        
     0x12                                                              
Node 0x1d [Pin Complex] wcaps 0x40040b: Stereo Amp-In                  
  Amp-In caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0            
  Amp-In vals:  [0x04 0x04]                                            
  Pincap 0x00000020: IN                                                
  Pin Default 0x400001f0: [N/A] Line Out at Ext N/A                    
    Conn = Unknown, Color = Unknown                                    
    DefAssociation = 0xf, Sequence = 0x0                               
    Misc = NO_PRESENCE                                                 
  Pin-ctls: 0x00:                                                      
  Power states:  D0 D1 D2 D3                                           
  Power: setting=D0, actual=D0                                         
Node 0x1e [Vendor Defined Widget] wcaps 0xf00000: Mono                 
--endcollapse--                                                        


!!ALSA Device nodes
!!-----------------

crw-rw---- 1 root audio 116,  0 Jan 19 20:26 /dev/snd/controlC0
crw-rw---- 1 root audio 116,  4 Jan 19 20:26 /dev/snd/hwC0D0   
crw-rw---- 1 root audio 116, 24 Jan 20 09:31 /dev/snd/pcmC0D0c 
crw-rw---- 1 root audio 116, 16 Jan 20 09:34 /dev/snd/pcmC0D0p 
crw-rw---- 1 root audio 116, 17 Jan 19 20:26 /dev/snd/pcmC0D1p 
crw-rw---- 1 root audio 116,  1 Jan 19 20:26 /dev/snd/seq      
crw-rw---- 1 root audio 116, 33 Jan 19 20:26 /dev/snd/timer    


!!Aplay/Arecord output
!!------------        

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: NVidia [HDA NVidia], device 0: CONEXANT Analog [CONEXANT Analog]
  Subdevices: 1/1                                                       
  Subdevice #0: subdevice #0                                            
card 0: NVidia [HDA NVidia], device 1: Conexant Digital [Conexant Digital]
  Subdevices: 1/1                                                         
  Subdevice #0: subdevice #0                                              

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: NVidia [HDA NVidia], device 0: CONEXANT Analog [CONEXANT Analog]
  Subdevices: 1/1                                                       
  Subdevice #0: subdevice #0                                            

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [NVidia]

Card hw:0 'NVidia'/'HDA NVidia at 0xfc480000 irq 20'
  Mixer name    : 'Conexant CX20561 (Hermosa)'      
  Components    : 'HDA:14f15051,103c30d6,00100000'  
  Controls      : 15                                
  Simple ctrls  : 8                                 
Simple mixer control 'Master',0                     
  Capabilities: pvolume pswitch pswitch-joined penum
  Playback channels: Front Left - Front Right       
  Limits: Playback 0 - 74                           
  Mono:                                             
  Front Left: Playback 59 [80%] [-15.00dB] [off]    
  Front Right: Playback 59 [80%] [-15.00dB] [off]   
Simple mixer control 'PCM',0                        
  Capabilities: pvolume penum                       
  Playback channels: Front Left - Front Right       
  Limits: Playback 0 - 255                          
  Mono:                                             
  Front Left: Playback 255 [100%] [0.00dB]          
  Front Right: Playback 255 [100%] [0.00dB]         
Simple mixer control 'IEC958',0                     
  Capabilities: pswitch pswitch-joined penum        
  Playback channels: Mono                           
  Mono: Playback [on]                               
Simple mixer control 'IEC958 Default PCM',0         
  Capabilities: pswitch pswitch-joined penum        
  Playback channels: Mono                           
  Mono: Playback [on]                               
Simple mixer control 'Digital',0                    
  Capabilities: cvolume penum                       
  Capture channels: Front Left - Front Right        
  Limits: Capture 0 - 120                           
  Front Left: Capture 0 [0%] [-30.00dB]             
  Front Right: Capture 0 [0%] [-30.00dB]            
Simple mixer control 'Docking Mic',0                
  Capabilities: volume pswitch penum                
  Playback channels: Front Left - Front Right       
  Capture channels: Front Left - Front Right        
  Limits: 0 - 80                                    
  Front Left: 0 [0%] [-74.00dB] Playback [on]       
  Front Right: 0 [0%] [-74.00dB] Playback [on]      
Simple mixer control 'External Mic',0               
  Capabilities: volume pswitch penum                
  Playback channels: Front Left - Front Right       
  Capture channels: Front Left - Front Right        
  Limits: 0 - 80                                    
  Front Left: 80 [100%] [6.00dB] Playback [on]      
  Front Right: 80 [100%] [6.00dB] Playback [on]     
Simple mixer control 'Internal Mic',0               
  Capabilities: volume pswitch penum                
  Playback channels: Front Left - Front Right       
  Capture channels: Front Left - Front Right        
  Limits: 0 - 80                                    
  Front Left: 0 [0%] [-74.00dB] Playback [on]       
  Front Right: 0 [0%] [-74.00dB] Playback [on]      


!!Alsactl output
!!------------- 

--startcollapse--
state.NVidia {   
        control.1 {
                comment.access 'read write'
                comment.type INTEGER       
                comment.count 2            
                comment.range '0 - 80'     
                comment.dbmin -7400        
                comment.dbmax 600          
                iface MIXER                
                name 'Internal Mic Volume' 
                value.0 0                  
                value.1 0                  
        }                                  
        control.2 {                        
                comment.access 'read write'
                comment.type BOOLEAN       
                comment.count 2            
                iface MIXER                
                name 'Internal Mic Switch' 
                value.0 true               
                value.1 true               
        }                                  
        control.3 {                        
                comment.access 'read write'
                comment.type INTEGER       
                comment.count 2            
                comment.range '0 - 80'     
                comment.dbmin -7400        
                comment.dbmax 600          
                iface MIXER                
                name 'External Mic Volume' 
                value.0 80                 
                value.1 80                 
        }                                  
        control.4 {                        
                comment.access 'read write'
                comment.type BOOLEAN       
                comment.count 2            
                iface MIXER                
                name 'External Mic Switch' 
                value.0 true               
                value.1 true               
        }                                  
        control.5 {                        
                comment.access 'read write'
                comment.type INTEGER       
                comment.count 2            
                comment.range '0 - 80'     
                comment.dbmin -7400        
                comment.dbmax 600          
                iface MIXER                
                name 'Docking Mic Volume'  
                value.0 0                  
                value.1 0                  
        }                                  
        control.6 {                        
                comment.access 'read write'
                comment.type BOOLEAN       
                comment.count 2            
                iface MIXER                
                name 'Docking Mic Switch'  
                value.0 true               
                value.1 true               
        }                                  
        control.7 {                        
                comment.access 'read write'
                comment.type INTEGER       
                comment.count 2            
                comment.range '0 - 74'     
                comment.dbmin -7400        
                comment.dbmax 0            
                iface MIXER                
                name 'Master Playback Volume'
                value.0 59                   
                value.1 59                   
        }                                    
        control.8 {                          
                comment.access 'read write'  
                comment.type BOOLEAN         
                comment.count 1              
                iface MIXER                  
                name 'Master Playback Switch'
                value false                  
        }                                    
        control.9 {                          
                comment.access read          
                comment.type IEC958          
                comment.count 1              
                iface MIXER                  
                name 'IEC958 Playback Con Mask'
                value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'                                                        
        }                                                                                                                                       
        control.10 {                                                                                                                            
                comment.access read                                                                                                             
                comment.type IEC958                                                                                                             
                comment.count 1                                                                                                                 
                iface MIXER                                                                                                                     
                name 'IEC958 Playback Pro Mask'                                                                                                 
                value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'                                                        
        }                                                                                                                                       
        control.11 {                                                                                                                            
                comment.access 'read write'                                                                                                     
                comment.type IEC958                                                                                                             
                comment.count 1                                                                                                                 
                iface MIXER                                                                                                                     
                name 'IEC958 Playback Default'                                                                                                  
                value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'                                                        
        }                                                                                                                                       
        control.12 {                                                                                                                            
                comment.access 'read write'                                                                                                     
                comment.type BOOLEAN                                                                                                            
                comment.count 1                                                                                                                 
                iface MIXER                                                                                                                     
                name 'IEC958 Playback Switch'                                                                                                   
                value true                                                                                                                      
        }                                                                                                                                       
        control.13 {                                                                                                                            
                comment.access 'read write'                                                                                                     
                comment.type BOOLEAN                                                                                                            
                comment.count 1                                                                                                                 
                iface MIXER                                                                                                                     
                name 'IEC958 Default PCM Playback Switch'                                                                                       
                value true                                                                                                                      
        }                                                                                                                                       
        control.14 {                                                                                                                            
                comment.access 'read write user'                                                                                                
                comment.type INTEGER                                                                                                            
                comment.count 2                                                                                                                 
                comment.range '0 - 255'                                                                                                         
                comment.tlv '0000000100000008ffffec1400000014'                                                                                  
                comment.dbmin -5100                                                                                                             
                comment.dbmax 0                                                                                                                 
                iface MIXER                                                                                                                     
                name 'PCM Playback Volume'                                                                                                      
                value.0 255                                                                                                                     
                value.1 255                                                                                                                     
        }                                                                                                                                       
        control.15 {                                                                                                                            
                comment.access 'read write user'                                                                                                
                comment.type INTEGER                                                                                                            
                comment.count 2                                                                                                                 
                comment.range '0 - 120'                                                                                                         
                comment.tlv '0000000100000008fffff44800000032'                                                                                  
                comment.dbmin -3000                                                                                                             
                comment.dbmax 3000                                                                                                              
                iface MIXER                                                                                                                     
                name 'Digital Capture Volume'                                                                                                   
                value.0 0                                                                                                                       
                value.1 0                                                                                                                       
        }                                                                                                                                       
}                                                                                                                                               
--endcollapse--                                                                                                                                 


!!All Loaded Modules
!!------------------

Module
ndiswrapper
bnep       
sco        
rfcomm     
l2cap      
snd_seq    
snd_seq_device
snd_hda_codec_conexant
uvcvideo              
videodev              
snd_hda_intel         
snd_hda_codec         
snd_hwdep             
snd_pcm               
snd_timer             
sdhci_pci             
sdhci                 
mmc_core              
v4l1_compat           
nvidia                
forcedeth             
snd                   
btusb                 
bluetooth
v4l2_compat_ioctl32
led_class
snd_page_alloc


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x16 0x01214030
0x17 0x01a19020
0x18 0x400001f0
0x19 0x400001f0
0x1a 0x92170110
0x1b 0x400001f0
0x1c 0x400001f0
0x1d 0x400001f0

/sys/class/sound/hwC0D0/driver_pin_configs:

/sys/class/sound/hwC0D0/user_pin_configs:

/sys/class/sound/hwC0D0/init_verbs:


!!ALSA/HDA dmesg
!!------------------

[    8.457898] ACPI: PCI Interrupt Link [LAZA] enabled at IRQ 20
[    8.457916] HDA Intel 0000:00:07.0: PCI INT A -> Link[LAZA] -> GSI 20 (level, low) -> IRQ 20
[    8.457970] HDA Intel 0000:00:07.0: setting latency timer to 64
[    8.499562] Linux video capture interface: v2.00
--
[    8.548267] USB Video Class driver (v0.1.0)
[    9.660207] input: HDA NVidia Mic as /class/input/input10
[    9.660575] input: HDA NVidia Mic as /class/input/input11
[    9.660798] input: HDA NVidia Headphone as /class/input/input12
[   10.842906] kjournald starting.  Commit interval 5 seconds
--
[18156.018398] forcedeth 0000:00:0a.0: PCI INT A disabled
[18156.400042] HDA Intel 0000:00:07.0: PCI INT A disabled
[18156.440030] ehci_hcd 0000:00:04.1: PCI INT B disabled
--
[18157.038988] ehci_hcd 0000:00:04.1: restoring config space at offset 0x1 (was 0xb00006, writing 0xb00002)
[18157.039014] HDA Intel 0000:00:07.0: restoring config space at offset 0xf (was 0x5020100, writing 0x502010a)
[18157.039022] HDA Intel 0000:00:07.0: restoring config space at offset 0x4 (was 0x0, writing 0xfc480000)
[18157.039027] HDA Intel 0000:00:07.0: restoring config space at offset 0x1 (was 0xb00000, writing 0xb00002)
[18157.039057] ahci 0000:00:09.0: restoring config space at offset 0x1 (was 0xb00007, writing 0xb00407)
--
[18157.150089] amd74xx 0000:00:06.0: BIOS didn't set cable bits correctly. Enabling workaround.
[18157.150111] HDA Intel 0000:00:07.0: PCI INT A -> Link[LAZA] -> GSI 20 (level, low) -> IRQ 20
[18157.150115] HDA Intel 0000:00:07.0: setting latency timer to 64
[18157.850034] pci 0000:00:08.0: setting latency timer to 64
