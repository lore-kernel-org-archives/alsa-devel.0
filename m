From: kreuzritter2000@gmx.de
Subject: Major Bug in Alsa 0.9  for over 1 year
Date: Fri, 25 Oct 2002 06:02:58 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <22050.1035518578@www52.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

I allways have the same bug when trying to modprobe the cs4232 or cs4236
sounddriver for my Terratec EWS654XL soundcard.

The bug is called unresolved symbol, this bug exists in ALSA 0.9 since the
existing of ALSA 0.9.

I tried nearly every ALSA 0.9x version.

Alsa 0.9.0  -> didn't work
Alsa 0.9.0beta1 -> didn't work
Alsa 0.9.0beta2 -> didn't work
Alsa 0.9.0beta3 -> didn't work
....
Alsa 0.9.0beta9 -> didn't work
Alsa 0.9.0beta10 -> didn't work
Alsa 0.9.0rc1 -> didn't work
Alsa 0.9.0rc2 -> "
Alsa 0.9.0rc3 -> "
Alsa 0.9.0rc5 -> "

I wrote nearly for every ALSA  version a bugreport including
a lot of pnpdumps, module.conf, dmesg output files etc. etc. but no one
could help me and fix this problem.
I am really fed up with this.

I can't write a driver myself, the only thing i can do for the alsa-project
is 
writing bug reports, i can't fix this bug, but you can, so it's up to you.

The soundcard "worked" fine with the old ALSA 0.5x drivers,
the soundcard and its two chips the cs4232/cs4236 and the sam9407
are well documented, sources, documentations it's all there.
So fixing this bug is not impossible!
But still, this bug was never fixed.

No, this time i won't sent plenty of pnpdump files, module.confs files etc.
to you.  If you need my pnpdump files, you will find many in the alsa-devel
mailinglist archives of it. (search for EWS64)
It never helped, and it won't help in future.
 
I am giving up, i am frustrated and this was my last bug report
to the alsa-mailinglist.

Perhaps i will stick with only one chip of my soundcard (the sam9407) and
use this great sam9407 OSS driver or buy a new soundcard -> problem solved.

I really tried everthing.
Every option, nothing did help.

Perhaps no one tried to go the steps i did step by step, like
installing Slackware (my main distribution), upgrading the kernel and
checking if the cs4232/6 drivers work on Slackware without this unresolved symbols.


There are 2 or 3 people on this mailinglist that have the same soundcard,
maybe that one could send me their modules.conf file and step by step
installation guide, that would be the last try, i could do that.
But i am not continuing this writing bug reports and  seeing no progress.
  
So that's the end.

Best Regards 
 Oliver C.


Here's the unsresolved symbol error:

modprobe snd-cs4232
/lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4232.o: init_module: No
such device
/lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4232.o: Hint: insmod
errors can be caused by incorrect module parameters, including invalid IO or IRQ
parameters.
      You may find more information in syslog or the output from dmesg
/lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4232.o: insmod
/lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4232.o failed
/lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4232.o: insmod snd-cs4232
failed


insmod snd-cs4232
Using /lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4232.o
/lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4232.o: unresolved symbol
snd_card_new_R506deba1
/lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4232.o: unresolved symbol
snd_card_free_Rff997e04
/lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4232.o: unresolved symbol
snd_cs4231_pcm_R75bb3150
/lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4232.o: unresolved symbol
snd_card_register_R4baee9de
/lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4232.o: unresolved symbol
snd_verbose_printk_R49d4e4d1
/lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4232.o: unresolved symbol
snd_opl3_create_R7cfd1ec5
/lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4232.o: unresolved symbol
snd_opl3_hwdep_new_Rd214f5bf
/lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4232.o: unresolved symbol
snd_cs4231_create_Rce85e590
/lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4232.o: unresolved symbol
snd_cs4231_mixer_Re022cecf
/lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4232.o: unresolved symbol
snd_wrapper_kfree
/lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4232.o: unresolved symbol
snd_mpu401_uart_new_R606a10b8
/lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4232.o: unresolved symbol
snd_cs4231_timer_R7a2d8746

insmod snd-cs4236
Using /lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4236.o
/lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4236.o: unresolved symbol
snd_cs4236_create_Racbbd0d2
/lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4236.o: unresolved symbol
snd_card_new_R506deba1
/lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4236.o: unresolved symbol
snd_card_free_Rff997e04
/lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4236.o: unresolved symbol
snd_card_register_R4baee9de
/lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4236.o: unresolved symbol
snd_verbose_printk_R49d4e4d1
/lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4236.o: unresolved symbol
snd_opl3_create_R7cfd1ec5
/lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4236.o: unresolved symbol
snd_cs4236_pcm_R25584f2a
/lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4236.o: unresolved symbol
snd_cs4236_mixer_R248fd9c7
/lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4236.o: unresolved symbol
snd_opl3_hwdep_new_Rd214f5bf
/lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4236.o: unresolved symbol
snd_wrapper_kfree
/lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4236.o: unresolved symbol
snd_mpu401_uart_new_R606a10b8
/lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4236.o: unresolved symbol
snd_cs4231_timer_R7a2d8746


modprobe snd-cs4236
/lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4236.o: init_module: No
such device
/lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4236.o: Hint: insmod
errors can be caused by incorrect module parameters, including invalid IO or IRQ
parameters.
      You may find more information in syslog or the output from dmesg
/lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4236.o: insmod
/lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4236.o failed
/lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4236.o: insmod snd-cs4236
failed



-- 
+++ GMX - Mail, Messaging & more  http://www.gmx.net +++
NEU: Mit GMX ins Internet. Rund um die Uhr für 1 ct/ Min. surfen!



-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0003en
