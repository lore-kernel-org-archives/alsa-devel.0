From: "kreuzritter2000@gmx.de" <kreuzritter2000@gmx.de>
Subject: Re: EWS64XL: cs4232 alsa driver is no more workingwith Alsa 0.9.0beta12 and Sam9407 driver , Alsa0.5.x worked fine
Date: Fri, 8 Mar 2002 23:19:24 +0100
Message-ID: <200203082216.XAA00992@alsa.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id XAA00992
	for <alsa-devel@alsa-project.org>; Fri, 8 Mar 2002 23:16:44 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello


Ok, now i tried the CS4236 driver,
but i get still the same errors.


I think its a bug, something is really messed up.
I also tried the old ALSA 0.5.x drivers again but i get the same errors now.
It must have something to do with the upgrade from Kernel  2.4.9 to 2.4.18, 
because now, no version from ALSA works anymore, no ALSA 0.9.x and no ALSA 
0.5.x

As i said in the mail before ALSA 0.5.x worked with Kernel 2.4.9.


These are the messages i get when trying to load the modules when using the 
newest ALSA 0.9.x version.


-----------------------------------
$ modprobe snd-cs4236
/lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4236.o: init_module: No 
such device
/lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4236.o: Hint: insmod errors 
can be caused by incorrect module parameters, including invalid IO or IRQ 
parameters
/lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4236.o: insmod 
/lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4236.o failed
/lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4236.o: insmod snd-cs4236 
failed



--------------------------------
$ insmod snd-cs4236
Using /lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4236.o
/lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4236.o: unresolved symbol 
snd_cs4236_create_R8f80cf2a
/lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4236.o: unresolved symbol 
snd_cs4236_mixer_R1da3cb4a
/lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4236.o: unresolved symbol 
snd_cs4231_timer_Rd7b3a479
/lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4236.o: unresolved symbol 
snd_opl3_create_R7cfd1ec5
/lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4236.o: unresolved symbol 
snd_opl3_hwdep_new_R0cd48230
/lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4236.o: unresolved symbol 
snd_cs4236_pcm_Rf5217338
/lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4236.o: unresolved symbol 
snd_mpu401_uart_new_R606a10b8
-----------------------------------
 $ modprobe snd-cs4232
/lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4232.o: init_module: No 
such device
/lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4232.o: Hint: insmod errors 
can be caused by incorrect module parameters, including invalid IO or IRQ 
parameters
/lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4232.o: insmod 
/lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4232.o failed
/lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4232.o: insmod snd-cs4232 
failed


----------------------------------
$  insmod snd-cs4232
Using /lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4232.o
/lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4232.o: unresolved symbol 
snd_cs4231_timer_Rd7b3a479
/lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4232.o: unresolved symbol 
snd_opl3_create_R7cfd1ec5
/lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4232.o: unresolved symbol 
snd_opl3_hwdep_new_R0cd48230
/lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4232.o: unresolved symbol 
snd_cs4231_mixer_Rb6145477
/lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4232.o: unresolved symbol 
snd_cs4231_pcm_R6e831eea
/lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4232.o: unresolved symbol 
snd_mpu401_uart_new_R606a10b8
/lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4232.o: unresolved symbol 
snd_cs4231_create_R1b369888



Can someone help me with this problem?

Best Regards,
 Oliver C.



_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
