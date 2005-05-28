From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001131]: Alsamixer crashing - using Audigy Platinum Ex
Date: Sat, 28 May 2005 04:15:35 +0200
Message-ID: <54a39b7f8703e9597f78c1871bb1862f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 32F521A7
	for <alsa-devel@alsa-project.org>; Sat, 28 May 2005 04:15:36 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1131> 
======================================================================
Reported By:                sorn73
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1131
Category:                   alsamixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             05-27-2005 21:52 CEST
Last Modified:              05-28-2005 04:15 CEST
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

----------------------------------------------------------------------
 mrmachine - 05-28-05 04:15 
----------------------------------------------------------------------
i get the exact same thing with my soundblaster live 5.1. however, i'm
still able to use the capture channels ... aadebug attached.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-27-05 21:52 sorn73         New Issue                                    
05-28-05 04:13 mrmachine      File Added: aadebug.txt                      
05-28-05 04:15 mrmachine      Note Added: 0004757                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
