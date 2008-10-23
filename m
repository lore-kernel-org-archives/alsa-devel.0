From: Jason Harvey <softdevice@jasonline.co.uk>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Thu, 23 Oct 2008 16:37:10 +0100
Message-ID: <49009A26.3000201@jasonline.co.uk>
References: <s5hy70xsl46.wl%tiwai@suse.de>	<48F739F4.5070303@nostalgicnetworxx.org>	<48F74344.4090509@gmail.com>
	<s5hvdvs1wig.wl%tiwai@suse.de>	<5501535d0810220824o6b8bf427qd2c806783ec1e56f@mail.gmail.com>	<s5h4p34mz0j.wl%tiwai@suse.de>	<5501535d0810220907p2102afc2t13e47ff5309c01bc@mail.gmail.com>	<5501535d0810220924w66341ac6u4d4de4ed87243a7@mail.gmail.com>	<48FF7E17.9080601@gmail.com>
	<s5h4p3350o4.wl%tiwai@suse.de>	<5501535d0810230446j52de12aes885d066ea38cb240@mail.gmail.com>	<4900659E.90809@jasonline.co.uk>
	<s5hbpxb8lfe.wl%tiwai@suse.de>	<490071DC.6070607@jasonline.co.uk>
	<s5habcv5mu0.wl%tiwai@suse.de>	<490088DC.7090205@jasonline.co.uk>
	<s5hzlkv44v7.wl%tiwai@suse.de> <s5hwsfz44i9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from homer.jasonline.co.uk (78-86-168-217.zone2.bethere.co.uk
	[78.86.168.217])
	by alsa0.perex.cz (Postfix) with ESMTP id ABAE7103881
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Oct 2008 17:37:17 +0200 (CEST)
In-Reply-To: <s5hwsfz44i9.wl%tiwai@suse.de>
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

Takashi Iwai wrote:
>
> Another patch to try is the one like below (on the top of the latest
> code).  Any change with this?
>   
Having trouble with 23 Oct unstable snapshot.
Sorry, I might be doing something wrong!

Your patch applies cleanly but build fails on emu10k1.
./configure --with-cards=sbxfi still get error...

Regards, Jason

make[3]: Entering directory 
`/root/alsa-driver-unstable/pci/emu10k1'                                        

make[3]: Warning: File 
`/root/alsa-driver-unstable/alsa-kernel/pci/emu10k1/Makefile' has 
modification time 5.5e+03 s in the 
future                                                                                      

copying file 
alsa-kernel/pci/emu10k1/emu10k1_main.c                                                         

patching file 
emu10k1_main.c                                                                                

Hunk #3 FAILED at 
673.                                                                                      

Hunk #4 succeeded at 1410 (offset 2 
lines).                                                                
Hunk #6 succeeded at 1764 with fuzz 1 (offset 3 
lines).                                                    
1 out of 6 hunks FAILED -- saving rejects to file 
emu10k1_main.c.rej                                       
make[3]: *** [emu10k1_main.c] Error 
1                                                                      
make[3]: Leaving directory 
`/root/alsa-driver-unstable/pci/emu10k1'                                         

make[2]: *** [prepare] Error 
1                                                                              

make[2]: Leaving directory 
`/root/alsa-driver-unstable/pci'                                                 

make[1]: *** [dep] Error 
1                                                                                  

make[1]: Leaving directory 
`/root/alsa-driver-unstable'                                                     

make: *** [include/sndversions.h] Error 2
