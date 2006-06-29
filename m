From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001416]: Spinlock conflict causes
	kernel panic with Vortex2 and Wine
Date: Thu, 29 Jun 2006 03:03:31 +0200
Message-ID: <64d79f3ae40d887687f91efd56d26b84@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A53BF28B
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jun 2006 03:03:31 +0200 (MEST)
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
Last Modified:              06-29-2006 03:03 CEST
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
 Raymond - 06-29-06 03:03 
----------------------------------------------------------------------
enable OSS_DEBUG in core/oss/pcm_oss.c 

need to find out

[<f89bbe49>] snd_pcm_oss_ioctl+0x0/0x477 [snd_pcm_oss]
[<f89bc19b>] snd_pcm_oss_ioctl+0x352/0x477 [snd_pcm_oss]

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
06-28-06 12:00 Raymond        Note Deleted: 0007974                        
06-29-06 03:03 Raymond        Note Added: 0010636                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
