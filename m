From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002160]: ALi Corporation M5455 PCI AC-Link Controller Audio Device (rev 20)
Date: Fri, 26 May 2006 03:14:32 +0200
Message-ID: <8084ba67f64647893e939b0a7d63cfdd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 67596151
	for <alsa-devel@alsa-project.org>; Fri, 26 May 2006 03:14:32 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2160> 
======================================================================
Reported By:                marciovinicius
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2160
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Ubuntu Dapper Beta 2
Kernel Version:             
======================================================================
Date Submitted:             05-25-2006 22:13 CEST
Last Modified:              05-26-2006 03:14 CEST
======================================================================
Summary:                    ALi Corporation M5455 PCI AC-Link Controller Audio
Device (rev 20)
Description: 
The sound card "ALi Corporation M5455 PCI AC-Link Controller Audio Device
(rev 20)" which cames onboard "Asus k8u-x" motherboard simply doesn´t
work. It is recognized by the system but doesn't work.
======================================================================

----------------------------------------------------------------------
 marciovinicius - 05-26-06 03:00 
----------------------------------------------------------------------
ALSA Audio Debug v0.1.0 - Qui Mai 25 21:58:04 BRT 2006
http://alsa.opensrc.org/index.php?page=aadebug
http://www.gnu.org/licenses/gpl.txt

Kernel ----------------------------------------------------
Linux ubuntu 2.6.15-23-amd64-generic #1 SMP PREEMPT Tue May 23 13:45:47
UTC 2006 x86_64 GNU/Linux

Loaded Modules --------------------------------------------
snd_intel8x0           38440  0
snd_ac97_codec        110268  1 snd_intel8x0
snd_ac97_bus            4096  1 snd_ac97_codec
snd_pcm_oss            59424  0
snd_mixer_oss          20608  1 snd_pcm_oss
snd_pcm               104712  3 snd_intel8x0,snd_ac97_codec,snd_pcm_oss
snd_timer              29064  1 snd_pcm
snd                    68576  6
snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
snd_page_alloc         13968  2 snd_intel8x0,snd_pcm

Modprobe Conf ---------------------------------------------
Warning: module config file does not exist
This means any kernel modules will not be auto loaded
See your linux distro docs on how to create this file

Proc Asound -----------------------------------------------
Advanced Linux Sound Architecture Driver Version 1.0.10rc3 (Mon Nov 07
13:30:21 2005 UTC).
--- no soundcards ---
 33:       : timer
cat: /proc/asound/hwdep: Arquivo ou diretório n&#227;o encontrado
cat: /proc/asound/seq/clients: Arquivo ou diretório n&#227;o encontrado

Dev Snd ---------------------------------------------------
timer

CPU -------------------------------------------------------
model name      : AMD Athlon(tm) 64 Processor 3000+
cpu MHz         : 1999.965

RAM -------------------------------------------------------
MemTotal:       512052 kB
SwapTotal:      497972 kB

Hardware --------------------------------------------------
0000:00:00.0 Host bridge: ALi Corporation M1689 K8 Northbridge [Super K8
Single Chip]
0000:00:04.0 Multimedia audio controller: ALi Corporation M5455 PCI
AC-Link Controller Audio Device (rev 20)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control

----------------------------------------------------------------------
 marciovinicius - 05-26-06 03:14 
----------------------------------------------------------------------
If you see the links I posted you'll see that it happens at least with
Debian and Fedora too (not only with Ubuntu). It likely refers to the
AMD64 version of the kernel, but I think it is an ALSA issue too.
As a matter of fact the kernel version is 2.6.15-23-amd64-generic (as you
can see in aadebug report). I couldn't write at the time when I made the
report and I don't know how to change the report (I don't know if I can do
it). Actually I'd like to change the severity of the report to major too -
I don't have sound! :(

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-25-06 22:13 marciovinicius New Issue                                    
05-25-06 22:13 marciovinicius Distribution              => Ubuntu Dapper Beta 2
05-25-06 22:26 rlrevell       Note Added: 0009965                          
05-25-06 22:38 marciovinicius Note Added: 0009966                          
05-25-06 22:56 rlrevell       Note Added: 0009968                          
05-26-06 03:00 marciovinicius Note Added: 0009971                          
05-26-06 03:14 marciovinicius Note Added: 0009972                          
======================================================================




-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
