From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001457]: Lagged sound
Date: Tue, 13 Dec 2005 17:17:54 +0100
Message-ID: <5d1fd83c0d4bf3997b896eba32b5025e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D68871C1
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2005 17:17:54 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1457> 
======================================================================
Reported By:                mouse
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   1457
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               ALT Linux
Kernel Version:             from 2.6.10 to 2.6.12
======================================================================
Date Submitted:             09-25-2005 12:56 CEST
Last Modified:              12-13-2005 17:17 CET
======================================================================
Summary:                    Lagged sound
Description: 
Played music a bit lagged and in dmesg I see:
vortex: IRQ fifo error
======================================================================

----------------------------------------------------------------------
 Raymond - 11-17-05 10:56 
----------------------------------------------------------------------
Which application are you using to play music ?

http://developer.intel.com/technology/iapc/involve.htm

Although the windows drivers are ACPI compliant, the ALSA au88x0 driver do
not support suspend/resume.

My au8830 works fine (including 10-bands stereo equalizer) except the
front/rear channels are swapped.

Does the front/rear channels swap occur on your MX300 ?

Which AC97 codec is on your MX300 ?

speaker-test -c 4

----------------------------------------------------------------------
 Raymond - 12-13-05 17:17 
----------------------------------------------------------------------
You better put your MX300 on a PCI slot which do not share interrupt with
your add-on IDE/SCSI controller and video card.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-25-05 12:56 mouse          New Issue                                    
09-25-05 12:56 mouse          Distribution              => ALT Linux       
09-25-05 12:56 mouse          Kernel Version            => from 2.6.10 to 2.6.12
09-25-05 13:00 mouse          Note Added: 0006386                          
09-25-05 13:00 mouse          File Added: au8830                           
11-16-05 13:05 Raymond        Note Added: 0006739                          
11-17-05 09:10 mouse          Note Added: 0006746                          
11-17-05 10:56 Raymond        Note Added: 0006747                          
12-13-05 17:17 Raymond        Note Added: 0007019                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
