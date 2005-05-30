From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001145]: On ALSA 1.0.9 running more than one player with different users does not work
Date: Mon, 30 May 2005 11:35:50 +0200
Message-ID: <ada3013c0da6737dd6c626f748d88bc4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D08041C1
	for <alsa-devel@alsa-project.org>; Mon, 30 May 2005 11:35:50 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1145> 
======================================================================
Reported By:                ipartola
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   1145
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             05-30-2005 08:37 CEST
Last Modified:              05-30-2005 11:35 CEST
======================================================================
Summary:                    On ALSA 1.0.9 running more than one player with
different users does not work
Description: 
If I run mpg321 some.mp3 as john I cannot run mpg321 other.mp3 as ben.

This does not work even if one user is root either. I simply get "No
default libao driver available".
======================================================================

----------------------------------------------------------------------
 perex - 05-30-05 11:35 
----------------------------------------------------------------------
It's probably not a bug but security thing. You are probably using dmix
(it's by default for hardware not supporting harware mixing now). To
enable access for all users concurently, you must add ipc_perm 0666 to
specific file and dmix section in /usr/share/alsa/cards...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-30-05 08:37 ipartola       New Issue                                    
05-30-05 08:37 ipartola       Distribution              => Gentoo 2005.0   
05-30-05 08:37 ipartola       Kernel Version            => linux-2.6.11-gentoo
05-30-05 11:31 perex          Project                  ALSA - driver => ALSA -
lib
05-30-05 11:32 perex          Category                 0_compilation problem_!!!
=> pcm - digital audio
05-30-05 11:35 perex          Status                   assigned => closed  
05-30-05 11:35 perex          Note Added: 0004799                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
