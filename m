From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000848]: Intel HDA (C-Media 9880) SPDIF Out
Date: Fri, 4 Feb 2005 19:41:51 +0100
Message-ID: <e89e8917acb48f42c120b82d99fd0940@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E39C222F
	for <alsa-devel@alsa-project.org>; Fri,  4 Feb 2005 19:41:51 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=848> 
======================================================================
Reported By:                1g0R
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   848
Category:                   PCI - azx
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 3
Kernel Version:             2.6.8-ac8
======================================================================
Date Submitted:             01-25-2005 15:28 CET
Last Modified:              02-04-2005 19:41 CET
======================================================================
Summary:                    Intel HDA (C-Media 9880) SPDIF Out
Description: 
When i set in modprobe.conf the options snd-xxx model=full_dig, there is no
output signal on SPDIF (Coax).
I try:
aplay -D hw:0,1 (<--digital out) else.wav
the command run normally, but no output on spdif out.the same with xmms
(with ALSA, on hw:0,1).

======================================================================

----------------------------------------------------------------------
 1g0R - 02-04-05 19:36 
----------------------------------------------------------------------
[igor@skynet cmi9880]$ iecset
Mode: professional
Data: audio
Rate: unknown
Rate Locked: yes
Emphasis: unknown
Stereophonic: not indicated
Userbits: unkown
Sample Bits: unknown
Word Length: unknown
[igor@skynet cmi9880]$    

[igor@skynet cmi9880]$ aplay -D iec958 Surround-SDL-testfiles/chan-id.wav
Playing WAVE 'Surround-SDL-testfiles/chan-id.wav' : Signed 16 bit Little
Endian, Rate 44100 Hz, Channels 6
Warning: rate is not accurate (requested = 44100Hz, got = 48000Hz)
         please, try the plug plugin (-Dplug:iec958)
[igor@skynet cmi9880]$

[igor@skynet cmi9880]$ aplay -Dplug:iec958
Surround-SDL-testfiles/chan-id.wav
Playing WAVE 'Surround-SDL-testfiles/chan-id.wav' : Signed 16 bit Little
Endian, Rate 44100 Hz, Channels 6
[igor@skynet cmi9880]$


but i cant hear anything from speakers

----------------------------------------------------------------------
 tiwai - 02-04-05 19:41 
----------------------------------------------------------------------
As I wrote, try to set up the SPDIF status bits properly via iecset before
running aplay.

Why do you play 6-channel wav file?  SPDIF supports only 2 channels.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-25-05 15:28 1g0R           New Issue                                    
01-25-05 15:28 1g0R           Distribution              => Fedora Core 3   
01-25-05 15:28 1g0R           Kernel Version            => 2.6.8-ac8       
01-25-05 18:04 jbrsubscribe   Note Added: 0003408                          
01-25-05 18:05 jbrsubscribe   Issue Monitored: jbrsubscribe                    
01-25-05 18:14 jbrsubscribe   Note Added: 0003409                          
01-28-05 02:56 nc             Issue Monitored: nc                          
01-28-05 03:07 nc             Note Added: 0003423                          
01-28-05 19:01 1g0R           Note Added: 0003434                          
02-04-05 15:02 tiwai          Note Added: 0003507                          
02-04-05 19:36 1g0R           Note Added: 0003514                          
02-04-05 19:41 tiwai          Note Added: 0003515                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
