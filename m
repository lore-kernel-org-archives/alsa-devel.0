From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001107]: amixer crashes with M-Audio Revolution 7.1 when value is given to numid=0
Date: Wed, 15 Jun 2005 15:18:42 +0200
Message-ID: <397c4871e92940318ff3423b4ea4d05f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8E6D31EF
	for <alsa-devel@alsa-project.org>; Wed, 15 Jun 2005 15:18:42 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1107> 
======================================================================
Reported By:                sst4
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Issue ID:                   1107
Category:                   amixer
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     resolved
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             05-14-2005 02:50 CEST
Last Modified:              06-15-2005 15:18 CEST
======================================================================
Summary:                    amixer crashes with M-Audio Revolution 7.1 when
value is given to numid=0
Description: 
The following says it all:

"
[root@athlon ~]# cat /proc/asound/pcm
00-00: ICE1724 : ICE1724 : playback 1 : capture 1
00-01: IEC1724 IEC958 : IEC1724 IEC958 : playback 1
00-02: ICE1724 Surrounds : ICE1724 Surround PCM : playback 3
[root@athlon ~]# amixer  cset numid=0 50%
amixer: control.c:251: snd_ctl_elem_info: Assertion `ctl && info &&
(info->id.name[0] || info->id.numid)'failed.
Aborted (core dumped)
[root@athlon ~]#
".

The same configuration as in

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1106
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1096 ,
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1095 .

Thanks in advance,
  Sergei.

======================================================================

----------------------------------------------------------------------
 sst4 - 05-27-05 12:26 
----------------------------------------------------------------------
By the way, this command line: 'amixer cget numid=0'

produces this:
"
amixer: control.c:251: snd_ctl_elem_info: Assertion `ctl && info &&
(info->id.name[0] || info->id.numid)' failed.
Abort
"
Probably useful for developers, but not for end users. Could you please
implement a more
useful error message explaining what's wrong ?

Thanks,
  Sergei.

----------------------------------------------------------------------
 tiwai - 06-15-05 15:18 
----------------------------------------------------------------------
The error is because you pass an invalid value numid=0.  It must be a
positive integer.
Will improve the error message, though.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-14-05 02:50 sst4           New Issue                                    
05-24-05 12:03 tiwai          Note Added: 0004713                          
05-24-05 21:41 sst4           Note Added: 0004730                          
05-27-05 12:26 sst4           Note Added: 0004747                          
06-15-05 15:18 tiwai          Status                   new => resolved     
06-15-05 15:18 tiwai          Resolution               open => not an issue
06-15-05 15:18 tiwai          Assigned To               => tiwai           
06-15-05 15:18 tiwai          Note Added: 0005031                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
