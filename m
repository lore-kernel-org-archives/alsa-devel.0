From: Jason Harvey <softdevice@jasonline.co.uk>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Thu, 23 Oct 2008 17:23:22 +0100
Message-ID: <4900A4FA.7020300@jasonline.co.uk>
References: <s5hy70xsl46.wl%tiwai@suse.de>	<48F739F4.5070303@nostalgicnetworxx.org>	<48F74344.4090509@gmail.com>
	<s5hvdvs1wig.wl%tiwai@suse.de>	<5501535d0810220824o6b8bf427qd2c806783ec1e56f@mail.gmail.com>	<s5h4p34mz0j.wl%tiwai@suse.de>	<5501535d0810220907p2102afc2t13e47ff5309c01bc@mail.gmail.com>	<5501535d0810220924w66341ac6u4d4de4ed87243a7@mail.gmail.com>	<48FF7E17.9080601@gmail.com>
	<s5h4p3350o4.wl%tiwai@suse.de>	<5501535d0810230446j52de12aes885d066ea38cb240@mail.gmail.com>	<4900659E.90809@jasonline.co.uk>
	<s5hbpxb8lfe.wl%tiwai@suse.de>	<490071DC.6070607@jasonline.co.uk>
	<s5habcv5mu0.wl%tiwai@suse.de>	<490088DC.7090205@jasonline.co.uk>
	<s5hzlkv44v7.wl%tiwai@suse.de>	<s5hwsfz44i9.wl%tiwai@suse.de>
	<49009A26.3000201@jasonline.co.uk>	<s5hod1b436i.wl%tiwai@suse.de>
	<s5hljwf42x4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030803050506020904090005"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from homer.jasonline.co.uk (78-86-168-217.zone2.bethere.co.uk
	[78.86.168.217]) by alsa0.perex.cz (Postfix) with ESMTP id 0B00524525
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Oct 2008 18:23:33 +0200 (CEST)
In-Reply-To: <s5hljwf42x4.wl%tiwai@suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030803050506020904090005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> Fixed and uploaded now.
> It might take some time until the changes are sync'ed.
>   
Thanks, downloaded, patched fine.
Attached dmesg_modprobe.txt shows output before playing anything.

No sound now using  the oss workaround "echo mplayer 0 0 direct > 
/proc/asound/card0/pcm0p/oss"
Mplayer starts but doesn't increment shows 0% 0seconds etc etc, it can 
be interrupted ctrl-c, the PC remains functional, just no sound.
dmesg_after.txt is the tail end of dmesg after interrupting mplayer, I 
trimmed it as the first couple seven lines repeat for about 330K in the 
original log :)
Instant reboot when trying mplayer without the oss workaround.

aplay -Dplug:dmix:0 wn.wav still works.
Trying mplayer after aplay freezes the machine with no output onto the 
console.

Thanks again, Jason

--------------030803050506020904090005
Content-Type: text/plain;
 name="dmesg_after.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg_after.txt"

                                                              
