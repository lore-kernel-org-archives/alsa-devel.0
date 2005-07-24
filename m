From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001274]: alc655: low volume
Date: Sun, 24 Jul 2005 22:19:01 +0200
Message-ID: <62e8c0b5e55000fef4262f4f390a3a69@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A4C6616D
	for <alsa-devel@alsa-project.org>; Sun, 24 Jul 2005 22:19:01 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1274> 
======================================================================
Reported By:                vitja
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1274
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             07-22-2005 10:46 CEST
Last Modified:              07-24-2005 22:19 CEST
======================================================================
Summary:                    alc655: low volume
Description: 
I have ATI IXP400 sound in my notebook. codec is realtek's alc655. The
problem is I couldn't hear anything from internal speaker. When I plug
earphones in I hear very-very low music signal, so driver actually works
but. By the way under xp with realtek's drivers thats all right.. Is there
a way to see dump of ac97's registers under xp? May be XP driver uses some
proprietary features of alc655?
======================================================================

----------------------------------------------------------------------
 vitja - 07-24-05 22:19 
----------------------------------------------------------------------
temporarily solution:
I hop this will help

cat > /proc/asound/IXP/codec97#0/ac97#0-0+regs <<EOF
00 0000
02 0a0a
04 0000
06 8000
08 0000
0a 0000
0c 8008
0e 8008
10 8808
12 8808
14 0000
16 8808
18 8808
1a 0000
1c 8000
1e 0000
20 0400
22 0000
24 0000
26 000f
28 09c4
2a 05f0
2c bb80
2e bb80
30 bb80
32 bb80
34 0000
36 8080
38 8080
3a 2000
3c 0000
3e 0000
40 0000
42 0000
44 0000
46 0000
48 0000
4a 0000
4c 0000
4e 0000
50 0000
52 0000
54 0000
56 0000
58 0000
5a 0000
5c 0000
5e 0000
60 0000
62 0000
64 0808
66 0808
68 0aea
6a 0040
6c 0000
6e 0025
70 81e0
72 22e8
74 8000
76 0000
78 0007
7a 2090
7c 414c
7e 4760
EOF

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-22-05 10:46 vitja          New Issue                                    
07-22-05 20:32 vitja          File Added: codec                            
07-24-05 22:19 vitja          Note Added: 0005560                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
