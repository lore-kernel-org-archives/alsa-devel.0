From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000971]: Compilation Errors - Cannot find specific files during compilation
Date: Wed, 9 Mar 2005 03:32:51 +0100
Message-ID: <054a84acd1c45183187a0068cc157068@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 14115174
	for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2005 03:32:51 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=971> 
======================================================================
Reported By:                rbechard1
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   971
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             03-08-2005 01:50 CET
Last Modified:              03-09-2005 03:32 CET
======================================================================
Summary:                    Compilation Errors - Cannot find specific files
during compilation
Description: 
When installing the application using the method described in this link:

http://www.alsa-project.org/alsa-doc/doc-php/template.php?company=Creative+Labs&card=Sound+Blaster+PCI+X+%28Dell+OEM%29.&chip=SB0200&module=emu10k1x

I get error messages during the compilation, yet the process tells me it
has completed successfully. When I go to configure my sound card it has
the correct driver loaded but yet there is no sound. When I checked the
mixer settings nothing is muted. 

There is no option within the sound configuration panel to switch to the
correct driver.
======================================================================

----------------------------------------------------------------------
 fmoraes - 03-09-05 02:10 
----------------------------------------------------------------------
What compilation errors do you receive? Are they on the emu10k1x module or
on other parts of ALSA? Also, the module is not loaded above, so you will
get no sound.

Also, what Linux are you using?

Francisco

----------------------------------------------------------------------
 rbechard1 - 03-09-05 03:32 
----------------------------------------------------------------------
Reply to your questions:

What compilation errors do you receive?

Here are partial outputs from the various compilations:

    Driver ALSA 1.08 is below:


make[4]: Nothing to be done for `install-exec-am'.
 /bin/sh ../../../mkinstalldirs /usr/share/alsa/cards/SI7018
  /usr/bin/install -c -m 644 ./SI7018/sndoc-mixer.alisp
/usr/share/alsa/cards/SI7018/SI7018/sndoc-mixer.alisp
 /usr/bin/install: cannot create regular file
`/usr/share/alsa/cards/SI7018/SI7018/sndoc-mixer.alisp': No such file or
directory
  /usr/bin/install -c -m 644 ./SI7018/sndop-mixer.alisp
/usr/share/alsa/cards/SI7018/SI7018/sndop-mixer.alisp
 /usr/bin/install: cannot create regular file
