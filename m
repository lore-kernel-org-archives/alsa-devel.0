From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0002188]: Alsa mixer lack of some
	functions
Date: Sun, 2 Jul 2006 04:14:36 +0200
Message-ID: <70ae39345753ca9c23659ca4cf4f7ad7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0A55423A
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Jul 2006 04:14:37 +0200 (MEST)
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
Last Modified:              07-02-2006 04:14 CEST
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
 rlrevell - 06-30-06 17:15 
----------------------------------------------------------------------
Re: http://bugs.kde.org/show_bug.cgi?id=125772

I don't really know how to help them, other than telling them to look at
the alsamixer source.

----------------------------------------------------------------------
 Raymond - 07-02-06 04:14 
----------------------------------------------------------------------
Refer to KDE bug 

Sound Card: VIA 8235
Chip: AD1980 

This duplicate of stereo is supported by ad1980 only if the alsa developer
add patch to add a control to enable this feature.

Miscellaneous Control Registers ( index 76h )

SPRD
SPREAD Enable. This bit enables spreading of 2-channel media to all six
output channels. This function is implemented in the analog section by
using the output selector controls line for the center/LFE, surround, and
Line_out output channels.

It is possible only if ca0106 has this kind of feature

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
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
