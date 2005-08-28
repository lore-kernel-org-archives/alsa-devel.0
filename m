From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001134]: alsa 1.0.9rc4 + intel 82801FB/.../ = No sound (Benq 52-101)
Date: Sun, 28 Aug 2005 15:28:14 +0200
Message-ID: <6430647eab3d43f445b47be015ecbded@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 31AC022D
	for <alsa-devel@alsa-project.org>; Sun, 28 Aug 2005 15:28:15 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1134> 
======================================================================
Reported By:                liangalei
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1134
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 3
Kernel Version:             2.6.11-1.14
======================================================================
Date Submitted:             05-28-2005 08:49 CEST
Last Modified:              08-28-2005 15:28 CEST
======================================================================
Summary:                    alsa 1.0.9rc4 + intel 82801FB/.../ = No sound (Benq
52-101)
Description: 
My notebook is Benq 52-101, update FC3 to kernel 2.6.11-1.14_FC3

alsamixer report: Card=intel ICH6, chip=Conexant id 3 (Question, Conexant
just support modem's AC-97 or else provide whole sound ? )

alsaconf: can find "Intel Corp 82801FB/.../ ICH6 family AC'97 Audio", and
will contine to "Have a lot fun".

I have ever, update linux kernel from 2.6.9 to 2.6.11(yum update, no
recompiling), and alsa driver from 0.9.0/1.0.8/1.0.9rc3/4.

Recomipling ALsa driver/lib/oss/tools/util.., with drive, ever try 
----- ./configure --with-cards=azx (error: no this card)
----- ./configure ; make; make install (no error report), not run
./snddevices

No sound ! So much days, so much test..... (if i915GM chipset + Conexant
chip...(see below lspci), will be powered by alsa-1.0.9rc4 ? --- if still
not, I will just wait for new alsa-driver.)

thanks
======================================================================

----------------------------------------------------------------------
 liangalei - 06-24-05 03:18 
----------------------------------------------------------------------
thanks for reply. 

I have attach three very long file, see above "attach files".

and here is some simply info, does any more info is needed ? 

[lal@lal ~]$ cat /proc/asound/card0/intel8x0
Intel8x0

Global control        : 0xc0000002
Global status         : 0x00700100
SDM                   : 0x00000008
AC'97 codecs ready    : primary
AC'97 codecs SDIN     : 0 0 0


[lal@lal ~]$ tree /proc/asound/card*
/proc/asound/card0
|-- codec97#0
|   |-- ac97#0-0
|   `-- ac97#0-0+regs
|-- id
|-- intel8x0
|-- oss_mixer
|-- pcm0c
|   |-- info
|   |-- oss
|   `-- sub0
|       |-- hw_params
|       |-- info
|       |-- prealloc
|       |-- status
|       `-- sw_params
|-- pcm0p
|   |-- info
|   |-- oss
|   `-- sub0
|       |-- hw_params
|       |-- info
|       |-- prealloc
|       |-- status
|       `-- sw_params
|-- pcm1c
|   |-- info
|   |-- oss
|   `-- sub0
|       |-- hw_params
|       |-- info
|       |-- prealloc
|       |-- status
|       `-- sw_params
|-- pcm2c
|   |-- info
|   `-- sub0
|       |-- hw_params
|       |-- info
|       |-- prealloc
|       |-- status
|       `-- sw_params
|-- pcm3c
|   |-- info
|   `-- sub0
|       |-- hw_params
|       |-- info
|       |-- prealloc
|       |-- status
|       `-- sw_params
`-- pcm4p
    |-- info
    `-- sub0
        |-- hw_params
        |-- info
        |-- prealloc
        |-- status
        `-- sw_params
/proc/asound/cards [error opening dir]

----------------------------------------------------------------------
 ybar - 08-28-05 15:28 
----------------------------------------------------------------------
i ran alsamixer and set External amplifier to "on" to listen to music
without headphone.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-28-05 08:49 liangalei      New Issue                                    
05-28-05 08:49 liangalei      Distribution              => Fedora Core 3   
05-28-05 08:49 liangalei      Kernel Version            => 2.6.11-1.14     
05-28-05 09:17 liangalei      Note Added: 0004759                          
05-28-05 09:18 liangalei      Issue Monitored: liangalei                    
05-30-05 03:29 liangalei      Note Added: 0004795                          
06-01-05 16:58 tiwai          Note Added: 0004863                          
06-01-05 17:04 tiwai          Category                 0_compilation problem_!!!
=> PCI - intel8x0
06-02-05 10:42 liangalei      Note Added: 0004875                          
06-06-05 09:53 perex          Assigned To              perex =>            
06-23-05 12:42 tiwai          Note Added: 0005182                          
06-24-05 03:12 liangalei      File Added: asound.state                     
06-24-05 03:13 liangalei      File Added: ac97#0-0                         
06-24-05 03:14 liangalei      File Added: ac97#0-0+regs                    
06-24-05 03:18 liangalei      Note Added: 0005202                          
08-28-05 15:28 ybar           Note Added: 0005962                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
