From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001416]: Spinlock conflict causes kernel panic with Vortex2 and Wine
Date: Thu, 9 Feb 2006 09:43:32 +0100
Message-ID: <85e5ef301d3fe45b61e91b5e2862779f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B1F871C8
	for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2006 09:43:32 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1416> 
======================================================================
Reported By:                mortrek
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   1416
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 4
Kernel Version:             2.6.12-1.1447
======================================================================
Date Submitted:             09-14-2005 06:05 CEST
Last Modified:              02-09-2006 09:43 CET
======================================================================
Summary:                    Spinlock conflict causes kernel panic with Vortex2
and Wine
Description: 
When attempting to run Wine (binary or self-compiled) the system freezes.
Dmesg gives the following:
[<c0103a61>] syscall_call+0x7/0xb
[<c0193cde>] sys_ioctl+0x5d/0x6b
[<c0193b27>] vfs_ioctl+0x50/0x1aa
[<c01939f9>] do_ioctl+0x19/0x55
[<f89bbe49>] snd_pcm_oss_ioctl+0x0/0x477 [snd_pcm_oss]
[<f89bc19b>] snd_pcm_oss_ioctl+0x352/0x477 [snd_pcm_oss]
[<f89bac1d>] snd_pcm_oss_get_channels+0xa/0x1e [snd_pcm_oss]
[<f89b9d90>] snd_pcm_oss_get_active_substream+0x43/0x4c [snd_pcm_oss]
[<f89b99bc>] snd_pcm_oss_change_params+0x365/0x6f6 [snd_pcm_oss]
[<f89a6c31>] snd_pcm_kernel_capture_ioctl+0x18/0x1e [snd_pcm]
[<f89a6a25>] snd_pcm_capture_ioctl1+0x2c/0x1cc [snd_pcm]
[<f89a1665>] snd_pcm_hw_params_user+0x50/0x6d [snd_pcm]
[<f89a9963>] _snd_pcm_hw_param_first+0x109/0x12a [snd_pcm]
[<f89a9cdc>] _snd_pcm_hw_param_min+0x152/0x15e [snd_pcm]
[<f89a1543>] snd_pcm_hw_params+0x331/0x403 [snd_pcm]
[<f8a09889>] snd_vortex_pcm_hw_free+0x132/0x1f1 [snd_au8830]
[<c0120d38>] panic+0x45/0x1e2
<010>
Kernel panic - not syncing: sound/pci/au88x0/au88x0_pcm.c:257:
spin_lock(sound/pci/au88x0/au88x0_core.c:f6437b98) already locked by
sound/pci/au88x0/au88x0_pcm.c/209. (Tainted: P     )

======================================================================

----------------------------------------------------------------------
 rlrevell - 09-14-05 22:23 
----------------------------------------------------------------------
(Tainted: P )

Looks like you loaded a proprietary module.  Just FYI, most kernel
developers ignore bug reports from tainted kernels.

----------------------------------------------------------------------
 Raymond - 02-09-06 09:43 
----------------------------------------------------------------------
May be the panic caused by the wrong number of capture channels reported by
the driver ?

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1766

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-14-05 06:05 mortrek        New Issue                                    
09-14-05 06:05 mortrek        Distribution              => Fedora Core 4   
09-14-05 06:05 mortrek        Kernel Version            => 2.6.12-1.1447   
09-14-05 13:33 Raymond        Note Added: 0006157                          
09-14-05 22:23 rlrevell       Note Added: 0006187                          
01-05-06 20:28 shurick        Issue Monitored: shurick                     
02-09-06 09:43 Raymond        Note Added: 0007974                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
