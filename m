From: Thomas Petersen <mendocino@mendocino.mine.nu>
Subject: Re: CS4236 problems
Date: Mon, 13 May 2002 18:37:06 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CDFEBB2.1030004@mendocino.mine.nu>
References: <3CDAAA8C.8040907@mendocino.mine.nu> <s5hn0v48ij4.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from server.mendocino.mine.nu (213.237.107.108.adsl.od.worldonline.dk [213.237.107.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id SAA09354
	for <alsa-devel@alsa-project.org>; Mon, 13 May 2002 18:37:49 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:


>>I'm having lots of problems getting the cs4236 driver to work. I started 
>>out with the 0.9.0rc1 package. The snd-cs4236.o module wouldn't load. It 
>>just resulted in a message like "kernel: CS4236+ soundcard not found or 
>>device busy" in the system log.
>>Then i found out that the cs4236 driver was missing the pnp id of my 
>>card. I gathered the information from /proc/isapnp and added the line:
>>ISAPNP_CS4232('C','S','C',0xe936,0x0000,0x0010,0x0003),
>>to the list of pnpids in cs4236.c


>>Now the module could load, and I could even play some music... problem 
>>was now, that the sound wasn't audible. I turned up the volume for all 
>>channels in alsamixer and that actually made a difference. Now i could 
>>hear the music but extremely low. It is like the output is muted or 
>>something needs to be turned up. Also in a program like "kmix" the 
>>master volume is missing... strange.

I have solved the problem about missing audio by just unmuting "Master 
Digital" :-)  I didn't know there was a muting function in alsamixer 
until i saw it mentioned in another mail on this list and i didn't need 
to unmute any channels on my other soundcard.
There is still no master volume in kmix (and probably other oss sound 
mixers) however.
>>Today i have tried with a cvs snapshot from 8th may. To get the module 
>>to load i did the same as before but i additionally had to uncomment the 
>>lines:
>>if (ver1 != ver2) {
>>     snd_printk("CS4236+ chip detected, but control port 0x%lx is not
>>  valid\n", cport);
>>     snd_device_free(card, chip);
>>     return -ENODEV;
>>}
>>in cs4236_lib.c. Otherwise it would just always give that message in the 
>>log when loading the module. I now have the same result as before.
> 
> 
> hmm...  did rc1 work without this change?
> then i may have brought a bug in the code...

I have found out that the cs4236_lib.c file did not change between rc1 
and the cvs snapshot. It only happens sometimes that the module won't 
load because ver1 != ver2. When I loaded the module the first time today 
they were both 0, but after unloading it and loading it again ver1 was 0 
and ver2 was 191.
I don't know exactly when this problem appears. I will watch it a bit 
the next days and see if for instance the problems only occurs when 
reloading the module.

>>I can supply more information on request like contents of /proc/isapnp 
>>and stuff like that. Just ask!
> yes, could you attach the output of /proc/isapnp to make a patch?

/proc/isapnp:
Card 1 'CSCe936:CRD4236-1' PnP version 1.0 Product version 0.1
   Logical device 0 'CSC0000:WSS/SB'
     Device is active
     Active port 0x534,0x388,0x220
     Active IRQ 5 [0x2]
     Active DMA 1,3
     Resources 0
       Priority preferred
       Port 0x534-0x534, align 0x3, size 0x4, 16-bit address decoding
       Port 0x388-0x388, align 0x7, size 0x4, 16-bit address decoding
       Port 0x220-0x220, align 0x1f, size 0x10, 16-bit address decoding
       IRQ 5 High-Edge
       DMA 1 8-bit byte-count compatible
       DMA 0,3 8-bit byte-count compatible
       Alternate resources 0:1
         Priority acceptable
         Port 0x534-0x608, align 0xd3, size 0x4, 16-bit address decoding
         Port 0x388-0x388, align 0x7, size 0x4, 16-bit address decoding
         Port 0x220-0x260, align 0x1f, size 0x10, 16-bit address decoding
         IRQ 5,7,2/9,11,12,15 High-Edge
         DMA 1,3 8-bit byte-count compatible
         DMA 0,1,3 8-bit byte-count compatible
       Alternate resources 0:2
         Priority functional
         Port 0x534-0xffc, align 0x3, size 0x4, 16-bit address decoding
         Port 0x388-0x3f8, align 0x7, size 0x4, 16-bit address decoding
         Port 0x220-0x2e0, align 0x1f, size 0x10, 16-bit address decoding
         IRQ 5,7,2/9,11,12,15 High-Edge
         DMA 0,1,3 8-bit byte-count compatible
   Logical device 1 'CSC0001:GAME'
     Device is not active
     Resources 0
       Priority preferred
       Port 0x200-0x200, align 0x7, size 0x8, 16-bit address decoding
       Alternate resources 0:1
         Priority acceptable
         Port 0x208-0x208, align 0x7, size 0x8, 16-bit address decoding
   Logical device 2 'CSC0010:CTRL'
     Device is active
     Active port 0x110
     Resources 0
       Priority preferred
       Port 0x110-0x3f8, align 0x7, size 0x8, 16-bit address decoding
   Logical device 3 'CSC0003:MPU'
     Device is active
     Active port 0x330
     Active IRQ 9 [0x2]
     Resources 0
       Priority preferred
       Port 0x330-0x330, align 0x7, size 0x2, 16-bit address decoding
       IRQ 2/9 High-Edge
       Alternate resources 0:1
         Priority acceptable
         Port 0x330-0x360, align 0x7, size 0x2, 16-bit address decoding
         IRQ 2/9,11,12,15 High-Edge
       Alternate resources 0:2
         Priority functional
         Port 0x330-0x3e0, align 0x7, size 0x2, 16-bit address decoding

Patches:
*** cs4236.c.original   Wed May  8 11:56:15 2002
--- cs4236.c    Mon May 13 18:10:28 2002
***************
*** 264,269 ****
--- 264,271 ----
         ISAPNP_CS4232('C','S','C',0xf235,0x0000,0x0010,0x0003),
         /* CS4236B */
         ISAPNP_CS4232('C','S','C',0xf238,0x0000,0x0010,0x0003),
+       /* Some noname CS4236 based card */
+       ISAPNP_CS4232('C','S','C',0xe936,0x0000,0x0010,0x0003),
         /* --- */
         { ISAPNP_CARD_END, }    /* end */
   };


*** cs4236_lib.c.original       Thu Feb 14 18:40:32 2002
--- cs4236_lib.c        Mon May 13 18:07:06 2002
***************
*** 297,307 ****
         ver1 = snd_cs4236_ctrl_in(chip, 1);
         ver2 = snd_cs4236_ext_in(chip, CS4236_VERSION);
         snd_printdd("CS4236: [0x%lx] C1 (version) = 0x%x, ext = 
0x%x\n", cport, ver1, ver2);
!       if (ver1 != ver2) {
                 snd_printk("CS4236+ chip detected, but control port 
0x%lx is not valid\n", cport);
                 snd_device_free(card, chip);
                 return -ENODEV;
!       }
         snd_cs4236_ctrl_out(chip, 0, 0x00);
         snd_cs4236_ctrl_out(chip, 2, 0xff);
         snd_cs4236_ctrl_out(chip, 3, 0x00);
--- 297,308 ----
         ver1 = snd_cs4236_ctrl_in(chip, 1);
         ver2 = snd_cs4236_ext_in(chip, CS4236_VERSION);
         snd_printdd("CS4236: [0x%lx] C1 (version) = 0x%x, ext = 
0x%x\n", cport, ver1, ver2);
!       snd_printk("TEST: ver1=%u  ver2=%u\n", ver1, ver2);
!       /* if (ver1 != ver2) {
                 snd_printk("CS4236+ chip detected, but control port 
0x%lx is not valid\n", cport);
                 snd_device_free(card, chip);
                 return -ENODEV;
!       } */
         snd_cs4236_ctrl_out(chip, 0, 0x00);
         snd_cs4236_ctrl_out(chip, 2, 0xff);
         snd_cs4236_ctrl_out(chip, 3, 0x00);




Thomas Petersen


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
