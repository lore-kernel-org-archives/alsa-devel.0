From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001018]: resampler produces noise
Date: Sat, 26 Mar 2005 22:51:50 +0100
Message-ID: <1058c60e1d03102cfab3ad66e005c9fe@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id F3222231
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2005 22:51:50 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1018> 
======================================================================
Reported By:                grabner
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1018
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             03-26-2005 22:51 CET
Last Modified:              03-26-2005 22:51 CET
======================================================================
Summary:                    resampler produces noise
Description: 
Sad to say, but after some recent improvements (thanks to tiwai) the
resampling code is still buggy. Under certain conditions, noise peaks are
added to the signal, which are clearly audible.
To make sure that this is not a problem with any particular hardware
driver, I created a test case using the "file" and "null" plugins (i.e.,
no output on audio hardware). See below for details.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-26-05 22:51 grabner        New Issue                                    
03-26-05 22:51 grabner        File Added: resampling_bug_demo.tbz               
    
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
