From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001069]: Scratchy sound through AC3 passthrough with userspace version 1.0.9rc2
Date: Sat, 7 Jan 2006 19:42:50 +0100
Message-ID: <39fb9984e910a77bf58992bb88c4e8bc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8BD0712A
	for <alsa-devel@alsa-project.org>; Sat,  7 Jan 2006 19:42:50 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1069> 
======================================================================
Reported By:                Creideiki
Assigned To:                rlrevell
======================================================================
Project:                    ALSA - lib
Issue ID:                   1069
Category:                   0_general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             04-21-2005 21:46 CEST
Last Modified:              01-07-2006 19:42 CET
======================================================================
Summary:                    Scratchy sound through AC3 passthrough with
userspace version 1.0.9rc2
Description: 
I have an Audigy 2 ZS sound card connected via S/PDIF to a Logitech Z-680
decoder/speaker system. After upgrading ALSA userspace (alsa-headers,
alsa-lib) to 1.0.9rc2, with no configuration changes, all I got when
trying to play DVD:s using AC3 passthrough was scratchy noises, and the
external decoder indicated that it did not think it was getting AC3 data.
Software decoding worked, but not hardware passthrough. Both Xine and
MPlayer had this problem. I am not running aRts, or any other sound
server, and have no ~/.asoundrc file.

Downgrading to userspace version 1.0.8 made it work again.

I have no idea how to debug ALSA problems, so please let me know how to
generate any extra information you might require.

By the way, the "Product Version" field in Mantis doesn't let me select
any version higher than 1.0.8.
======================================================================

----------------------------------------------------------------------
 rlrevell - 12-30-05 04:33 
----------------------------------------------------------------------
Any improvement with later releases?

----------------------------------------------------------------------
 Creideiki - 01-07-06 16:03 
----------------------------------------------------------------------
ALSA userspace 1.0.10 on drivers from kernel 6.11-gentoo-r6 had the same
problem. Userspaces 1.0.10 and 1.0.11rc2 on kernel 2.6.14-gentoo-r4 works.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-21-05 21:46 Creideiki      New Issue                                    
04-22-05 02:06 eradicator     Issue Monitored: eradicator                    
04-29-05 09:14 mandreiana     Issue Monitored: mandreiana                    
06-24-05 17:54 Creideiki      File Added: iecset                           
06-24-05 17:54 Creideiki      File Added: ac97#0-0+regs                    
06-24-05 17:58 Creideiki      Note Added: 0005244                          
12-30-05 04:33 rlrevell       Note Added: 0007212                          
01-07-06 16:03 Creideiki      Note Added: 0007515                          
01-07-06 19:42 rlrevell       Status                   new => resolved     
01-07-06 19:42 rlrevell       Resolution               open => fixed       
01-07-06 19:42 rlrevell       Assigned To               => rlrevell        
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
