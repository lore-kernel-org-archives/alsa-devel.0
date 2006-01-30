From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001556]: Fortissimo 4: No Volume Control
Date: Mon, 30 Jan 2006 15:55:49 +0100
Message-ID: <41e1f57b3819033bb1be065f2e69c469@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DF9A61CA
	for <alsa-devel@alsa-project.org>; Mon, 30 Jan 2006 15:55:49 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1556> 
======================================================================
Reported By:                bladus
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1556
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               Gentoo Linux 2005.1
Kernel Version:             2.6.14-ck1
======================================================================
Date Submitted:             11-13-2005 22:06 CET
Last Modified:              01-30-2006 15:55 CET
======================================================================
Summary:                    Fortissimo 4: No Volume Control
Description: 
With the Hercules Fortissimo 4 (Envy24HT) there's no posibillity to control
the volume.
It's always at max.

Under Windows the card uses the reference drivers from VIA, so maybe you
can fix that issue.
I would be very happy if you could send me a response to this issue within
a week, since when it's not possible i can return the card to the
merchant.

Thank you.

======================================================================

----------------------------------------------------------------------
 rolling - 01-26-06 08:36 
----------------------------------------------------------------------
I have same problem with volume control.  
Both of these options does solve the problem. Is there any more ideas how
to make it work. 
Distribution Ubuntu 5.10
Kernel 2.6.12



----------------------------------------------------------------------
 madman2003 - 01-30-06 15:55 
----------------------------------------------------------------------
Hercules Fortissimo 4(One codec, one dac):
http://www.wolfsonmicro.com/products/digital_audio/dacs/WM8766/
http://www.wolfsonmicro.com/products/digital_audio/codecs/WM8776/

Terratec Aureon 7.1 Space(codec):
http://www.wolfsonmicro.com/products/digital_audio/codecs/WM8770/

The difference is the 8770 has anologue gain and the 8776 only has digital
volume control and i remember reading somewhere that the analogue gain is
actually used. The WM8776 is less common and that's why it's probably not
supported. I only use the optical out and i don't care much for the
analogue connectors. But i thought i'd mention it.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-13-05 22:06 bladus         New Issue                                    
11-13-05 22:06 bladus         Distribution              => Gentoo Linux 2005.1
11-13-05 22:06 bladus         Kernel Version            => 2.6.14-ck1      
11-14-05 11:02 perex          Note Added: 0006713                          
11-14-05 11:02 perex          Assigned To               => perex           
11-14-05 11:02 perex          Status                   new => feedback     
11-14-05 13:39 bladus         Note Added: 0006722                          
11-14-05 13:55 bladus         Note Added: 0006723                          
11-14-05 14:01 perex          Note Added: 0006724                          
11-15-05 16:37 bladus         Note Added: 0006731                          
11-19-05 10:27 bladus         Note Added: 0006761                          
01-10-06 19:37 liiwi          Issue Monitored: liiwi                       
01-10-06 19:58 liiwi          Note Added: 0007552                          
01-26-06 08:35 rolling        Note Added: 0007785                          
01-26-06 08:36 rolling        Note Edited: 0007785                         
01-30-06 15:55 madman2003     Note Added: 0007838                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
