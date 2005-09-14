From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000757]: Noisy recording for oss emulation
Date: Wed, 14 Sep 2005 16:12:09 +0200
Message-ID: <7cd2ce61a45b04b61af153ffc671bf50@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 73EB71A3
	for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2005 16:12:09 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=757> 
======================================================================
Reported By:                tomasz_janowski
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   757
Category:                   CORE OSS - pcm
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 2
Kernel Version:             2.6.8.1
======================================================================
Date Submitted:             12-29-2004 07:49 CET
Last Modified:              09-14-2005 16:12 CEST
======================================================================
Summary:                    Noisy recording for oss emulation
Description: 
I noticed that when I use arecord for recording on the VT82C686 AC97 Audio
sound card the sound is very good, but using the rec (OSS) program I
always have some additional sounds - static - during recording. I have on
the same computer the Ensoniq ES1371 card and almost identical setup for
it but I haven't similar problems with OSS emulation.
======================================================================

----------------------------------------------------------------------
 tomasz_janowski - 12-29-04 07:51 
----------------------------------------------------------------------
I have added the sample file with recording output from rec.

----------------------------------------------------------------------
 jdthood - 09-14-05 16:12 
----------------------------------------------------------------------
Submitter: Is this problem fixed in more recent ALSA versions?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-29-04 07:49 tomasz_janowskiNew Issue                                    
12-29-04 07:49 tomasz_janowskiDistribution              => Fedora Core 2   
12-29-04 07:49 tomasz_janowskiKernel Version            => 2.6.8.1         
12-29-04 07:50 tomasz_janowskiFile Added: xx.wav                           
12-29-04 07:51 tomasz_janowskiNote Added: 0002992                          
09-14-05 16:12 jdthood        Note Added: 0006177                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
