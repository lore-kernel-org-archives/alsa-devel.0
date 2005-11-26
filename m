From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000664]: ac97_quirk with SIS 7012 [ALC202] don't permit to have sound from the headphones, only internal speakers work.
Date: Sat, 26 Nov 2005 20:12:08 +0100
Message-ID: <b69ebbfdd8946e8c11257051803e5484@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3F2401E7
	for <alsa-devel@alsa-project.org>; Sat, 26 Nov 2005 20:12:08 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=664> 
======================================================================
Reported By:                ignition
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   664
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     confirmed
Distribution:               GNU/Linux Slackware 10.0
Kernel Version:             2.4.28
======================================================================
Date Submitted:             11-22-2004 18:29 CET
Last Modified:              11-26-2005 20:12 CET
======================================================================
Summary:                    ac97_quirk with SIS 7012 [ALC202] don't permit to
have sound from the headphones, only internal speakers work.
Description: 
module: intel8x0
card: SiS SI7012
chip: Realtek ALC202 rev 0

All ok but when I plug a jack from the headphones (or hi-fi system), there
is no sound.
And when I plug a jack halfway, I hear mono sound with bad quality from
internal speaker AND from the headphones.
======================================================================
Relations           ID      Résumé
----------------------------------------------------------------------
doublon de          0000014 No sound from headphone jack on Acer27*...
======================================================================

----------------------------------------------------------------------
 ignition - 11-14-05 15:46 
----------------------------------------------------------------------
Maybe we must re-enginering the windows'driver or do lobbying ?

----------------------------------------------------------------------
 ignition - 11-26-05 20:12 
----------------------------------------------------------------------
Is it possibe that "SiS SI7012 Realtek ALC203 rev 0" works and not "SiS
SI7012 Realtek ALC202 rev 0" ?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-22-04 18:29 ignition       New Issue                                    
11-22-04 18:29 ignition       File Added: report                           
11-22-04 18:29 ignition       Distribution              => GNU/Linux Slackware
10.0
11-22-04 18:29 ignition       Kernel Version            => 2.4.28          
11-22-04 18:48 tiwai          Relationship added       duplicate of 0000014
11-22-04 18:48 tiwai          Duplicate ID             0 => 14             
11-22-04 18:48 tiwai          Status                   new => resolved     
11-22-04 18:48 tiwai          Resolution               open => duplicate   
11-22-04 18:48 tiwai          Assigned To               => tiwai           
11-22-04 18:48 tiwai          Note Added: 0002510                          
11-22-04 18:51 ignition       Issue Monitored: ignition                    
11-22-04 18:52 ignition       Issue End Monitor: ignition                    
12-06-04 14:58 dale           Issue Monitored: dale                        
01-20-05 18:52 jorge2         Issue Monitored: jorge2                      
03-23-05 15:41 jdthood        Status                   resolved => feedback
03-23-05 15:41 jdthood        Resolution               duplicate => reopened
03-23-05 15:41 jdthood        Note Added: 0004163                          
06-14-05 21:16 graf_eichbaum  Issue Monitored: graf_eichbaum                    
07-16-05 16:42 jdthood        Note Added: 0005497                          
08-02-05 21:21 ignition       Note Added: 0005606                          
09-15-05 16:12 ignition       Issue Monitored: ignition                    
09-29-05 12:31 jdthood        Status                   feedback => confirmed
10-05-05 18:45 tiwai          Note Added: 0006434                          
11-12-05 11:41 dale           Note Added: 0006686                          
11-14-05 15:46 ignition       Note Added: 0006726                          
11-26-05 20:12 ignition       Note Added: 0006849                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
