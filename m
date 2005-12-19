From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001626]: Kernel panic on use of hardware MIDI synth
Date: Mon, 19 Dec 2005 12:28:03 +0100
Message-ID: <e2668e9f5639e7800b456c952d4ac130@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CC290170
	for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2005 12:28:03 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1626> 
======================================================================
Reported By:                Twey
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1626
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 4
Kernel Version:             2.6.14-1.1644_FC4
======================================================================
Date Submitted:             12-07-2005 20:56 CET
Last Modified:              12-19-2005 12:28 CET
======================================================================
Summary:                    Kernel panic on use of hardware MIDI synth
Description: 
I've just upgraded to 1.0.10 from Fedora's 1.0.9, and now I have access to
my soundcard's (SB Live! 24-bit) MIDI synth.  However, any attempt to use
it causes a kernel panic, something about a spinlock.  My other MIDI port
(connected to a musical keyboard via a USB adapter) works fine.  Both
snd_mpu401 and snd_mpu401_uart load without problems.  I thought this
error might be related to 1623, so applied the supplied patch, but to no
avail.
======================================================================

----------------------------------------------------------------------
 jcdutton - 12-19-05 12:04 
----------------------------------------------------------------------
I can't make head nor tail of this one.
_spin_lock_irqsave
snd_ca0106_ptr_read
ca0106_midi_read
ca_midi_interrupt
snd_ca0106_ptr_write
snd_ca0106_interrupt

isn't even a valid code path!
ca_midi_interrupt is never called from inside snd_ca0106_ptr_write.
The entry point to any ca0106 interrupt handling routine is via
snd_ca0106_interrupt.

All I can think is that something has gone wrong with the compiling of the
kernel.

----------------------------------------------------------------------
 Twey - 12-19-05 12:28 
----------------------------------------------------------------------
Hm... there's a new kernel released for FC4 now, I'll try that and report
back.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-07-05 20:56 Twey           New Issue                                    
12-07-05 20:56 Twey           Distribution              => Fedora Core 4   
12-07-05 20:56 Twey           Kernel Version            => 2.6.14-1.1644_FC4
12-07-05 20:56 Twey           Issue Monitored: Twey                        
12-07-05 21:18 rlrevell       Note Added: 0006948                          
12-07-05 22:08 Twey           Note Added: 0006950                          
12-07-05 22:25 rlrevell       Note Added: 0006951                          
12-08-05 17:32 Twey           Note Added: 0006961                          
12-08-05 17:32 Twey           Note Edited: 0006961                         
12-17-05 16:51 Twey           Note Added: 0007064                          
12-19-05 09:20 Clemens LadischNote Added: 0007092                          
12-19-05 09:20 Clemens LadischAssigned To               => jcdutton        
12-19-05 09:20 Clemens LadischStatus                   new => assigned     
12-19-05 09:20 Clemens LadischCategory                 GENERIC - mpu401 => PCI -
ca0106
12-19-05 12:04 jcdutton       Note Added: 0007093                          
12-19-05 12:28 Twey           Note Added: 0007094                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
