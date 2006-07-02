From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0002188]: Alsa mixer lack of some
	functions
Date: Sun, 2 Jul 2006 14:37:49 +0200
Message-ID: <3d275e6654881f8cc1da71bcfbc01a41@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DB8F919D
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Jul 2006 14:37:49 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2188> 
======================================================================
Reported By:                Cimmo
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   2188
Category:                   alsamixer
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             06-07-2006 16:56 CEST
Last Modified:              07-02-2006 14:37 CEST
======================================================================
Summary:                    Alsa mixer lack of some functions
Description: 
Is it possible to add to the alsa-mixer the possibility to change these
things:

- dolby surround configurations: 2.0, 2.1, 4.0, 4.1, 5.1, 7.1 and the
possibility to duplicate front sound to the rear speakers.
- modify high and basses

best things is changes are immediatelly available without relogging.
These feature are missing to linux community that have always to trouble
with configuration files.

thanx for attention
Marco
======================================================================

----------------------------------------------------------------------
 Raymond - 07-02-06 14:25 
----------------------------------------------------------------------
Why do the 'Digital Capture Source' appear in Playback view instead of
Capture view of alsamixer ? May be you need to file another bug report for
this issue 

Refer to oss_mixer, It is unlikely for you to run any oss application
which control volume through oss mixer api since "MASTER" control is
missing.

----------------------------------------------------------------------
 Cimmo - 07-02-06 14:37 
----------------------------------------------------------------------
It's called 'Capture feedback' should stay in capture?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-07-06 16:56 Cimmo          New Issue                                    
06-08-06 02:52 Raymond        Note Added: 0010104                          
06-08-06 11:22 Cimmo          Note Added: 0010111                          
06-09-06 07:08 Raymond        Note Added: 0010134                          
06-09-06 11:20 Cimmo          Note Added: 0010139                          
06-24-06 10:39 Cimmo          Note Added: 0010471                          
06-24-06 17:04 rlrevell       Note Added: 0010476                          
06-24-06 17:11 Cimmo          Note Added: 0010477                          
06-24-06 17:20 rlrevell       Note Added: 0010478                          
06-24-06 18:01 Cimmo          File Added: alsa                             
06-24-06 18:02 Cimmo          Note Added: 0010479                          
06-24-06 18:11 rlrevell       Note Added: 0010480                          
06-24-06 18:26 Cimmo          Note Added: 0010482                          
06-24-06 18:33 rlrevell       Note Added: 0010483                          
06-24-06 18:37 Cimmo          File Added: alsa-test                        
06-24-06 18:38 Cimmo          Note Added: 0010484                          
06-24-06 18:55 rlrevell       Note Added: 0010485                          
06-24-06 19:05 Cimmo          Note Added: 0010486                          
06-24-06 19:17 rlrevell       Note Added: 0010487                          
06-25-06 04:32 Raymond        Note Added: 0010498                          
06-25-06 04:33 Raymond        Note Edited: 0010498                         
06-25-06 12:16 Cimmo          File Added: alsamixer.png                    
06-25-06 12:18 Cimmo          Note Added: 0010506                          
06-25-06 12:20 Cimmo          Note Edited: 0010506                         
06-25-06 14:05 Raymond        Note Added: 0010508                          
06-25-06 14:46 Cimmo          File Added: pcm                              
06-25-06 14:46 Cimmo          File Added: cards                            
06-25-06 14:47 Cimmo          Note Added: 0010509                          
06-25-06 15:24 Raymond        Note Added: 0010511                          
06-25-06 15:26 Raymond        Note Edited: 0010511                         
06-25-06 15:32 Cimmo          Note Added: 0010512                          
06-25-06 18:29 Cimmo          Note Edited: 0010512                         
06-25-06 18:30 Cimmo          Note Edited: 0010512                         
06-25-06 18:32 Cimmo          Note Edited: 0010512                         
06-27-06 09:01 Raymond        Note Added: 0010569                          
06-27-06 09:29 Raymond        Note Edited: 0010569                         
06-27-06 18:56 Cimmo          Note Added: 0010597                          
06-27-06 19:07 rlrevell       Note Added: 0010598                          
06-28-06 04:25 Raymond        Note Added: 0010606                          
06-28-06 04:33 rlrevell       Note Added: 0010607                          
06-28-06 10:45 Cimmo          Note Added: 0010612                          
06-28-06 10:46 Cimmo          Note Edited: 0010612                         
06-28-06 16:15 rlrevell       Note Added: 0010619                          
06-28-06 16:36 Cimmo          Note Added: 0010621                          
06-28-06 17:30 rlrevell       Note Added: 0010623                          
06-30-06 11:05 Cimmo          Note Added: 0010725                          
06-30-06 12:06 Cimmo          Note Added: 0010726                          
06-30-06 12:18 Raymond        Note Added: 0010727                          
06-30-06 12:24 Cimmo          Note Added: 0010728                          
06-30-06 13:04 Raymond        Note Added: 0010729                          
06-30-06 13:07 Raymond        Note Edited: 0010729                         
06-30-06 13:08 Raymond        Note Edited: 0010729                         
06-30-06 13:24 Raymond        Note Added: 0010731                          
06-30-06 13:40 Cimmo          Note Added: 0010732                          
06-30-06 15:04 Raymond        Note Added: 0010736                          
06-30-06 16:14 rlrevell       Note Added: 0010737                          
06-30-06 16:42 Cimmo          Note Added: 0010741                          
06-30-06 16:50 rlrevell       Note Added: 0010742                          
06-30-06 17:04 Cimmo          Note Added: 0010743                          
06-30-06 17:09 Cimmo          Note Edited: 0010743                         
06-30-06 17:11 Cimmo          Note Edited: 0010743                         
06-30-06 17:11 rlrevell       Note Added: 0010744                          
06-30-06 17:15 rlrevell       Note Added: 0010745                          
07-02-06 04:14 Raymond        Note Added: 0010769                          
07-02-06 04:24 Raymond        Note Edited: 0010769                         
07-02-06 04:38 Raymond        Note Added: 0010770                          
07-02-06 05:13 Raymond        Note Added: 0010771                          
07-02-06 11:19 Cimmo          File Added: test.state                       
07-02-06 11:19 Cimmo          Note Added: 0010774                          
07-02-06 11:47 Raymond        Note Added: 0010776                          
07-02-06 12:07 Cimmo          File Added: amixer                           
07-02-06 12:08 Cimmo          Note Added: 0010777                          
07-02-06 12:23 Raymond        Note Added: 0010778                          
07-02-06 12:25 Raymond        Note Edited: 0010778                         
07-02-06 12:28 Cimmo          Note Added: 0010779                          
07-02-06 12:29 Cimmo          Note Edited: 0010779                         
07-02-06 12:30 Cimmo          Note Edited: 0010779                         
07-02-06 12:30 Cimmo          Note Edited: 0010779                         
07-02-06 12:45 Raymond        Note Added: 0010780                          
07-02-06 12:50 Raymond        Note Edited: 0010780                         
07-02-06 12:58 Cimmo          Note Added: 0010781                          
07-02-06 12:59 Raymond        Note Added: 0010782                          
07-02-06 13:04 Raymond        Note Edited: 0010782                         
07-02-06 13:17 Cimmo          File Added: oss_mixer                        
07-02-06 14:05 Raymond        Note Added: 0010783                          
07-02-06 14:15 Cimmo          File Added: alsamixer-capture.png                 
  
07-02-06 14:15 Cimmo          Note Added: 0010784                          
07-02-06 14:25 Raymond        Note Added: 0010785                          
07-02-06 14:37 Cimmo          Note Added: 0010786                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
