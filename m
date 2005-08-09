From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001142]: alsamixer (alsa-utils-1.0.9) crash when going to right controls
Date: Tue, 9 Aug 2005 13:46:23 +0200
Message-ID: <1c054efcdd727c587abf88fb34c151c8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A65EF1F8
	for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2005 13:46:23 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1142> 
======================================================================
Reported By:                atermiles
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Issue ID:                   1142
Category:                   alsamixer
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     closed
Resolution:                 duplicate
Duplicate:                  1131
Fixed in Version:           
======================================================================
Date Submitted:             05-29-2005 13:31 CEST
Last Modified:              08-09-2005 13:46 CEST
======================================================================
Summary:                    alsamixer (alsa-utils-1.0.9) crash when going to
right controls
Description: 
When going to right controls in alsamixer(alsa-utils-1.0.9)
there is an error:
"mixer: simple.c:1975: snd_mixer_selem_get_enum_item: Assertion `helem'
failed"

alsa-driver-1.0.9 and alsa-lib-1.0.9 works good with alsa-utils-1.0.8

(soundcard: au8830)

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001131 Alsamixer crashing - using Audigy Plati...
======================================================================

----------------------------------------------------------------------
 jcdutton - 05-29-05 13:47 
----------------------------------------------------------------------
This is a duplicate of bug #1131

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-29-05 13:31 atermiles      New Issue                                    
05-29-05 13:47 jcdutton       Note Added: 0004785                          
05-31-05 12:56 tiwai          Relationship added       duplicate of 0001131
05-31-05 12:56 tiwai          Duplicate ID             0 => 1131           
05-31-05 12:56 tiwai          Status                   new => resolved     
05-31-05 12:56 tiwai          Resolution               open => duplicate   
05-31-05 12:56 tiwai          Assigned To               => tiwai           
08-09-05 13:46 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