SBXFI: IRQ = 0x500                                                                                 
SBXFI:   read(0) 0x1b0010 = 0x0                                                                    
SBXFI: POINTER = 0x3e0                                                                             
SBXFI: SET TIMER TICKS = 16                                                                        
SBXFI:   write(0) 0x1c6004 = 0xc010                                                                
SBXFI:   write(0) 0x1c6010 = 0x500                                                                 
SBXFI:   read(0) 0x1c6010 = 0x500                                                                  
SBXFI: IRQ = 0x500                                                                                 
SBXFI:   read(0) 0x1b0010 = 0x0                                                                    
SBXFI: POINTER = 0x3e0                                                                             
SBXFI: SET TIMER TICKS = 16                                                                        
SBXFI:   write(0) 0x1c6004 = 0xc010                                                                
SBXFI:   write(0) 0x1c6010 = 0x500                                                                 
SBXFI:   read(0) 0x1c6010 = 0x500                                                                  
SBXFI: IRQ = 0x500                                                                                 
SBXFI:   read(0) 0x1b0010 = 0x0                                                                    
SBXFI: POINTER = 0x3e0                                                                             
SBXFI: SET TIMER TICKS = 16                                                                        
SBXFI:   write(0) 0x1c6004 = 0xc010                                                                
SBXFI:   write(0) 0x1c6010 = 0x500                                                                 
ALSA /root/alsa-driver-unstable/acore/pcm_native.c:1498: playback drain error (DMA or IRQ trouble?)
SBXFI: PLAY TRIGGER STOP                                                                           
SBXFI:   read(0) 0x1b0000 = 0x0                                                                    
SBXFI:   write(0) 0x1b0000 = 0x0                                                                   
SBXFI:   read(0) 0x1b0100 = 0x0                                                                    
SBXFI:   write(0) 0x1b0100 = 0x0                                                                   
SBXFI: PLAY UPDATE TIMER                                                                           
SBXFI: STOP EMU TIMER                                                                              
SBXFI:   write(0) 0x1c6004 = 0x0                                                                   
SBXFI:   write(0) 0x1c6014 = 0x0                                                                   
SBXFI: DAOIMAP CLEAR                                                                               
SBXFI:   write(0) 0x1c5000 = 0x0                                                                   
SBXFI:   write(0) 0x1c5004 = 0x0                                                                   
SBXFI:   write(0) 0x1c5008 = 0x0                                                                   
SBXFI:   write(0) 0x1c500c = 0x0                                                                   
SBXFI:   write(0) 0x1c5010 = 0x0                                                                   
SBXFI:   write(0) 0x1c5014 = 0x0                                                                   
SBXFI:   write(0) 0x1c5018 = 0x0                                                                   
SBXFI:   write(0) 0x1c501c = 0x0                                                                   
SBXFI:   write(0) 0x1c5020 = 0x0                                                                   
SBXFI:   write(0) 0x1c5024 = 0x0                                                                   
SBXFI:   write(0) 0x1c5028 = 0x0                                                                   
SBXFI:   write(0) 0x1c502c = 0x0                                                                   
SBXFI:   write(0) 0x1c5030 = 0x0                                                                   
SBXFI:   write(0) 0x1c5034 = 0x0                                                                   
SBXFI:   write(0) 0x1c5038 = 0x0                                                                   
SBXFI:   write(0) 0x1c503c = 0x0                                                                   
SBXFI:   write(0) 0x1c5040 = 0x0                                                                   
SBXFI:   write(0) 0x1c5044 = 0x0                                                                   
SBXFI:   write(0) 0x1c5048 = 0x0                                                                   
SBXFI:   write(0) 0x1c504c = 0x0                                                                   
SBXFI:   write(0) 0x1c5050 = 0x0                                                                   
SBXFI:   write(0) 0x1c5054 = 0x0                                                                   
SBXFI:   write(0) 0x1c5058 = 0x0                                                                   
SBXFI:   write(0) 0x1c505c = 0x0                                                                   
SBXFI:   write(0) 0x1c5060 = 0x0                                                                   
SBXFI:   write(0) 0x1c5064 = 0x0                                                                   
SBXFI:   write(0) 0x1c5068 = 0x0                                                                   
SBXFI:   write(0) 0x1c506c = 0x0                                                                   
SBXFI:   write(0) 0x1c5070 = 0x0                                                                   

SBXFI:   write(0) 0x1c5074 = 0x0                                                                   
SBXFI:   write(0) 0x1c5078 = 0x0                                                                   
SBXFI:   write(0) 0x1c507c = 0x0                                                                   
SBXFI:   write(0) 0x1c5080 = 0x0                                                                   
SBXFI:   write(0) 0x1c5084 = 0x0                                                                   
SBXFI:   write(0) 0x1c5088 = 0x0                                                                   
SBXFI:   write(0) 0x1c508c = 0x0                                                                   
SBXFI:   write(0) 0x1c5090 = 0x0                                                                   
SBXFI:   write(0) 0x1c5094 = 0x0                                                                   
SBXFI:   write(0) 0x1c5098 = 0x0                                                                   
SBXFI:   write(0) 0x1c509c = 0x0                                                                   
SBXFI:   write(0) 0x1c50a0 = 0x0                                                                   
SBXFI:   write(0) 0x1c50a4 = 0x0                                                                   
SBXFI:   write(0) 0x1c50a8 = 0x0                                                                   
SBXFI:   write(0) 0x1c50ac = 0x0                                                                   
SBXFI:   write(0) 0x1c50b0 = 0x0
SBXFI:   write(0) 0x1c50b4 = 0x0
SBXFI:   write(0) 0x1c50b8 = 0x0
SBXFI:   write(0) 0x1c50bc = 0x0
SBXFI:   write(0) 0x1c50c0 = 0x0
SBXFI:   write(0) 0x1c50c4 = 0x0
SBXFI:   write(0) 0x1c50c8 = 0x0
SBXFI:   write(0) 0x1c50cc = 0x0
SBXFI:   write(0) 0x1c50d0 = 0x0
SBXFI:   write(0) 0x1c50d4 = 0x0
SBXFI:   write(0) 0x1c50d8 = 0x0
SBXFI:   write(0) 0x1c50dc = 0x0
SBXFI:   write(0) 0x1c50e0 = 0x0
SBXFI:   write(0) 0x1c50e4 = 0x0
SBXFI:   write(0) 0x1c50e8 = 0x0
SBXFI:   write(0) 0x1c50ec = 0x0
SBXFI:   write(0) 0x1c50f0 = 0x0
SBXFI:   write(0) 0x1c50f4 = 0x0
SBXFI:   write(0) 0x1c50f8 = 0x0
SBXFI:   write(0) 0x1c50fc = 0x0
SBXFI:   write(0) 0x1c5100 = 0x0
SBXFI:   write(0) 0x1c5104 = 0x0
SBXFI:   write(0) 0x1c5108 = 0x0
SBXFI:   write(0) 0x1c510c = 0x0
SBXFI:   write(0) 0x1c5110 = 0x0
SBXFI:   write(0) 0x1c5114 = 0x0
SBXFI:   write(0) 0x1c5118 = 0x0
SBXFI:   write(0) 0x1c511c = 0x0
SBXFI:   write(0) 0x1c5120 = 0x0
SBXFI:   write(0) 0x1c5124 = 0x0
SBXFI:   write(0) 0x1c5128 = 0x0
SBXFI:   write(0) 0x1c512c = 0x0
SBXFI:   write(0) 0x1c5130 = 0x0
SBXFI:   write(0) 0x1c5134 = 0x0
SBXFI:   write(0) 0x1c5138 = 0x0
SBXFI:   write(0) 0x1c513c = 0x0
SBXFI: Release SRC 0
[root@sentry ~]#


