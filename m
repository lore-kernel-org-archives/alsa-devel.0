From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002103]: Sound goes off when adjusting
	volume from alsa-mixer
Date: Wed, 21 Jun 2006 12:15:32 +0200
Message-ID: <50f9c08ada0a8452a3abda641907d5ba@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3518D18B
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jun 2006 12:15:32 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2103> 
======================================================================
Reported By:                raddy
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2103
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Suse
Kernel Version:             2.6.13-15
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-08-2006 11:28 CEST
Last Modified:              06-21-2006 12:15 CEST
======================================================================
Summary:                    Sound goes off when adjusting volume from alsa-mixer
Description: 
i have an Asus P5RD2-VM motherboard equipped with Uli M5461 integrated 
sound card supporting HD-Audio,
it uses snd_hda_intel driver,
it was detected fine,
Alsa played a test sound that itself produced no sound from speakers,
sound is going off in many curcomstance,
they are,
1 > when adjusting volume,
2 > switching to several songs intermittently.

======================================================================

----------------------------------------------------------------------
 mariourk - 06-21-06 09:23 
----------------------------------------------------------------------
- the HD-audio codec chip is AD1986A
- the product name of mobo is 'Asus P5GPL-X SE' (assembled machine)
- the model option i used "3stack"
- lspci output for class 0403 follows,

0403: 8086:2668 (rev 04)
Subsystem: 1043:81b3
Flags: bus master, fast devsel, latency 0, IRQ 16
Memory at cddf8000 (64-bit, non-prefetchable) [size=16K]
Capabilities: [50] Power Management version 2
Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
Capabilities: [70] Express Unknown type IRQ 0
Capabilities: [100] Virtual Channel
Capabilities: [130] Unknown (5)

----------------------------------------------------------------------
 tiwai - 06-21-06 12:15 
----------------------------------------------------------------------
Thanks, fixed on HG.  3stack model is chosen automatically for your devices
now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-08-06 11:28 raddy          New Issue                                    
05-08-06 11:28 raddy          Distribution              => Suse            
05-08-06 11:28 raddy          Kernel Version            => 2.6.13-15       
05-10-06 07:54 raddy          Issue Monitored: raddy                       
05-12-06 10:42 UMMO           Note Added: 0009774                          
05-12-06 10:43 UMMO           Issue Monitored: UMMO                        
05-12-06 16:04 tiwai          Note Added: 0009776                          
05-12-06 17:09 UMMO           Note Added: 0009781                          
05-12-06 17:13 UMMO           Note Edited: 0009781                         
05-23-06 16:21 shadoweel      Issue Monitored: shadoweel                    
06-18-06 09:26 raddy          Note Added: 0010296                          
06-19-06 16:53 mariourk       Note Added: 0010317                          
06-19-06 19:07 tiwai          Note Added: 0010318                          
06-19-06 20:05 mariourk       Note Added: 0010319                          
06-20-06 19:44 tiwai          Note Added: 0010344                          
06-21-06 07:28 raddy          Note Added: 0010383                          
06-21-06 09:23 mariourk       Note Added: 0010386                          
06-21-06 12:15 tiwai          Status                   assigned => resolved
06-21-06 12:15 tiwai          Resolution               open => fixed       
06-21-06 12:15 tiwai          Note Added: 0010395                          
======================================================================
