From: Jason Harvey <softdevice@jasonline.co.uk>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Thu, 23 Oct 2008 15:23:24 +0100
Message-ID: <490088DC.7090205@jasonline.co.uk>
References: <s5hy70xsl46.wl%tiwai@suse.de>	<48F739F4.5070303@nostalgicnetworxx.org>	<48F74344.4090509@gmail.com>
	<s5hvdvs1wig.wl%tiwai@suse.de>	<5501535d0810220824o6b8bf427qd2c806783ec1e56f@mail.gmail.com>	<s5h4p34mz0j.wl%tiwai@suse.de>	<5501535d0810220907p2102afc2t13e47ff5309c01bc@mail.gmail.com>	<5501535d0810220924w66341ac6u4d4de4ed87243a7@mail.gmail.com>	<48FF7E17.9080601@gmail.com>
	<s5h4p3350o4.wl%tiwai@suse.de>	<5501535d0810230446j52de12aes885d066ea38cb240@mail.gmail.com>	<4900659E.90809@jasonline.co.uk>
	<s5hbpxb8lfe.wl%tiwai@suse.de>	<490071DC.6070607@jasonline.co.uk>
	<s5habcv5mu0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040709030005010307000209"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from homer.jasonline.co.uk (78-86-168-217.zone2.bethere.co.uk
	[78.86.168.217])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F7CB1038FF
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Oct 2008 16:23:32 +0200 (CEST)
In-Reply-To: <s5habcv5mu0.wl%tiwai@suse.de>
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
--------------040709030005010307000209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> What is the last kernel message from sbxfi driver?
> Usually it prints some messages (as debug=1 as default).
>
>   

I applied the patch and when trying "mplayer wn.wav" I consistently get 
the following message on the console

PANIC: double fault, gdt at c13f6000 [255 bytes]

nothing else, either reboots instantly or locks up.

In case you might find it of use I modprobed at debug=3 and ran dmesg 
before I ran mplayer. Output attached.

Regards, Jason

--------------040709030005010307000209
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

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
SBXFI: Setting TLB buffer page 0x1daff000
SBXFI:   write(0) 0x13b004 = 0x1daff000
SBXFI:   write(0) 0x13b000 = 0x0


--------------040709030005010307000209
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------040709030005010307000209--
