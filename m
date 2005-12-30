From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001215]: AC3 Passthrough does not work
Date: Fri, 30 Dec 2005 04:31:12 +0100
Message-ID: <b9305e7cb58c5ba5fd205598b5a29832@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1F3E21A1
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 04:31:13 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1215> 
======================================================================
Reported By:                hugo4711
Assigned To:                rlrevell
======================================================================
Project:                    ALSA - driver
Issue ID:                   1215
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Fedora Core 4
Kernel Version:             2.6.11-1.1369_FC
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             06-27-2005 21:59 CEST
Last Modified:              12-30-2005 04:31 CET
======================================================================
Summary:                    AC3 Passthrough does not work
Description: 
Since the update from FC3 to FC4 I am not able to use AC3-passthrough. It
won't work with xine or mplayer. 

The AC3-Reciever I am using indicates "No Audio" when playing a DVD with
AC3-Sound. Before the Update it switches to Dolby AC3 Decoding mode. 

When I play a movie with xine, and the driver is switched into
AC3-passthrough-mode and then I quit xine, the driver is not switched back
out of the passthrough-mode (which is a bug in xine, I guess). This is
very anoying, because there is no such thing as to reset the mixer
settings, unless the previous settings are stored (alsactl
store/restore).

Another thing is, that I am not able to hear sound from sources which are
plugged into line-in. Mixer Settings are checked. Every channel is unmuted
and volume is at 100%. Digital Out is unmuted, IEC-Compliancy is muted.
======================================================================

----------------------------------------------------------------------
 hugo4711 - 06-30-05 17:16 
----------------------------------------------------------------------
I tested the 1.0.9a driver. It works now.

----------------------------------------------------------------------
 rlrevell - 12-30-05 04:31 
----------------------------------------------------------------------
Fixed

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-27-05 21:59 hugo4711       New Issue                                    
06-27-05 21:59 hugo4711       Distribution              => Fedora Core 4   
06-27-05 21:59 hugo4711       Kernel Version            => 2.6.11-1.1369_FC
06-28-05 20:05 hugo4711       Note Added: 0005299                          
06-29-05 20:23 tiwai          Note Added: 0005312                          
06-30-05 17:16 hugo4711       Note Added: 0005327                          
12-30-05 04:31 rlrevell       Status                   new => resolved     
12-30-05 04:31 rlrevell       Resolution               open => fixed       
12-30-05 04:31 rlrevell       Assigned To               => rlrevell        
12-30-05 04:31 rlrevell       Note Added: 0007211                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