--------------030803050506020904090005
Content-Type: text/plain;
 name="dmesg_modprobe.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg_modprobe.txt"

SBXFI:   read(0) 0x1c6010 = 0x0                                                                             
SBXFI: INIT HW                                                                                              
SBXFI:   read(0) 0x1c6070 = 0x104000                                                                        
SBXFI:   write(0) 0x1c6070 = 0x104000                                                                       
SBXFI:   write(0) 0x1c6070 = 0x104002                                                                       
SBXFI:   read(0) 0x1c6070 = 0x4002                                                                          
SBXFI:   read(0) 0x1c6070 = 0x104002                                                                        
SBXFI:   write(0) 0x1c6070 = 0x104aa3                                                                       
SBXFI:   read(0) 0x1c6070 = 0x104aa3                                                                        
SBXFI:   write(0) 0x1c6014 = 0x0                                                                            
SBXFI:   write(0) 0x1b102c = 0x0                                                                            
SBXFI:   read(0) 0x1b102c = 0x0                                                                             
SBXFI:   read(0) 0x1c6060 = 0xc08a0                                                                         
SBXFI:   write(0) 0x1c6060 = 0x1480a001                                                                     
SBXFI:   read(0) 0x1c6060 = 0x1000a001                                                                      
SBXFI:   read(0) 0x1c6060 = 0x1480a001                                                                      
SBXFI:   write(0) 0x1c6024 = 0x13fe                                                                         
SBXFI:   write(0) 0x13b404 = 0x13                                                                           
SBXFI:   write(0) 0x13b408 = 0x200c01                                                                       
SBXFI: DAOIMAP CLEAR                                                                                        
SBXFI:   write(0) 0x1c5000 = 0x0                                                                            
SBXFI:   write(0) 0x1c5004 = 0x0                                                                            
SBXFI:   write(0) 0x1c5008 = 0x0                                                                            
SBXFI:   write(0) 0x1c500c = 0x0                                                                            
SBXFI:   write(0) 0x1c5010 = 0x0                                                                            
SBXFI:   write(0) 0x1c5014 = 0x0                                                                            
SBXFI:   write(0) 0x1c5018 = 0x0                                                                            
SBXFI:   write(0) 0x1c501c = 0x0                                                                            
SBXFI:   write(0) 0x1c5020 = 0x0                                                                            
SBXFI:   write(0) 0x1c5024 = 0x0                                                                            
SBXFI:   write(0) 0x1c5028 = 0x0                                                                            
SBXFI:   write(0) 0x1c502c = 0x0                                                                            
SBXFI:   write(0) 0x1c5030 = 0x0                                                                            
SBXFI:   write(0) 0x1c5034 = 0x0                                                                            
SBXFI:   write(0) 0x1c5038 = 0x0                                                                            
SBXFI:   write(0) 0x1c503c = 0x0                                                                            
SBXFI:   write(0) 0x1c5040 = 0x0                                                                            
SBXFI:   write(0) 0x1c5044 = 0x0                                                                            
SBXFI:   write(0) 0x1c5048 = 0x0                                                                            
SBXFI:   write(0) 0x1c504c = 0x0                                                                            
SBXFI:   write(0) 0x1c5050 = 0x0                                                                            
SBXFI:   write(0) 0x1c5054 = 0x0                                                                            
SBXFI:   write(0) 0x1c5058 = 0x0                                                                            
SBXFI:   write(0) 0x1c505c = 0x0                                                                            
SBXFI:   write(0) 0x1c5060 = 0x0                                                                            
SBXFI:   write(0) 0x1c5064 = 0x0                                                                            
SBXFI:   write(0) 0x1c5068 = 0x0                                                                            
SBXFI:   write(0) 0x1c506c = 0x0                                                                            
SBXFI:   write(0) 0x1c5070 = 0x0                                                                            
SBXFI:   write(0) 0x1c5074 = 0x0                                                                            
SBXFI:   write(0) 0x1c5078 = 0x0                                                                            
SBXFI:   write(0) 0x1c507c = 0x0                                                                            
SBXFI:   write(0) 0x1c5080 = 0x0                                                                            
SBXFI:   write(0) 0x1c5084 = 0x0                                                                            
SBXFI:   write(0) 0x1c5088 = 0x0                                                                            
SBXFI:   write(0) 0x1c508c = 0x0                                                                            
SBXFI:   write(0) 0x1c5090 = 0x0                                                                            
SBXFI:   write(0) 0x1c5094 = 0x0                                                                            
SBXFI:   write(0) 0x1c5098 = 0x0                                                                            
SBXFI:   write(0) 0x1c509c = 0x0                                                                            
SBXFI:   write(0) 0x1c50a0 = 0x0                                                                            
SBXFI:   write(0) 0x1c50a4 = 0x0                                                                            
SBXFI:   write(0) 0x1c50a8 = 0x0                                                                            
SBXFI:   write(0) 0x1c50ac = 0x0                                                                            
SBXFI:   write(0) 0x1c50b0 = 0x0                                                                            
SBXFI:   write(0) 0x1c50b4 = 0x0                                                                            
SBXFI:   write(0) 0x1c50b8 = 0x0                                                                            
SBXFI:   write(0) 0x1c50bc = 0x0                                                                            
SBXFI:   write(0) 0x1c50c0 = 0x0                                                                            
SBXFI:   write(0) 0x1c50c4 = 0x0
SBXFI:   write(0) 0x1c50c8 = 0x0
SBXFI:   write(0) 0x1c50cc = 0x0
SBXFI:   write(0) 0x1c50d0 = 0x0
SBXFI:   write(0) 0x1c50d4 = 0x0
SBXFI:   write(0) 0x1c50d8 = 0x0
SBXFI:   write(0) 0x1c50dc = 0x0
SBXFI:   write(0) 0x1c50e0 = 0x0
SBXFI:   write(0) 0x1c50e4 = 0x0
SBXFI:   write(0) 0x1c50e8 = 0x0
SBXFI:   write(0) 0x1c50ec = 0x0
SBXFI:   write(0) 0x1c50f0 = 0x0
SBXFI:   write(0) 0x1c50f4 = 0x0
SBXFI:   write(0) 0x1c50f8 = 0x0
SBXFI:   write(0) 0x1c50fc = 0x0
SBXFI:   write(0) 0x1c5100 = 0x0
SBXFI:   write(0) 0x1c5104 = 0x0
SBXFI:   write(0) 0x1c5108 = 0x0
SBXFI:   write(0) 0x1c510c = 0x0
SBXFI:   write(0) 0x1c5110 = 0x0
SBXFI:   write(0) 0x1c5114 = 0x0
SBXFI:   write(0) 0x1c5118 = 0x0
SBXFI:   write(0) 0x1c511c = 0x0
SBXFI:   write(0) 0x1c5120 = 0x0
SBXFI:   write(0) 0x1c5124 = 0x0
SBXFI:   write(0) 0x1c5128 = 0x0
SBXFI:   write(0) 0x1c512c = 0x0
SBXFI:   write(0) 0x1c5130 = 0x0
SBXFI:   write(0) 0x1c5134 = 0x0
SBXFI:   write(0) 0x1c5138 = 0x0
SBXFI:   write(0) 0x1c513c = 0x0
SBXFI: INIT DAC
SBXFI:   read(0) 0x1c6020 = 0x8c00
SBXFI:   write(0) 0x1c6020 = 0x8c02
SBXFI: SETUP I2S
SBXFI:   read(0) 0x1c5420 = 0x0
SBXFI:   write(0) 0x1c5420 = 0x94040406


--------------030803050506020904090005
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------030803050506020904090005--