`/usr/share/alsa/cards/SI7018/SI7018/sndop-mixer.alisp': No such file or
directory
 make[4]: *** [install-SI7018DATA] Error 1
 make[4]: Leaving directory `/usr/src/alsa/alsa-lib-1.0.8/src/conf/cards'
 make[3]: *** [install-am] Error 2
 make[3]: Leaving directory `/usr/src/alsa/alsa-lib-1.0.8/src/conf/cards'
 make[2]: *** [install-recursive] Error 1
 make[2]: Leaving directory `/usr/src/alsa/alsa-lib-1.0.8/src/conf'
 make[1]: *** [install-recursive] Error 1
 make[1]: Leaving directory `/usr/src/alsa/alsa-lib-1.0.8/src'
 make: *** [install-recursive] Error 1

Are they on the emu10k1x module or on other parts of ALSA?

I dont know. I am new to Linux. The entire script output and everything I
entered is located under the "steps to reproduce" subsection of this
form.


Error when trying to add files to the kernal is below:


modprobe snd-emu10k1x;modprobe snd-pcm-oss;modprobe snd-mixer-oss;modprobe
snd-seq-oss
 WARNING: Error inserting snd-timer
(/lib/modules/2.6.3-7mdk/kernel/sound/acore/snd-timer.ko): Unknown symbol
in module, or unknown parameter (see dmesg)
 WARNING: Error inserting snd-pcm
(/lib/modules/2.6.3-7mdk/kernel/sound/acore/snd-pcm.ko): Unknown symbol in
module, or unknown parameter (see dmesg)
 WARNING: Error inserting snd-seq-device
(/lib/modules/2.6.3-7mdk/kernel/sound/acore/seq/snd-seq-device.ko):
Unknown symbol in module, or unknown parameter (see dmesg)
 WARNING: Error inserting snd-rawmidi
(/lib/modules/2.6.3-7mdk/kernel/sound/acore/snd-rawmidi.ko): Unknown
symbol in module, or unknown parameter (see dmesg)
 WARNING: Error inserting snd-timer
(/lib/modules/2.6.3-7mdk/kernel/sound/acore/snd-timer.ko): Unknown symbol
in module, or unknown parameter (see dmesg)
 WARNING: Error inserting snd-pcm
(/lib/modules/2.6.3-7mdk/kernel/sound/acore/snd-pcm.ko): Unknown symbol in
module, or unknown parameter (see dmesg)
 WARNING: Error inserting snd-seq-device
(/lib/modules/2.6.3-7mdk/kernel/sound/acore/seq/snd-seq-device.ko):
Unknown symbol in module, or unknown parameter (see dmesg)
 WARNING: Error inserting snd-rawmidi
(/lib/modules/2.6.3-7mdk/kernel/sound/acore/snd-rawmidi.ko): Unknown
symbol in module, or unknown parameter (see dmesg)
 FATAL: Error inserting snd-emu10k1x
(/lib/modules/2.6.3-7mdk/kernel/sound/pci/emu10k1/snd-emu10k1x.ko):
Unknown symbol in module, or unknown parameter (see dmesg)
 FATAL: Error running install command for snd-emu10k1x
 WARNING: Error inserting snd-mixer-oss
(/lib/modules/2.6.3-7mdk/kernel/sound/acore/oss/snd-mixer-oss.ko): Unknown
symbol in module, or unknown parameter (see dmesg)
 WARNING: Error inserting snd-timer
(/lib/modules/2.6.3-7mdk/kernel/sound/acore/snd-timer.ko): Unknown symbol
in module, or unknown parameter (see dmesg)
 WARNING: Error inserting snd-pcm
(/lib/modules/2.6.3-7mdk/kernel/sound/acore/snd-pcm.ko): Unknown symbol in
module, or unknown parameter (see dmesg)
 FATAL: Error inserting snd-pcm-oss
(/lib/modules/2.6.3-7mdk/kernel/sound/acore/oss/snd-pcm-oss.ko): Unknown
symbol in module, or unknown parameter (see dmesg)
 FATAL: Error inserting snd-mixer-oss
(/lib/modules/2.6.3-7mdk/kernel/sound/acore/oss/snd-mixer-oss.ko): Unknown
symbol in module, or unknown parameter (see dmesg)
 WARNING: Error inserting snd-seq-device
(/lib/modules/2.6.3-7mdk/kernel/sound/acore/seq/snd-seq-device.ko):
Unknown symbol in module, or unknown parameter (see dmesg)
 WARNING: Error inserting snd-timer
(/lib/modules/2.6.3-7mdk/kernel/sound/acore/snd-timer.ko): Unknown symbol
in module, or unknown parameter (see dmesg)
 WARNING: Error inserting snd-seq
(/lib/modules/2.6.3-7mdk/kernel/sound/acore/seq/snd-seq.ko): Unknown
symbol in module, or unknown parameter (see dmesg)
 WARNING: Error inserting snd-seq-midi-event
(/lib/modules/2.6.3-7mdk/kernel/sound/acore/seq/snd-seq-midi-event.ko):
Unknown symbol in module, or unknown parameter (see dmesg)
 FATAL: Error inserting snd-seq-oss
(/lib/modules/2.6.3-7mdk/kernel/sound/acore/seq/oss/snd-seq-oss.ko):
Unknown symbol in module, or unknown parameter (see dmesg)
 
Please explain your statement below as I dont understand. The ALSA program
1.0.8 now loads correctly during boot process but the sound mixer portion
fails every time.

 "Also, the module is not loaded above, so you will get no sound."

Also, what Linux are you using?

Mandrake 10 with Kernel linux-2.6.3-7mdk 


Thankyou for your help

ROb :-)


 Also, the module is not loaded above, so you will get no sound.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-08-05 01:50 rbechard1      New Issue                                    
03-08-05 01:51 rbechard1      Issue Monitored: rbechard1                    
03-08-05 09:52 rbechard1      Note Added: 0003812                          
03-09-05 02:10 fmoraes        Note Added: 0003819                          
03-09-05 03:32 rbechard1      Note Added: 0003825                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
