From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000157]: Integration of Matrix Mixer (a GPL stereo --> 5.1/Dolby Surround/ProLogic upmixing filter)
Date: Thu, 25 Nov 2004 14:05:47 +0100
Message-ID: <cc52083565b85ff7e62863cf609af5ed@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B4612166
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2004 14:05:47 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=157> 
======================================================================
Reported By:                djtm
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   157
Category:                   mixer
Reproducibility:            sometimes
Severity:                   feature
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             03-24-2004 16:04 CET
Last Modified:              11-25-2004 14:05 CET
======================================================================
Summary:                    Integration of Matrix Mixer (a GPL stereo -->
5.1/Dolby Surround/ProLogic upmixing filter)
Description: 
"MatrixMixer - is a DirectShow filter to upmix any stereo source to
multiple speakers." It is published under the GPL2 and written in C++.

Homepage: http://matrix-mixer.sourceforge.net. 
Source Download:
http://belnet.dl.sourceforge.net/sourceforge/matrix-mixer/matrix_mixer_0_30b_src.zip

It does a really good job on windows systems for movies as well as music.
I think this is a big improvement for ALSA, as all people with any kind of
surround sound or good headphones will love this.
======================================================================

----------------------------------------------------------------------
 djtm - 03-28-04 20:14 
----------------------------------------------------------------------
There should be no license problem, as the main part doesn't correlate with
AC3 and it's all pubished under GPL and developed without using patented
knowledge.

The main part is upmixing any stereo source to 5.1 surround. And that
means for example a stereo MP3 is upmixed to have 5.1 sound by cleverly
distributing the sound over the 6 speakers. It also works for stereo AC3s
but they are not decoded by the matrix mixer. 

tiwai - You probably confused it with AC3filter by the same author.

----------------------------------------------------------------------
 djtm - 11-25-04 14:05 
----------------------------------------------------------------------
It has no correlations with AC3.

Has someone found interest in porting it?

If you need a motivation try it out on a windows system and see how well
it works - both with good headphones or with a surround system.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-24-04 16:04 djtm           New Issue                                    
03-24-04 20:10 djtm           Issue Monitored: djtm                        
03-28-04 17:43 tiwai          Note Added: 0000713                          
03-28-04 20:14 djtm           Note Added: 0000714                          
11-25-04 14:05 djtm           Note Added: 0002589                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
