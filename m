From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001224]: artsd-like style
Date: Fri, 2 Sep 2005 20:24:59 +0200
Message-ID: <fe9f58cf4868ed60e9651f1b191878b7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 25D76175
	for <alsa-devel@alsa-project.org>; Fri,  2 Sep 2005 20:25:00 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1224> 
======================================================================
Reported By:                Hetfield
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1224
Category:                   PCI - ens1370
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.x
======================================================================
Date Submitted:             07-01-2005 14:49 CEST
Last Modified:              09-02-2005 20:24 CEST
======================================================================
Summary:                    artsd-like style
Description: 
i'd like to know if that's a roadmap to let alsa drivers have a artsd (or
windows) style, i mean, multiple streams at once.

that could be very important for example using skype voip and listening
music at the same time.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001228 Skype Does not work with aoss
======================================================================

----------------------------------------------------------------------
 Hetfield - 09-02-05 20:22 
----------------------------------------------------------------------
do you mean 1.0.10rc1?

i have 2.6.13 kernel with alsa builtin, do i need to update to lastest
-git version to get the last committed version?

----------------------------------------------------------------------
 tiwai - 09-02-05 20:24 
----------------------------------------------------------------------
Kernel should be ok as it is (but better to pick up the latest one).
My request was about alsa-lib and alsa-oss.  I fixed some bugs in them
right now on cvs, so please wait a bit until the anon cvs tree on
sourceforge gets sync'd.  It should be done within 24 hours.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-01-05 14:49 Hetfield       New Issue                                    
07-01-05 14:49 Hetfield       Kernel Version            => 2.6.x           
07-01-05 20:16 Hetfield       Note Added: 0005337                          
07-01-05 20:33 rlrevell       Note Added: 0005338                          
07-01-05 22:56 Hetfield       Note Added: 0005343                          
07-02-05 18:53 pzad           Note Added: 0005356                          
07-02-05 20:11 Hetfield       Note Added: 0005357                          
07-02-05 21:46 pzad           File Added: aoss-fcntl.patch                    
07-02-05 21:47 pzad           Note Added: 0005361                          
07-03-05 09:25 Hetfield       Note Added: 0005370                          
07-03-05 14:09 pzad           Note Added: 0005376                          
07-03-05 15:57 Hetfield       Note Added: 0005378                          
07-04-05 11:49 pzad           File Added: aoss.patch                       
07-04-05 11:53 pzad           Note Added: 0005384                          
07-04-05 14:02 Hetfield       Note Added: 0005385                          
07-08-05 12:16 tiwai          Note Added: 0005417                          
07-08-05 12:27 Hetfield       Note Added: 0005418                          
07-17-05 10:25 Hetfield       Note Added: 0005503                          
07-17-05 10:29 rlrevell       Note Added: 0005504                          
07-17-05 10:46 rlrevell       Note Added: 0005505                          
07-17-05 11:10 Hetfield       Note Added: 0005506                          
07-17-05 11:11 Hetfield       File Added: log.tar.gz                       
07-17-05 19:41 rlrevell       Note Added: 0005508                          
07-17-05 19:50 Hetfield       Note Added: 0005509                          
07-17-05 19:51 rlrevell       Note Added: 0005510                          
07-17-05 20:21 Hetfield       Note Added: 0005511                          
07-17-05 21:14 rlrevell       Note Added: 0005512                          
07-17-05 21:22 Hetfield       File Added: log2.tar.gz                      
07-17-05 21:22 Hetfield       File Added: log2                             
07-17-05 21:23 Hetfield       Note Added: 0005513                          
07-17-05 22:21 rlrevell       Note Added: 0005514                          
07-17-05 23:28 Hetfield       Note Added: 0005515                          
07-17-05 23:43 rlrevell       Note Added: 0005516                          
07-18-05 03:33 rlrevell       Note Added: 0005517                          
07-18-05 06:04 rlrevell       Note Added: 0005518                          
07-18-05 07:33 rlrevell       Note Added: 0005519                          
07-18-05 09:23 Hetfield       Note Added: 0005520                          
07-18-05 09:24 Hetfield       File Added: asoundrc                         
07-18-05 22:08 rlrevell       Note Added: 0005524                          
07-21-05 19:55 Hetfield       Note Added: 0005540                          
07-21-05 19:56 Hetfield       Note Added: 0005541                          
07-24-05 09:55 Hetfield       Note Added: 0005556                          
07-24-05 19:10 rlrevell       Note Added: 0005558                          
07-28-05 22:40 rlrevell       Note Added: 0005578                          
07-29-05 17:43 tiwai          Note Added: 0005579                          
08-01-05 10:20 Hetfield       Note Added: 0005595                          
08-10-05 00:49 rlrevell       Relationship added       has duplicate 0001228
08-28-05 15:56 Hetfield       Note Added: 0005963                          
09-02-05 19:57 tiwai          Note Added: 0006020                          
09-02-05 20:22 Hetfield       Note Added: 0006021                          
09-02-05 20:24 tiwai          Note Added: 0006022                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
