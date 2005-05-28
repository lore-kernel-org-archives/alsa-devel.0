From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000686]: No surround sound
Date: Sat, 28 May 2005 12:23:42 +0200
Message-ID: <a00028e871b3f6a284d840d31c686423@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 00BA4214
	for <alsa-devel@alsa-project.org>; Sat, 28 May 2005 12:23:44 +0200 (MEST)
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
Status:                     closed
Distribution:               Gentoo Linux
Kernel Version:             2.4.26-gentoo-r9
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             11-28-2004 15:45 CET
Last Modified:              05-28-2005 12:23 CEST
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
 jcdutton - 03-19-05 18:21 
----------------------------------------------------------------------
You need to upgrade to the latest alsa-driver 1.0.8 and alsa-lib 1.0.8 or
above.
The version of alsa-driver should always match the version of alsa-lib.

----------------------------------------------------------------------
 jcdutton - 05-28-05 12:23 
----------------------------------------------------------------------
Closed due to lack of feedback.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-28-04 15:45 dziegiel       New Issue                                    
11-28-04 15:45 dziegiel       Distribution              => Gentoo Linux    
11-28-04 15:45 dziegiel       Kernel Version            => 2.4.26-gentoo-r9
12-06-04 23:34 jcdutton       Note Added: 0002743                          
12-06-04 23:34 jcdutton       Status                   assigned => feedback
01-30-05 12:38 dziegiel       Note Added: 0003441                          
01-30-05 13:40 jcdutton       Note Added: 0003442                          
02-02-05 17:41 dziegiel       Note Added: 0003490                          
02-03-05 12:57 dziegiel       Note Edited: 0003490                         
02-13-05 11:15 sHINOBI        Issue Monitored: sHINOBI                     
03-19-05 18:21 jcdutton       Note Added: 0004063                          
05-28-05 12:23 jcdutton       Status                   feedback => closed  
05-28-05 12:23 jcdutton       Note Added: 0004766                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
