From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001550]: No volume control
Date: Sat, 31 Dec 2005 03:17:14 +0100
Message-ID: <19d60d97edbe6de61b66ce4bb671348f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B0DF4176
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2005 03:17:14 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1550> 
======================================================================
Reported By:                froztbyte
Assigned To:                rlrevell
======================================================================
Project:                    ALSA - driver
Issue ID:                   1550
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               SuSE 9.3, Mandrive LE 2005, FC4 and Debian Sarge
Kernel Version:             2.6.11 (al round)
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-12-2005 11:31 CET
Last Modified:              12-31-2005 03:17 CET
======================================================================
Summary:                    No volume control
Description: 
Under linux I have no hardware volume control of my onboard sound card (SiS
SI7012 series sound controller. Under WinXP it uses the the CMI9739A Audio
codec, if that can be of any use to anyone). I can either have my sound
coming through at full power, or completely muted. I have also tried this
under OSS and have not succeeded.
======================================================================

----------------------------------------------------------------------
 rlrevell - 11-12-05 20:01 
----------------------------------------------------------------------
Looks like we need to activate softvol for this device.  It should be
enabled by default with a recent ALSA (1.0.9b or newer).

----------------------------------------------------------------------
 rlrevell - 12-31-05 03:17 
----------------------------------------------------------------------
Fixed, C-Media codecs now use softvol by default

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-12-05 11:31 froztbyte      New Issue                                    
11-12-05 11:31 froztbyte      Distribution              => SuSE 9.3, Mandrive LE
2005, FC4 and Debian Sarge
11-12-05 11:31 froztbyte      Kernel Version            => 2.6.11 (al round)
11-12-05 20:01 rlrevell       Note Added: 0006689                          
12-31-05 03:17 rlrevell       Status                   new => resolved     
12-31-05 03:17 rlrevell       Resolution               open => fixed       
12-31-05 03:17 rlrevell       Assigned To               => rlrevell        
12-31-05 03:17 rlrevell       Note Added: 0007322                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
