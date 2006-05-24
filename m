From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002158]: play produces i/o error on ad1845 (miro)
Date: Wed, 24 May 2006 15:13:20 +0200
Message-ID: <75d8d560d6703722cae6f26bcac12ec8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4F85913C
	for <alsa-devel@alsa-project.org>; Wed, 24 May 2006 15:13:20 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2158> 
======================================================================
Reported By:                martin
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2158
Category:                   ISA - miro
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             05-24-2006 15:13 CEST
Last Modified:              05-24-2006 15:13 CEST
======================================================================
Summary:                    play produces i/o error on ad1845 (miro)
Description: 
At first I will mention that 1.0.10final works without problems. And
1.0.11rc3 or any newer version fails always during the fifth hw_writei
with this Input/Output error:

aplay -Dplughw:1 /data/audio/lisboa_reloaded_1_20060421.wav Playing WAVE
'/data/audio/lisboa_reloaded_1_20060421.wav' : Signed 16 bit Little 
Endian, Rate 44100 Hz, Stereo
hw_writei: frames = 4096, xferi.result = 4096, err = 0
hw_writei: frames = 4096, xferi.result = 4096, err = 0
hw_writei: frames = 4096, xferi.result = 4096, err = 0
hw_writei: frames = 4096, xferi.result = 4096, err = 0
hw_writei: frames = 4096, xferi.result = -5, err = -5
aplay: pcm_write:1264: write error: Input/output error

My snd-miro uses an AD1845 which will be driven by the cs4231-lib. It's
really possible that other cards with an ad1845 will have the same
problem. BTW, recording seems to work without problems.

Unfortunately I haven't found the bug, yet. It was introduced between
1.0.10 and 1.0.11rc3. Well, if rc1/rc2 would compile, I could be more
precise here.

A strace log is attached. Any ideas? (Just before I start the hard way:
fixing the rc1/2 compilation bug and hunting for the bad patch...)
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-24-06 15:13 martin         New Issue                                    
05-24-06 15:13 martin         File Added: miro.log.gz                      
======================================================================




-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
