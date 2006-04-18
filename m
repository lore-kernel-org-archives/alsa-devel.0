From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002029]: Cannot compile pcm/pcm_direct.c
Date: Tue, 18 Apr 2006 13:39:40 +0200
Message-ID: <6cc38314bd4c493e7163e2cc2246c8cb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DA8451A7
	for <alsa-devel@alsa-project.org>; Tue, 18 Apr 2006 13:39:40 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2029> 
======================================================================
Reported By:                croiset
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   2029
Category:                   0_general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             04-18-2006 11:26 CEST
Last Modified:              04-18-2006 13:39 CEST
======================================================================
Summary:                    Cannot compile pcm/pcm_direct.c
Description: 
It is impossible to compile pcm/pcm_direct.c.

I have this error :
then mv -f ".deps/pcm_direct.Tpo" ".deps/pcm_direct.Plo"; else rm -f
".deps/pcm
_direct.Tpo"; exit 1; fi
 i386-redhat-linux-gcc -DHAVE_CONFIG_H -I. -I. -I../../include
-I../../include
-O2 -march=i386 -mcpu=i686 -MT pcm_direct.lo -MD -MP -MF
.deps/pcm_direct.Tpo -
c pcm_direct.c  -fPIC -DPIC -o .libs/pcm_direct.o
pcm_direct.c: In function `snd_pcm_direct_parse_open_conf':
pcm_direct.c:1418: parse error before `const'
pcm_direct.c:1419: `id' undeclared (first use in this function)
pcm_direct.c:1419: (Each undeclared identifier is reported only once
pcm_direct.c:1419: for each function it appears in.)
make[2]: *** [pcm_direct.lo] Erreur 1
make[2]: Quitte le répertoire
`/home/redhat/BUILD/alsa-lib-1.0.11rc5/src/pcm'
make[1]: *** [all-recursive] Erreur 1
make[1]: Quitte le répertoire `/home/redhat/BUILD/alsa-lib-1.0.11rc5/src'
make: *** [all-recursive] Erreur 1

======================================================================

----------------------------------------------------------------------
 tiwai - 04-18-06 13:39 
----------------------------------------------------------------------
Fixed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-18-06 11:26 croiset        New Issue                                    
04-18-06 13:39 tiwai          Status                   new => resolved     
04-18-06 13:39 tiwai          Resolution               open => fixed       
04-18-06 13:39 tiwai          Assigned To               => tiwai           
04-18-06 13:39 tiwai          Note Added: 0009330                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
