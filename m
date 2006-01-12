From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001191]: Center channel and 32-bit emulation broken when upgrading alsa-lib from 1.0.8 to 1.0.9 on nForce 4 system
Date: Thu, 12 Jan 2006 04:12:35 +0100
Message-ID: <75bc68d2f26fc2c0e8c9a7e28ef942db@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ED4C5120
	for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2006 04:12:35 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1191> 
======================================================================
Reported By:                robert
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1191
Category:                   hw specific configuration
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             06-14-2005 11:45 CEST
Last Modified:              01-12-2006 04:12 CET
======================================================================
Summary:                    Center channel and 32-bit emulation broken when
upgrading alsa-lib from 1.0.8 to 1.0.9 on nForce 4 system
Description: 
I'm running AMD64 gentoo on an nforce4 system, audio is nVidia CK804 with
ALC850. I can emerge the newest alsa-driver package (1.0.9b), but when I
upgrade alsa-lib to 1.0.9, three things happen.  First, my 32 bit sound
applications, like mplayer32, don't work with alsa anymore.  Second, the
center channel on all 5.1 sound goes out.  Third, the a/v synchonization
on mplayer gets hosed using alsa (oss emulation still ok.)
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001501 intel8x0 surround channels missing and ...
has duplicate       0001206 No center channel; rear left and right ...
======================================================================

----------------------------------------------------------------------
 rlrevell - 08-19-05 03:10 
----------------------------------------------------------------------
The change was made to fix some other bug.

 Details here:
http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-lib/src/conf/cards/NFORCE.conf?rev=1.9&view=log

What you are asking is that each change be fully regression tested with
every single piece of hardware on the market.  We are not Microsoft, we
don't have those kinds of resources.

Try reverting the last three changes one at a time and see which causes
the problem.  Or try the patch I posted to #1206.

----------------------------------------------------------------------
 rlrevell - 01-12-06 04:12 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-14-05 11:45 robert         New Issue                                    
06-15-05 14:01 jdthood        Note Added: 0005023                          
06-15-05 22:00 robert         Note Added: 0005045                          
06-15-05 23:42 jdthood        Note Added: 0005048                          
08-18-05 21:12 robert         Note Added: 0005853                          
08-18-05 21:31 rlrevell       Note Added: 0005855                          
08-18-05 21:32 rlrevell       Relationship added       has duplicate 0001206
08-19-05 02:45 robert         Note Added: 0005863                          
08-19-05 03:10 rlrevell       Note Added: 0005865                          
11-01-05 15:45 jdthood        Relationship added       related to 0001501  
11-06-05 10:12 densg          Issue Monitored: densg                       
01-12-06 04:12 rlrevell       Status                   new => closed       
01-12-06 04:12 rlrevell       Note Added: 0007579                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
