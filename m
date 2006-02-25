From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001878]: SIGSEGV in snd_pcm_rate_drain
Date: Sat, 25 Feb 2006 14:08:05 +0100
Message-ID: <7747676dbf9a553ef7fd97a13e40e1bf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2A3C01BA
	for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2006 14:08:06 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1878> 
======================================================================
Reported By:                Faust3
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1878
Category:                   CORE - pcm
Reproducibility:            sometimes
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-25-2006 14:08 CET
Last Modified:              02-25-2006 14:08 CET
======================================================================
Summary:                    SIGSEGV in snd_pcm_rate_drain
Description: 
Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread -1217157440 (LWP 13093)]
0xb7e809b6 in snd_pcm_area_copy (dst_area=0x86b58c8, dst_offset=0,
src_area=0x86b5508, src_offset=4096, samples=4294964224,
format=SND_PCM_FORMAT_S16_LE) at pcm.c:2551
2551                            *(u_int16_t*)dst = *(const
u_int16_t*)src;
(gdb) bt
#0  0xb7e809b6 in snd_pcm_area_copy (dst_area=0x86b58c8, dst_offset=0,
src_area=0x86b5508, src_offset=4096, samples=4294964224,
format=SND_PCM_FORMAT_S16_LE)
    at pcm.c:2551
#1  0xb7e80c53 in snd_pcm_areas_copy (dst_areas=0x86b58c8, dst_offset=0,
src_areas=0x86b5514, src_offset=4096, channels=2, frames=4294964224,
    format=SND_PCM_FORMAT_S16_LE) at pcm.c:2650
#2  0xb7e95d84 in snd_pcm_rate_commit_area (pcm=0x86b71d0, rate=0x86b7118,
appl_offset=10752, size=11636, slave_size=17360) at pcm_rate.c:1067
#3  0xb7e9653d in snd_pcm_rate_drain (pcm=0x86b71d0) at pcm_rate.c:1306
#4  0xb7e771d2 in snd_pcm_drain (pcm=0x86b5940) at pcm.c:1057
#5  0x080c9068 in uninit (immed=0) at ao_alsa.c:658
#6  0x0807353d in uninit_player (mask=3659) at mplayer.c:485
#7  0x08077d16 in main (argc=5, argv=0xbfb775b4) at mplayer.c:4488


Problem seems to be that cont=4096 and period_size=1024
in snd_pcm_rate_commit_area just before calling snd_pcm_areas_copy.
With cont being unsigned the following calculation will overflow          
    
cont = rate->gen.slave->period_size - cont;
slave_frames = cont;

Tell me if you need more info.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-25-06 14:08 Faust3         New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
