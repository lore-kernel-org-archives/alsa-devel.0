From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000686]: No surround sound
Date: Sun, 30 Jan 2005 12:38:28 +0100
Message-ID: <b64cd453b2e1c1550fc8454b37f56a1a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6818D1C7
	for <alsa-devel@alsa-project.org>; Sun, 30 Jan 2005 12:38:28 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=686> 
======================================================================
Reported By:                dziegiel
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   686
Category:                   PCI - audigyls
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               Gentoo Linux
Kernel Version:             2.4.26-gentoo-r9
======================================================================
Date Submitted:             11-28-2004 15:45 CET
Last Modified:              01-30-2005 12:38 CET
======================================================================
Summary:                    No surround sound
Description: 
I can`t enable surround sound on my 5.1 speakers.
In xmms with alsa-plugin i get stereo with 2 Front speakers[low-quality
sound] ,but with oss i get 2 Front and Center[they work fine]without
Rear.
In movies[I`ve tried several players] I have the same problem.
When I type:
mplayer -ao alsa1x -channels 6 movie.avi
I get:
...
alsa-init: soundcard set to surround51
ALSA lib pcm.c:1851:(snd_pcm_open_conf) Invalid type for PCM surround51
definition (id: surround51, value: cards.pcm.surround51)
alsa-init: playback open error:
Z&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=322;y argument
...

I`ve tried everything with alsamixer, but with no result.
PS.
Sorry for my English.
======================================================================

----------------------------------------------------------------------
 jcdutton - 12-06-04 23:34 
----------------------------------------------------------------------
Please provide output of
cat /proc/asound/cards


----------------------------------------------------------------------
 dziegiel - 01-30-05 12:38 
----------------------------------------------------------------------
cat /proc/asound/cards :

0 [AUDIGYLS       ]: AudigyLS - AUDIGYLS
                     AudigyLS [SB0310] at 0xe400 irq 9

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-28-04 15:45 dziegiel       New Issue                                    
11-28-04 15:45 dziegiel       Distribution              => Gentoo Linux    
11-28-04 15:45 dziegiel       Kernel Version            => 2.4.26-gentoo-r9
12-06-04 23:34 jcdutton       Note Added: 0002743                          
12-06-04 23:34 jcdutton       Status                   assigned => feedback
01-30-05 12:38 dziegiel       Note Added: 0003441                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
