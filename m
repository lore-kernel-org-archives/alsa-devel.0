From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000633]: missing snd_rawmidi_* symbols when loading snd-emu10k1x module
Date: Mon, 8 Nov 2004 09:47:25 +0100
Message-ID: <64c34a133e7ca607d0524dc630777f2e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CE5E9289
	for <alsa-devel@alsa-project.org>; Mon,  8 Nov 2004 09:47:25 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=633> 
======================================================================
Reported By:                xbertje
Assigned To:                fmoraes
======================================================================
Project:                    ALSA - driver
Issue ID:                   633
Category:                   PCI - emu10k1x
Reproducibility:            have not tried
Severity:                   crash
Priority:                   normal
Status:                     resolved
Distribution:               Fedora Core 2
Kernel Version:             2.6.8-1.521
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-07-2004 21:16 CET
Last Modified:              11-08-2004 09:47 CET
======================================================================
Summary:                    missing snd_rawmidi_* symbols when loading
snd-emu10k1x module
Description: 
When compiling the 1.0.7rc2 drivers on a Fedora Core 2
(kernel version 2.6.8-1.521) with the following commands:
./configure --with-cards=emu10k1x
make
make install

modprobe snd-emu10k1x
results in several warning concerning snd_rawmidi_:
dmesg output yields
snd_emu10k1x: Unknown symbol snd_rawmidi_receive
snd_emu10k1x: Unknown symbol snd_rawmidi_transmit
snd_emu10k1x: Unknown symbol snd_rawmidi_new
snd_emu10k1x: Unknown symbol snd_rawmidi_set_ops

It seems that in the configure file a line like
CONFIG_SND_RAWMIDI="m"
for "$card" = "emu10k1x" (line 8566) is missing,
If I insert the line above in the configure file
and reconfigure and recompile everything the errors
disappear.

======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 11-08-04 09:47 
----------------------------------------------------------------------
Already fixed in CVS
(<http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-driver/pci/Kconfig?r1=1.25&r2=1.26&diff_format=u>).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-07-04 21:16 xbertje        New Issue                                    
11-07-04 21:16 xbertje        Distribution              => Fedora Core 2   
11-07-04 21:16 xbertje        Kernel Version            => 2.6.8-1.521     
11-08-04 09:47 Clemens LadischStatus                   assigned => resolved
11-08-04 09:47 Clemens LadischResolution               open => fixed       
11-08-04 09:47 Clemens LadischNote Added: 0002311                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
