From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001422]: Timidity stops playing longer list of midi files
Date: Sat, 24 Sep 2005 19:07:40 +0200
Message-ID: <a0a8bae8eed3fb0318cfdfb7d8ce4f96@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7863B165
	for <alsa-devel@alsa-project.org>; Sat, 24 Sep 2005 19:07:40 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1422> 
======================================================================
Reported By:                johnclubvec
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1422
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             09-15-2005 13:54 CEST
Last Modified:              09-24-2005 19:07 CEST
======================================================================
Summary:                    Timidity stops playing longer list of midi files
Description: 
I use Timidity 2.13.2 for virmidi. When using alsa 1.0.9, Timidity (gtk
interface) when playing a longer list of midi files, always stops
functioning after playing around 10 or so. I could not track down the
source of this error but it occurs every time. Timidity simply stops.

When I reverted back the driver and lib and utils to my previous alsa
1.0.4, this problem completely disappeared.
======================================================================

----------------------------------------------------------------------
 johnclubvec - 09-15-05 22:32 
----------------------------------------------------------------------
Q. from rlrevell: Does the problem go away if you recompile Timidity
against alsa-lib 1.0.9?

A. Yes, it goes away -- unfortunately. I will now recompile all my
audio-producing programs against 1.0.9 just to be on the safe side.

----------------------------------------------------------------------
 johnclubvec - 09-24-05 19:07 
----------------------------------------------------------------------
After more testing, I can report that the problem is very much helped by
recompiling against the 1.0.9 lib, but is not completely fixed. There are
some (valid, uncorrupt) midi files that, using 1.0.9, Timidity will play
singly, but not in sequence within a playlist. In this case, Timidity
plays to the end of the first file, then stops. I have again reverted to
1.0.4, because I never experience this problem using that version.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-15-05 13:54 johnclubvec    New Issue                                    
09-15-05 20:07 rlrevell       Note Added: 0006220                          
09-15-05 22:32 johnclubvec    Note Added: 0006224                          
09-24-05 19:07 johnclubvec    Note Added: 0006376                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
