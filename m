From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000306]: compiles, but no sound comes out
Date: Sun, 7 Aug 2005 11:44:34 +0200
Message-ID: <007885a9670893985746f89d7e829e8c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 67BB3214
	for <alsa-devel@alsa-project.org>; Sun,  7 Aug 2005 11:44:34 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=306> 
======================================================================
Reported By:                Quietti
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   306
Category:                   PPC - powermac
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             self-compiled 2.6.6 vanilla.
======================================================================
Date Submitted:             05-25-2004 20:35 CEST
Last Modified:              08-07-2005 11:44 CEST
======================================================================
Summary:                    compiles, but no sound comes out
Description: 
This is a plain vanilla kernel 2.6.6, which uses ALSA 1.0.4.

The kernel compiles fine, the snd_powermac module loads without any error,
but no sound comes up.

Running alsamixer gives me a mixer screen where none of the sliders can be
moved.
======================================================================

----------------------------------------------------------------------
 Quietti - 08-07-05 11:36 
----------------------------------------------------------------------
Debian's BTS, for instance, works quite well without the hindrance of a
user account creation.

Anyhow, that's a moot point for me, since I have accounts pretty much
everywhere. 

This being said, I know for fact that most end-users won't bother with
creating an account  on someone's Bugzilla, for every damn piece of OSS
they use; they will switch OS instead. The proof of the pudding exists for
this ALSA PowerMac bug as well: several people immediately posted the
details of their ALSA problems to the debian-powerpc list, as soon as the
possibility was offered to them. Good luck finding anyone among them who
would have done the same, if it first required them to create an account
on some BTS.

Perhaps adopting the path of lowest resistance that Debian uses (including
bug reporting tools that mail the report and won't require the creation of
an account on every project's BTS) would make it easier for users to
report bugs, which would then result in immediate product quality
improvements. Think about that.

----------------------------------------------------------------------
 Quietti - 08-07-05 11:44 
----------------------------------------------------------------------
As for Tiwai's blindfold-coding based on an already broken OSS driver:
using the Open Darwin source code as a reference would definitely lead to
more solid results, since the starting point is the opensourced version of
Apple's own drivers.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-25-04 20:35 Quietti        New Issue                                    
05-25-04 20:35 Quietti        File Added: asound.state                     
05-25-04 20:35 Quietti        Distribution              => Debian          
05-25-04 20:35 Quietti        Kernel Version            => self-compiled 2.6.6
vanilla.
05-25-04 20:38 Quietti        Issue Monitored: Quietti                     
05-28-04 21:18 tiwai          Note Added: 0001274                          
05-28-04 21:37 Quietti        Note Added: 0001275                          
07-25-04 20:16 Quietti        Note Added: 0001473                          
09-08-04 06:32 Quietti        Note Added: 0001726                          
10-20-04 00:38 Quietti        Note Added: 0002209                          
01-06-05 18:14 Quietti        Note Added: 0003093                          
01-06-05 18:27 rlrevell       Note Added: 0003094                          
01-06-05 19:43 Quietti        Note Added: 0003095                          
01-07-05 00:00 Quietti        Note Added: 0003096                          
01-07-05 00:19 Quietti        Note Added: 0003097                          
01-07-05 00:30 Quietti        Note Added: 0003098                          
01-14-05 00:53 Quietti        Note Added: 0003206                          
02-04-05 09:22 Quietti        Note Added: 0003496                          
02-04-05 13:04 tiwai          Note Added: 0003499                          
04-02-05 13:33 Quietti        Note Added: 0004297                          
08-06-05 20:24 Quietti        Note Added: 0005682                          
08-06-05 20:31 rlrevell       Note Added: 0005683                          
08-06-05 20:32 rlrevell       Note Added: 0005684                          
08-06-05 20:53 rlrevell       Note Added: 0005685                          
08-06-05 21:17 rlrevell       Note Added: 0005686                          
08-06-05 23:54 rlrevell       Note Added: 0005687                          
08-06-05 23:55 rlrevell       Note Deleted: 0005683                        
08-06-05 23:55 rlrevell       Note Deleted: 0005684                        
08-07-05 10:03 pochini        Note Added: 0005689                          
08-07-05 10:31 Quietti        Note Added: 0005690                          
08-07-05 10:46 rlrevell       Note Added: 0005691                          
08-07-05 11:36 Quietti        Note Added: 0005692                          
08-07-05 11:44 Quietti        Note Added: 0005693                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
