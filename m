From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001702]: No sound in front speakers emu10k1
Date: Wed, 4 Jan 2006 01:21:52 +0100
Message-ID: <881e18d6c38ba25d2ae5bd3cbf7edba8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E553117A
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2006 01:21:52 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1702> 
======================================================================
Reported By:                pupp3tmast3r
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1702
Category:                   hw specific configuration
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-03-2006 09:41 CET
Last Modified:              01-04-2006 01:21 CET
======================================================================
Summary:                    No sound in front speakers emu10k1
Description: 
Card: SBLive! Value [CT4832]
Chip: Cirrus Logic CS4297A rev 4

When playing in surroud mode with mplayer (-af surround) or audio streams
of 4 or more channels there is no front audio just rear.

This card does only 4 channels playing since is one of the very first
models.

The bug appears in versions of mplayer from 1.0pre7try2 to CVS2005-12-15
======================================================================

----------------------------------------------------------------------
 pzad - 01-03-06 20:59 
----------------------------------------------------------------------
Or you have alsa-lib >= 1.0.10rc2 and your alsa-driver is 1.0.10rc1.

----------------------------------------------------------------------
 pupp3tmast3r - 01-04-06 01:21 
----------------------------------------------------------------------
Until 10.0.10rc1 it was

{
   interface PCM
   device 0
   name "EMU10K1 PCM Send Routing"
   index { @func private_pcm_subdevice }
   lock true
   optional true
   value [ 6 7 0 0 6 7 0 0 6 7 0 0 ]
}

Wich is currenlty working (from version 10.0.9), but I have compiled
driver and libs 1.0.10 from alsa's ftp and I had the same problem, that is
why I rolled back to kernel version (10.0.10rc1)and libs 10.0.9 from
alsa's ftp to, Another problem is debian version package
libasound2_1.0.10-2.deb shiping the file with the new conf "value [ 8 9 0
0 8 9 0 0 8 9 0 0 ]" so after an update it will stop working again.

I will check compilling driver 1.0.10 again from alsa's ftp and a
combination of the libs: from debian package, and compiled from alsa's
ftp.

I hope the problem is just the value in the conf file and to get it
working with the ftp driver version and debian's libs

Once I have tested it will let you know the results.

Any way which alsa's version is running the new kernel 2.6.15? this could
fix the problem.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-03-06 09:41 pupp3tmast3r   New Issue                                    
01-03-06 09:47 pzad           Note Added: 0007400                          
01-03-06 20:10 pupp3tmast3r   File Added: asound.state                     
01-03-06 20:13 pupp3tmast3r   Note Added: 0007404                          
01-03-06 20:39 pzad           Note Added: 0007405                          
01-03-06 20:59 pzad           Note Added: 0007407                          
01-04-06 01:21 pupp3tmast3r   Note Added: 0007408                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
