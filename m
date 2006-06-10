From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002142]: no more microphone
Date: Sat, 10 Jun 2006 18:56:48 +0200
Message-ID: <b638376ff24683d34a248af7ffedd581@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 327A7159
	for <alsa-devel@alsa-project.org>;
	Sat, 10 Jun 2006 18:56:49 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2142> 
======================================================================
Reported By:                piem
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2142
Category:                   PPC - powermac
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.17-rc3
======================================================================
Date Submitted:             05-22-2006 12:12 CEST
Last Modified:              06-10-2006 18:56 CEST
======================================================================
Summary:                    no more microphone
Description: 
I haven't been able to access the microphone on my iBook G4 since at least
2.6.12 and up to 2.6.17-rc3. The chip is a Snapper, and microphone
recording used to be supported. Debian package alsa-utils 1.0.11-2 is
installed.

$ cat /proc/asound/cards
 0 [Snapper        ]: PMac Snapper - PowerMac Snapper
                      PowerMac Snapper (Dev 38) Sub-frame 0

$ cat /proc/cpuinfo 
processor       : 0
cpu             : 7447A, altivec supported
clock           : 533.333000MHz
revision        : 0.1 (pvr 8003 0101)
bogomips        : 36.73
timebase        : 18432000
platform        : PowerMac
machine         : PowerBook6,5
motherboard     : PowerBook6,5 MacRISC3 Power Macintosh 
detected as     : 287 (iBook G4)
pmac flags      : 0000001b
L2 cache        : 512K unified
pmac-generation : NewWorld

======================================================================

----------------------------------------------------------------------
 bz31 - 06-10-06 18:56 
----------------------------------------------------------------------
Hi,

I found how to record !
I must use two channels. One channel doesn't work.

Using rec:
$ rec -c 2 test.wav
$ play test.wav

Using audacity:
Edit ---> Preferences --> Channels: 2(stereo)
Then I can record from microphone

Note: In audacity, when recording, I see 
L
R -----
the input level meter.
Only Right channel R works.
The Left channel dosen't works. Maybe this is why we can't record mono
sound.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-22-06 12:12 piem           New Issue                                    
05-22-06 12:12 piem           Distribution              => Debian          
05-22-06 12:12 piem           Kernel Version            => 2.6.17-rc3      
06-10-06 09:38 bz31           Issue Monitored: bz31                        
06-10-06 18:56 bz31           Note Added: 0010147                          
======================================================================
