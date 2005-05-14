From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001107]: amixer crashes with M-Audio Revolution 7.1 when value is given to numid=0
Date: Sat, 14 May 2005 02:50:38 +0200
Message-ID: <8b24f4b68e840cafe42da79d7f654d2f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 266232CB
	for <alsa-devel@alsa-project.org>; Sat, 14 May 2005 02:50:39 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1107> 
======================================================================
Reported By:                sst4
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1107
Category:                   amixer
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             05-14-2005 02:50 CEST
Last Modified:              05-14-2005 02:50 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-14-05 02:50 sst4           New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
