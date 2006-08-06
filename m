From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001361]: sound choppy when resuming alsa
	client process
Date: Sun, 6 Aug 2006 13:06:11 +0200
Message-ID: <e77cd61f72f91534c3884a77d3b07bdb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2A7C9172
	for <alsa-devel@alsa-project.org>;
	Sun,  6 Aug 2006 13:06:12 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1361> 
======================================================================
Reported By:                mbwardle
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   1361
Category:                   1_pcm_d - direct PCM plugins (dmix+)
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             08-23-2005 12:39 CEST
Last Modified:              08-06-2006 13:06 CEST
======================================================================
Summary:                    sound choppy when resuming alsa client process
Description: 
If I start an ALSA client process from a terminal, begin playback of a
song, suspend the process, then resume the process, the playback becomes
choppy (has many intermittent periods of silence per second).

A possibly related similar problem seems to occur if there is a runaway
process on the system which starves the ALSA client of CPU time.  Even
after the client gets a good slice of CPU time, the sound remains choppy.

This issue was originally reported as a bug in Ubuntu Linux
<http://bugzilla.ubuntu.com/show_bug.cgi?id=13003>.

======================================================================

----------------------------------------------------------------------
 perex - 11-14-05 09:58 
----------------------------------------------------------------------
Could you try 1.0.10rc3 alsa-lib package?

----------------------------------------------------------------------
 jdthood - 12-13-05 12:34 
----------------------------------------------------------------------
Submitter: Do you still see this problem with ALSA 1.0.10?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-23-05 12:39 mbwardle       New Issue                                    
08-23-05 12:39 mbwardle       File Added: asound.conf                      
11-14-05 09:58 perex          Note Added: 0006699                          
11-14-05 09:58 perex          Status                   assigned => feedback
12-13-05 12:34 jdthood        Note Added: 0006995                          
08-06-06 13:06 Adrian Bunk    Status                   feedback => closed  
08-06-06 13:06 Adrian Bunk    Resolution               open => unable to
duplicate
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
