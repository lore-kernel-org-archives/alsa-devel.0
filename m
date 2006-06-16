From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002159]: ac3 passthrough not working
	on recent versions
Date: Fri, 16 Jun 2006 13:37:14 +0200
Message-ID: <c3ac9139f8298bfa8316de71e03f4bcd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 823B7192
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Jun 2006 13:37:14 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2159> 
======================================================================
Reported By:                nikke
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2159
Category:                   PCI - ymfpci
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.15
======================================================================
Date Submitted:             05-24-2006 23:44 CEST
Last Modified:              06-16-2006 13:37 CEST
======================================================================
Summary:                    ac3 passthrough not working on recent versions
Description: 
Using the following AC3 passthrough with mplayer works:
Linux 2.4.31
alsa-driver 1.0.8-7 (debian stable packaged)

Using Linux 2.6.15 (both with alsa-driver 1.10rc3 that ships with the
kernel and
alsa-driver 1.0.11) it doesn't work. The reciever just says "unlock" and
stays quiet.

The only change is booting with different kernels, no other config or
hardware is touched, so this must be a driver regression.

The card is YMF-754 based, connected with coax spdif to my HK reciever.

If you need more info, just tell me and I'll dig it up.
======================================================================

----------------------------------------------------------------------
 Raymond - 06-16-06 13:31 
----------------------------------------------------------------------
Are you really sure that the patch "ymfpci: add per-voice volume controls"
break AC3 passthrough, the purpose of that patch is to implement pcm
volume control per substream using the hardware mixing of ymfpci

Please note that STAC9708 has no SPDIF control registers, there is no need
to compare ac97 registers

You should compare those ymfpci register

cat /proc/asound/card0/ymfpci

iecset



----------------------------------------------------------------------
 Mimosius - 06-16-06 13:37 
----------------------------------------------------------------------
Hi Raymond,

yes, I'm really sure this patch breaks AC3 passthrough. A comparison of
the /proc/asound/card0/ymfpci registers against 1.0.9b (patched up to
1.0.11 without Clemens patch) and 1.0.11 (native) is included in my
previous note.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-24-06 23:44 nikke          New Issue                                    
05-24-06 23:44 nikke          Distribution              => Debian          
05-24-06 23:44 nikke          Kernel Version            => 2.6.15          
05-24-06 23:47 nikke          Issue Monitored: nikke                       
06-02-06 04:23 Raymond        Note Added: 0010045                          
06-02-06 04:25 Raymond        Note Edited: 0010045                         
06-12-06 13:14 Mimosius       Issue Monitored: Mimosius                    
06-14-06 22:32 nikke          Note Added: 0010216                          
06-15-06 02:18 Raymond        Note Added: 0010221                          
06-15-06 02:27 Raymond        Note Edited: 0010221                         
06-15-06 11:03 Mimosius       Note Added: 0010237                          
06-15-06 23:43 nikke          Note Added: 0010246                          
06-16-06 13:01 Mimosius       Note Added: 0010250                          
06-16-06 13:16 Mimosius       Note Edited: 0010250                         
06-16-06 13:26 Raymond        Note Added: 0010251                          
06-16-06 13:31 Raymond        Note Edited: 0010251                         
06-16-06 13:37 Mimosius       Note Added: 0010252                          
======================================================================
