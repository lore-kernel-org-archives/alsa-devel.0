From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0002188]: Alsa mixer lack of some
	functions
Date: Sat, 24 Jun 2006 18:02:14 +0200
Message-ID: <d0e556cb66d9edd49e11c61964706bb3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C963524E
	for <alsa-devel@alsa-project.org>;
	Sat, 24 Jun 2006 18:02:14 +0200 (MEST)
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
Last Modified:              06-24-2006 18:02 CEST
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
 rlrevell - 06-24-06 17:20 
----------------------------------------------------------------------
You don't have to implement it in every app.  All they need to do is output
to the "surround40" or "surround51" device.

On Windows every app that uses sound has a menu to select the sound device
to use.  This is exactly the same.

Does "aplay -D surround40 file.wav" work?  "aplay -D surround51 file.wav"?

----------------------------------------------------------------------
 Cimmo - 06-24-06 18:02 
----------------------------------------------------------------------
Give me errors, see file attached

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
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
