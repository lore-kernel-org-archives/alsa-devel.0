From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002132]: No sound from speakers
Date: Mon, 12 Jun 2006 03:41:07 +0200
Message-ID: <60d12ab5b3c3e6e6986392721226888a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 925B0148
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Jun 2006 03:41:07 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2132> 
======================================================================
Reported By:                bzbarsky
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2132
Category:                   PCI - ens1371
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 4
Kernel Version:             2.6.15
======================================================================
Date Submitted:             05-17-2006 19:54 CEST
Last Modified:              06-12-2006 03:41 CEST
======================================================================
Summary:                    No sound from speakers
Description: 
Alsa seems to detect the sound card, but when I try to actually play
something there is no sound from the speakers.
======================================================================

----------------------------------------------------------------------
 Raymond - 06-12-06 03:31 
----------------------------------------------------------------------
Successive read of codec registers seem delayed

codec read 7c : 807c4e53
codec read 7e : 807c4e53    <-- 7e4300
codec write 00 = 0000
codec write 3c = 0000
codec read 00 : 80000d50
codec read 7c : 80000d50    <-- 7c4e53
codec read 7e : 807c4e53    <-- 7e4300
codec read 7c : 807e4300    <-- 7c5e53
codec read 7e : 807c4e53    <-- 7e4300
codec read 00 : 807e4300    <-- 000d50
codec read 28 : 80000d50    <-- 280001
codec read 3c : 80280001

What is the purpose of adding cond_resched() in
snd_es1371_wait_src_ready() ?

http://hg-mirror.alsa-project.org/alsa-kernel?cmd=changeset;node=48487b6ce515;style=gitweb

----------------------------------------------------------------------
 rlrevell - 06-12-06 03:41 
----------------------------------------------------------------------
Same as any cond_resched() - so that other processes are not excessively
delayed on !PREEMPT kernels.

It seems that the reads need to be throttled.  Try replacing cond_resched
with msleep.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-17-06 19:54 bzbarsky       New Issue                                    
05-17-06 19:54 bzbarsky       File Added: lspci.txt                        
05-17-06 19:54 bzbarsky       Distribution              => Fedora Core 4   
05-17-06 19:54 bzbarsky       Kernel Version            => 2.6.15          
05-17-06 19:55 bzbarsky       File Added: lspci-n.txt                      
05-17-06 19:55 bzbarsky       Issue Monitored: bzbarsky                    
05-17-06 19:56 bzbarsky       File Added: scsound.log                      
05-17-06 19:57 bzbarsky       Note Added: 0009857                          
05-20-06 05:31 Raymond        Note Added: 0009882                          
05-20-06 21:43 bzbarsky       Note Added: 0009893                          
05-21-06 03:41 Raymond        Note Added: 0009894                          
05-21-06 03:48 Raymond        Note Edited: 0009894                         
05-22-06 02:47 bzbarsky       File Added: ac97#0-0                         
05-22-06 02:48 bzbarsky       File Added: ac97#0-0+regs                    
05-22-06 02:53 bzbarsky       Note Added: 0009901                          
05-22-06 04:14 Raymond        Note Added: 0009902                          
05-23-06 09:00 Raymond        Note Added: 0009929                          
05-23-06 09:03 Raymond        Note Edited: 0009929                         
05-23-06 09:07 Raymond        Note Edited: 0009929                         
06-02-06 20:08 bzbarsky       Note Added: 0010053                          
06-02-06 20:09 bzbarsky       File Added: scsound-1.0.11.log                    
06-02-06 20:09 bzbarsky       File Added: ac97#0-0-1.0.11                    
06-02-06 20:10 bzbarsky       File Added: ac97#0-0+regs-1.0.11                  
 
06-02-06 20:35 bzbarsky       Note Added: 0010054                          
06-03-06 02:44 Raymond        Note Added: 0010058                          
06-05-06 01:29 bzbarsky       Note Added: 0010066                          
06-05-06 03:31 Raymond        Note Added: 0010067                          
06-05-06 03:56 bzbarsky       File Added: dmesg                            
06-05-06 03:57 bzbarsky       Note Added: 0010068                          
06-06-06 06:35 Raymond        Note Added: 0010071                          
06-06-06 06:43 Raymond        Note Edited: 0010071                         
06-06-06 08:59 Raymond        Note Edited: 0010071                         
06-10-06 07:42 bzbarsky       Note Added: 0010144                          
06-11-06 05:24 Raymond        Note Added: 0010150                          
06-11-06 05:29 Raymond        Note Edited: 0010150                         
06-11-06 22:37 bzbarsky       File Added: dmesg+kprint                     
06-11-06 22:37 bzbarsky       File Added: codec_lines.txt                    
06-11-06 22:38 bzbarsky       Note Added: 0010154                          
06-12-06 03:31 Raymond        Note Added: 0010157                          
06-12-06 03:41 rlrevell       Note Added: 0010158                          
======================================================================
