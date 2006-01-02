From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001593]: au88x0 wt synth
Date: Mon, 2 Jan 2006 09:54:27 +0100
Message-ID: <9bed38266da1129c5ff1aa942fd02d18@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3558C152
	for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2006 09:54:28 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1593> 
======================================================================
Reported By:                Raymond
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   1593
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 1
Kernel Version:             2.4.22-1.2199.nptl
======================================================================
Date Submitted:             11-23-2005 17:16 CET
Last Modified:              01-02-2006 09:54 CET
======================================================================
Summary:                    au88x0 wt synth
Description: 
After applied the patch as described in 

http://article.gmane.org/gmane.linux.alsa.devel/27095

Sound (like a monster roaring) is heard when using aplay through device 3
of au8830 with the mono files from alsa-utils-1.0.10/speaker-test/samples

The sound repeat 7 times and stop.

Refer to the strace, 

Do the DMA transfer occur when using hw:0,3 ?



======================================================================

----------------------------------------------------------------------
 Raymond - 12-21-05 10:10 
----------------------------------------------------------------------
Can anyone explain the usage of the function precise_resolution in
snd_timer_hardware ?

The hardware timer (VORTEX_SMP_TIMER) in au88x0 chips seem to have 48000Hz
resolution and it also has a high-resolution clock ( VORTEX_SMP_TIME )
which is 256x48000 Hz.

----------------------------------------------------------------------
 Raymond - 01-02-06 09:54 
----------------------------------------------------------------------
How should the synth driver allocate memory for the 5 MBytes samples (DMA
controller can access 32-bits address space only) ?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-23-05 17:16 Raymond        New Issue                                    
11-23-05 17:16 Raymond        Distribution              => Fedora Core 1   
11-23-05 17:16 Raymond        Kernel Version            => 2.4.22-1.2199.nptl
11-23-05 20:54 mjander        Note Added: 0006832                          
11-25-05 07:57 Raymond        Note Added: 0006847                          
11-30-05 08:48 Raymond        Note Added: 0006875                          
12-11-05 13:21 Raymond        Note Added: 0006976                          
12-21-05 10:10 Raymond        Note Added: 0007108                          
01-02-06 09:06 Raymond        Note Deleted: 0006976                        
01-02-06 09:54 Raymond        Note Added: 0007369                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
