From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000711]: Sound still bad with alsa on sb audigyls / ca0106
Date: Wed, 20 Apr 2005 18:25:10 +0200
Message-ID: <2d4ea1cf068298e94a2faf50c31acc37@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8797A1D5
	for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2005 18:25:10 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=711> 
======================================================================
Reported By:                scorpion77
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   711
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               Fedora Core 2
Kernel Version:             2.6.9-1.6_FC2custom
======================================================================
Date Submitted:             12-07-2004 18:12 CET
Last Modified:              04-20-2005 18:25 CEST
======================================================================
Summary:                    Sound still bad with alsa on sb audigyls / ca0106
Description: 
Sound is choppy and at wrong speed with both the snd-audigyls from alsa
1.0.7 and snd-ca0106 from alsa CVS. CVS seems worse, which bugs me since
last bug report was closed woth a "Use snd-ca0106 from CVS remark"!
Workaround seems to select (Threaded)OSS as artsd backend instead of Alsa.
Esd as artsd backend only works / fixes things in 1.0.7, it crashes when
the CVS version is used.
======================================================================

----------------------------------------------------------------------
 jcdutton - 04-14-05 12:46 
----------------------------------------------------------------------
The latest alsa-driver CVS has some improvements. Please give it a try.
Sound capture will not be supported any time soon, due to lack of
datasheet documentation.

----------------------------------------------------------------------
 Cimmo - 04-20-05 18:25 
----------------------------------------------------------------------
Seems that your patch works!!! I played some files that previous has some
choppy sound, now seems OK!!!

Only doom3 has always bad sound, and it always write in the terminal:
idAudioHardwareALSA::Write: 4096 frames overflowed and dropped
snd_pcm_writei short write: 690 out of 1024
snd_pcm_writei short write: 690 out of 1024
snd_pcm_writei short write: 690 out of 1024
snd_pcm_writei short write: 690 out of 1024
snd_pcm_writei short write: 690 out of 1024
snd_pcm_writei short write: 690 out of 1024


OVER OVER AND OVER AGAIN!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-07-04 18:12 scorpion77     New Issue                                    
12-07-04 18:12 scorpion77     Distribution              => Fedora Core 2   
12-07-04 18:12 scorpion77     Kernel Version            => 2.6.9-1.6_FC2custom
12-07-04 20:24 rlrevell       Note Added: 0002764                          
12-07-04 21:40 scorpion77     Note Added: 0002765                          
12-07-04 21:53 jcdutton       Note Added: 0002766                          
12-08-04 00:21 scorpion77     Note Added: 0002769                          
12-08-04 00:22 scorpion77     Note Edited: 0002769                         
12-08-04 01:23 jcdutton       Note Added: 0002770                          
12-08-04 01:26 scorpion77     Note Added: 0002771                          
12-08-04 03:40 scorpion77     Note Added: 0002773                          
12-08-04 12:35 tiwai          Note Added: 0002781                          
12-08-04 12:35 tiwai          Category                 PCI - audigyls => PCI -
ca0106
01-15-05 12:50 Kane32         Issue Monitored: Kane32                      
04-14-05 12:46 jcdutton       Note Added: 0004487                          
04-14-05 12:46 jcdutton       Status                   assigned => feedback
04-20-05 18:25 Cimmo          Note Added: 0004543                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
