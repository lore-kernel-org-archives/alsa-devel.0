From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002132]: No sound from speakers
Date: Tue, 20 Jun 2006 05:02:53 +0200
Message-ID: <4ed343a61038eac7fa68891b4cb1cff5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 814C916D
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jun 2006 05:02:53 +0200 (MEST)
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
Last Modified:              06-20-2006 05:02 CEST
======================================================================
Summary:                    No sound from speakers
Description: 
Alsa seems to detect the sound card, but when I try to actually play
something there is no sound from the speakers.
======================================================================

----------------------------------------------------------------------
 Raymond - 06-16-06 04:31 
----------------------------------------------------------------------
Since ens137x does not support modem, those controls of "Caller ID" and
"off hook" will not be created when you add AC97_SCAP_SKIP_MODEM

	ac97.scaps = AC97_SCAP_AUDIO | AC97_SCAP_SKIP_MODEM;
	if ((err = snd_ac97_mixer(pbus, &ac97, &ensoniq->u.es1371.ac97)) < 0)

----------------------------------------------------------------------
 bzbarsky - 06-20-06 05:02 
----------------------------------------------------------------------
Raymond, were those last two comments addressed to me?  If so, and if you
want me to try something, could you please explain in a little more
detail?  I'm not particularly familiar with either the ALSA codebase or
ALSA configuration, so I'm really not sure what I need to do with those
two comments, if anything.  Thank you in advance for your time!

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
06-12-06 04:36 bzbarsky       Note Added: 0010161                          
06-12-06 05:18 Raymond        Note Added: 0010164                          
06-12-06 05:20 Raymond        Note Edited: 0010164                         
06-12-06 05:23 Raymond        Note Edited: 0010164                         
06-12-06 05:23 Raymond        Note Edited: 0010164                         
06-12-06 05:26 rlrevell       Note Added: 0010165                          
06-12-06 13:23 Raymond        Note Added: 0010168                          
06-12-06 18:12 bzbarsky       Note Added: 0010172                          
06-13-06 04:43 Raymond        Note Added: 0010185                          
06-13-06 04:45 Raymond        Note Edited: 0010185                         
06-13-06 05:39 bzbarsky       Note Added: 0010187                          
06-13-06 07:20 Raymond        Note Added: 0010190                          
06-13-06 07:25 Raymond        Note Edited: 0010190                         
06-14-06 05:00 Raymond        Note Added: 0010204                          
06-15-06 02:16 bzbarsky       Note Added: 0010220                          
06-15-06 02:27 bzbarsky       Note Edited: 0010220                         
06-15-06 02:36 Raymond        Note Added: 0010223                          
06-15-06 02:53 Raymond        Note Added: 0010225                          
06-15-06 02:59 bzbarsky       Note Added: 0010226                          
06-15-06 03:03 Raymond        Note Edited: 0010225                         
06-15-06 03:19 Raymond        Note Added: 0010227                          
06-15-06 03:53 rlrevell       Note Added: 0010228                          
06-15-06 03:55 rlrevell       Note Added: 0010229                          
06-15-06 04:19 bzbarsky       Note Added: 0010231                          
06-15-06 05:54 Raymond        Note Added: 0010232                          
06-15-06 05:57 Raymond        Note Edited: 0010232                         
06-15-06 05:59 Raymond        Note Edited: 0010232                         
06-15-06 06:02 Raymond        Note Edited: 0010232                         
06-15-06 08:06 bzbarsky       Note Added: 0010234                          
06-15-06 08:59 Raymond        Note Added: 0010235                          
06-15-06 09:09 Raymond        Note Edited: 0010235                         
06-15-06 17:07 rlrevell       Note Added: 0010239                          
06-16-06 03:53 Raymond        Note Added: 0010247                          
06-16-06 03:56 Raymond        Note Edited: 0010247                         
06-16-06 04:10 Raymond        Note Edited: 0010247                         
06-16-06 04:31 Raymond        Note Added: 0010248                          
06-20-06 05:02 bzbarsky       Note Added: 0010326                          
======================================================================
