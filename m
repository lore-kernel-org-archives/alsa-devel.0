From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001142]: alsamixer (alsa-utils-1.0.9) crash when going to right controls
Date: Tue, 31 May 2005 12:56:20 +0200
Message-ID: <ee7ca8b60d59c95fe03d9aa9944b7023@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0A7FF196
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 12:56:21 +0200 (MEST)
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
Status:                     resolved
Resolution:                 duplicate
Duplicate:                  1131
Fixed in Version:           
======================================================================
Date Submitted:             05-29-2005 13:31 CEST
Last Modified:              05-31-2005 12:56 CEST
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
This is a duplicate of bug
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1131

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
