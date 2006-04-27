From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002079]: Kernel Ooops with firefox, xmms and dmix
Date: Thu, 27 Apr 2006 16:48:33 +0200
Message-ID: <64718596900fb57663b6f2b05787188f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 949A8172
	for <alsa-devel@alsa-project.org>; Thu, 27 Apr 2006 16:48:33 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2079> 
======================================================================
Reported By:                ZaphodB
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2079
Category:                   CORE - pcm
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Debain GNU/Linux unstable/experimental current
Kernel Version:             2.6.17-rc1-mm2
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             04-27-2006 16:40 CEST
Last Modified:              04-27-2006 16:48 CEST
======================================================================
Summary:                    Kernel Ooops with firefox, xmms and dmix
Description: 
A google video was on pause in firefox. As i hit play in xmms i got the
following kernel trace. firefox is default debian build and xmms is using
alsa playback. .asoundrc is attached.

divide error: 0000 [#1]
PREEMPT SMP
last sysfs file: /devices/platform/i2c-9191/9191-0290/temp3_type
Modules linked in: i915 drm intelfb fb cfbcopyarea cfbimgblt cfbfillrect
parport_pc lp parport ipt_REJECT xt_state ip_conntrack nfnetlink ipt_LOG
xt_limit xt_tcpudp iptable_filter ip_tables x_tables ipv6 pcspkr
snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm
snd_timer snd soundcore snd_page_alloc intel_agp agpgart ehci_hcd uhci_hcd
dm_mod w83627hf hwmon_vid hwmon i2c_i801 i2c_isa eeprom i2c_core
capability commoncap e1000
CPU:    0
EIP:    0060:[<e0204168>]    Not tainted VLI
EFLAGS: 00010246   (2.6.17-rc1-mm2 #2)
EIP is at snd_pcm_oss_ioctl+0x9e2/0xa2c [snd_pcm_oss]
eax: 00000000   ebx: bfe0d3a0   ecx: 00000000   edx: 00000000
esi: 00000000   edi: ca1c3400   ebp: df40f0c0   esp: cc7d7f40
ds: 007b   es: 007b   ss: 0068
Process firefox-bin (pid: 29846, threadinfo=cc7d6000 task=c089e550)
Stack: <0>00000000 c030bf00 00000000 00000004 00000000 00000000 00000f1b
e0203786
       cc5a7b40 bfe0d3a0 8010500c c01733ff d7bdc84c d312ec78 cc5a7b40
00000035
       cc7d6000 c017349d cc7d7fa8 4450d442 00000000 cc5a7b40 bfe0d3a0
cc7d6000
Call Trace:
 <e0203786> snd_pcm_oss_ioctl+0x0/0xa2c [snd_pcm_oss]   <c01733ff>
do_ioctl+0x1f/0x6d
 <c017349d> vfs_ioctl+0x50/0x28b   <c0173735> sys_ioctl+0x5d/0x6c
 <c02fb07f> sysenter_past_esp+0x54/0x75   <c02f007b>
inet6_hash_connect+0x2d/0x552
Code: 29 c8 89 44 24 18 8b b7 64 02 00 00 f7 de 89 d0 85 d2 0f 88 71 f6 ff
ff 8b 54 24 18 89 e8 e8 c7 de ff ff 01 f0 89 44 24 14 31 d2 <f7> b7 44 02
00 00 89 44 24 08 e9 62 fa ff ff 89 e8 e8 2c df ff
EIP: [<e0204168>] snd_pcm_oss_ioctl+0x9e2/0xa2c [snd_pcm_oss] SS:ESP
0068:cc7d7f40
======================================================================

----------------------------------------------------------------------
 ZaphodB - 04-27-06 16:44 
----------------------------------------------------------------------
is reproducable.

divide error: 0000 [#2]
PREEMPT SMP
last sysfs file: /devices/platform/i2c-9191/9191-0290/temp3_type
Modules linked in: i915 drm intelfb fb cfbcopyarea cfbimgblt cfbfillrect
parport_pc lp parport ipt_REJECT xt_state ip_conntrack nfnetlink ipt_LOG
xt_limit xt_tcpudp iptable_filter ip_tables x_tables ipv6 pcspkr
snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm
snd_timer snd soundcore snd_page_alloc intel_agp agpgart ehci_hcd uhci_hcd
dm_mod w83627hf hwmon_vid hwmon i2c_i801 i2c_isa eeprom i2c_core
capability commoncap e1000
CPU:    1
EIP:    0060:[<e0204168>]    Not tainted VLI
EFLAGS: 00010246   (2.6.17-rc1-mm2 #2)
EIP is at snd_pcm_oss_ioctl+0x9e2/0xa2c [snd_pcm_oss]
eax: 00000000   ebx: bfcb13b0   ecx: 00000000   edx: 00000000
esi: 00000000   edi: d93a2c00   ebp: df40f0c0   esp: cee11f40
ds: 007b   es: 007b   ss: 0068
Process firefox-bin (pid: 31271, threadinfo=cee10000 task=c47ee000)
Stack: <0>00000000 00000000 00000000 00000004 00000000 00000000 000009c0
e0203786
       d54ff2c0 bfcb13b0 8010500c c01733ff dcb307c8 d312ec78 d54ff2c0
00000031
       cee10000 c017349d cee11fa8 4450d804 00000000 d54ff2c0 bfcb13b0
cee10000
Call Trace:
 <e0203786> snd_pcm_oss_ioctl+0x0/0xa2c [snd_pcm_oss]   <c01733ff>
do_ioctl+0x1f/0x6d
 <c017349d> vfs_ioctl+0x50/0x28b   <c0173735> sys_ioctl+0x5d/0x6c
 <c02fb07f> sysenter_past_esp+0x54/0x75   <c02f007b>
inet6_hash_connect+0x2d/0x552
Code: 29 c8 89 44 24 18 8b b7 64 02 00 00 f7 de 89 d0 85 d2 0f 88 71 f6 ff
ff 8b 54 24 18 89 e8 e8 c7 de ff ff 01 f0 89 44 24 14 31 d2 <f7> b7 44 02
00 00 89 44 24 08 e9 62 fa ff ff 89 e8 e8 2c df ff
EIP: [<e0204168>] snd_pcm_oss_ioctl+0x9e2/0xa2c [snd_pcm_oss] SS:ESP
0068:cee11f40

----------------------------------------------------------------------
 tiwai - 04-27-06 16:48 
----------------------------------------------------------------------
It's a known bug in 2.6.17rc1.  Already fixed in the recent rc.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-27-06 16:40 ZaphodB        New Issue                                    
04-27-06 16:40 ZaphodB        File Added: asoundrc                         
04-27-06 16:40 ZaphodB        Distribution              => Debain GNU/Linux
unstable/experimental current
04-27-06 16:40 ZaphodB        Kernel Version            => 2.6.17-rc1-mm2  
04-27-06 16:44 ZaphodB        Note Added: 0009531                          
04-27-06 16:45 ZaphodB        Issue Monitored: ZaphodB                     
04-27-06 16:48 tiwai          Status                   new => resolved     
04-27-06 16:48 tiwai          Resolution               open => fixed       
04-27-06 16:48 tiwai          Assigned To               => tiwai           
04-27-06 16:48 tiwai          Note Added: 0009532                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
