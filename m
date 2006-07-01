From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0001979]: Missing symbols in oss mixer
	code
Date: Sat, 1 Jul 2006 17:20:08 +0200
Message-ID: <81573f24e2c718272d0d157c5fc08244@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DED96243
	for <alsa-devel@alsa-project.org>;
	Sat,  1 Jul 2006 17:20:08 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1979> 
======================================================================
Reported By:                zx80user
Assigned To:                
======================================================================
Project:                    ALSA - liboss
Issue ID:                   1979
Category:                   
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             03-29-2006 23:03 CEST
Last Modified:              07-01-2006 17:20 CEST
======================================================================
Summary:                    Missing symbols in oss mixer code
Description: 
Attempting to load the snd-pcm-oss module and the snd-pcm-mixer modules
fails due to missing symbols.


======================================================================

----------------------------------------------------------------------
 zx80user - 03-29-06 23:05 
----------------------------------------------------------------------
/ # modprobe snd-pcm-oss
snd_mixer_oss: Unknown symbol snd_mixer_oss_notify_callback
WARNING: Error inserting snd_mixer_oss
(/lib/modules/2.6.15-sh/kernel/sound/core/oss/snd-mixer-oss.ko): Unknown
symbol in module, or unknown parameter (see )snd_pcm_oss: Unknown symbol
snd_mixer_oss_ioctl_card
FATAL: Error inserting snd_pcm_oss
(/lib/modules/2.6.15-sh/kernel/sound/core/oss/snd-pcm-oss.ko): Unknown
symbol in module, or unknown parameter (see dmesg)
/ # modprobe snd-mixer-oss
snd_mixer_oss: Unknown symbol snd_mixer_oss_notify_callback
FATAL: Error inserting snd_mixer_oss
(/lib/modules/2.6.15-sh/kernel/sound/core/oss/snd-mixer-oss.ko): Unknown
symbol in module, or unknown parameter (see dm)

----------------------------------------------------------------------
 Adrian Bunk - 07-01-06 17:20 
----------------------------------------------------------------------
Did you complie and install the kernel, and added the module to your kernel
configuration later?

In this case, your problem is expected since adding this module requires
loading the rebuilt snd module or (if ALSA is compiled statically into the
kernel) booting into the rebuilt kernel.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-29-06 23:03 zx80user       New Issue                                    
03-29-06 23:04 zx80user       Issue Monitored: zx80user                    
03-29-06 23:05 zx80user       Note Added: 0009019                          
03-30-06 10:00 Raymond        Note Added: 0009024                          
04-01-06 17:20 Raymond        Note Added: 0009056                          
04-02-06 05:16 Raymond        Note Added: 0009057                          
04-02-06 05:26 Raymond        Note Edited: 0009057                         
04-03-06 08:46 Raymond        Note Added: 0009088                          
06-10-06 14:08 Raymond        Note Deleted: 0009088                        
06-10-06 14:08 Raymond        Note Deleted: 0009057                        
06-10-06 14:09 Raymond        Note Deleted: 0009024                        
06-10-06 14:10 Raymond        Note Deleted: 0009056                        
07-01-06 17:20 Adrian Bunk    Note Added: 0010762                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
