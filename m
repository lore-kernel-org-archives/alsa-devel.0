From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000253]: There's sound from only one way (left or right)
Date: Sat, 19 Mar 2005 15:03:52 +0100
Message-ID: <5926a4f088a0d7436b64448b496ae361@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0F1B1188
	for <alsa-devel@alsa-project.org>; Sat, 19 Mar 2005 15:03:53 +0100 (MET)
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
Status:                     new
Distribution:               Debian i386
Kernel Version:             2.6.5
======================================================================
Date Submitted:             05-04-2004 18:33 CEST
Last Modified:              03-19-2005 15:03 CET
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-04-04 18:33 sjoyeux        New Issue                                    
05-04-04 18:33 sjoyeux        Distribution              => Debian i386     
05-04-04 18:33 sjoyeux        Kernel Version            => 2.6.5           
03-19-05 15:03 jdthood        Note Added: 0004047                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
