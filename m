From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000253]: There's sound from only one way (left or right)
Date: Sat, 31 Dec 2005 03:56:59 +0100
Message-ID: <3a6dc5284581acd188c563947b0fd734@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C599915C
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2005 03:56:59 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=253> 
======================================================================
Reported By:                sjoyeux
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   253
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Debian i386
Kernel Version:             2.6.5
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             05-04-2004 18:33 CEST
Last Modified:              12-31-2005 03:56 CET
======================================================================
Summary:                    There's sound from only one way (left or right)
Description: 
When the modules is first loaded, I have a clear sound on only one way
(left or right, it depends), the other one has a sound of very bad quality
(low volume, quirks)

I have to manually unload it and reload it in order to get a good quality
on both.

It's fully reproducible on my system. I have the problem from quite a long
time now (even though I only report it now)

I use the alsa version which comes with Linux 2.6.5 (1.0.4rc2)

Soundcard is a fortissimo 2, lspci -v says :
Cirrus Logic CS 4614/22/24 [CrystalClear SoundFusion Audio Accelerator]
(rev 01)

======================================================================

----------------------------------------------------------------------
 jdthood - 03-19-05 15:03 
----------------------------------------------------------------------
Submitter: Do you still have this problem with the Debian testing 1.0.8
versions of the ALSA packages?

----------------------------------------------------------------------
 rlrevell - 12-31-05 03:56 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-04-04 18:33 sjoyeux        New Issue                                    
05-04-04 18:33 sjoyeux        Distribution              => Debian i386     
05-04-04 18:33 sjoyeux        Kernel Version            => 2.6.5           
03-19-05 15:03 jdthood        Note Added: 0004047                          
12-31-05 03:56 rlrevell       Status                   new => closed       
12-31-05 03:56 rlrevell       Note Added: 0007332                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
