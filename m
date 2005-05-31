From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001131]: Alsamixer crashing - using Audigy Platinum Ex
Date: Tue, 31 May 2005 12:54:21 +0200
Message-ID: <df8e89d71fa692e431d3e2d23a6cda33@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 40F1D196
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 12:54:21 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1131> 
======================================================================
Reported By:                sorn73
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Issue ID:                   1131
Category:                   alsamixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-27-2005 21:52 CEST
Last Modified:              05-31-2005 12:54 CEST
======================================================================
Summary:                    Alsamixer crashing - using Audigy Platinum Ex
Description: 
I'm having problems with setting the capture levels on my Audigy card. If I
start up alsamixer and press F4 I get a crash:
"alsamixer: simple.c:1975: snd_mixer_selem_get_enum_item: Assertion
`helem' failed.
Abort (core dumped)"

Also, since Kmix (from KDE 3.4) doesn't show any capture devices, I'm
thinking this is not a problem with alsamixer, but with something else.
But since I don't know where I report it on alsamixer.

This is actually alsa v1.0.9, but you can't select that from the list of
versions.

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001144 alsamixer 1.0.9 crashes when browsing t...
======================================================================

----------------------------------------------------------------------
 mrmachine - 05-29-05 14:53 
----------------------------------------------------------------------
cvs update fixed for me, too.

----------------------------------------------------------------------
 sorn73 - 05-29-05 18:45 
----------------------------------------------------------------------
Yes, CVS version worked for me too. I consider this issue resolved.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-27-05 21:52 sorn73         New Issue                                    
05-28-05 04:13 mrmachine      File Added: aadebug.txt                      
05-28-05 04:15 mrmachine      Note Added: 0004757                          
05-28-05 04:16 mrmachine      Issue Monitored: mrmachine                    
05-29-05 07:39 Xero           Note Added: 0004779                          
05-29-05 12:35 jcdutton       Note Added: 0004784                          
05-29-05 14:17 Xero           Note Added: 0004786                          
05-29-05 14:18 Xero           Note Edited: 0004786                         
05-29-05 14:53 mrmachine      Note Added: 0004788                          
05-29-05 18:45 sorn73         Note Added: 0004790                          
05-29-05 23:22 rlrevell       Relationship added       has duplicate 0001144
05-31-05 12:54 tiwai          Status                   new => resolved     
05-31-05 12:54 tiwai          Resolution               open => fixed       
05-31-05 12:54 tiwai          Assigned To               => tiwai           
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
