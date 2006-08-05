From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002325]: M-Audio Revolution 5.1:
	capture does not work
Date: Sat, 5 Aug 2006 17:35:29 +0200
Message-ID: <fd7cad4f61a53b394263c8650c263852@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4257BD8
	for <alsa-devel@alsa-project.org>;
	Sat,  5 Aug 2006 17:35:30 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2325> 
======================================================================
Reported By:                voss
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2325
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             08-02-2006 00:03 CEST
Last Modified:              08-05-2006 17:35 CEST
======================================================================
Summary:                    M-Audio Revolution 5.1: capture does not work
Description: 
Hello,

it seems that capturing sound from the microphone input does not work. 
This is on a M-Audio Revolution 5.1 (envy24GT/ice1722 audio-controller)
sound card with ALSA 1.0.11rc4 as included in the stock Linux kernel
version 2.6.17.6.

The command "arecord -fcd x.wav" creates a file "x.wav" which consists
(except for the header) only of null bytes.  I tried to play with the
mixer controls using alsamixer, but this did not change anything.  In
particular I tried to set each of the controls "H/W", "H/W 1", "H/W 2",
"H/W 3", "H/W 4" and "H/W 5" to the values "H/W In 0" and "H/W In 1"
respectively, but still no input.

Playback works fine.

At
http://sourceforge.net/mailarchive/forum.php?thread_id=26463750&forum_id=1751
somebody else had encountered the same problem.

Every bit of information I could scrape together about the sound card can
be found at http://seehuhn.de/comp/hardware/revolution .  Please let me
know if you need more information or if I should try something else.

I hope this helps,
Jochen
======================================================================

----------------------------------------------------------------------
 voss - 08-05-06 17:35 
----------------------------------------------------------------------
I tried alsa-driver version 1.0.12rc2 and found that the problem is still
present there.

Every bit of information I could scrape together about the sound card can
be found at http://seehuhn.de/comp/hardware/revolution [^] . Please let me
know if you need more information or if I should try something else.

Shall I copy information from my web page into the bug report log?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-02-06 00:03 voss           New Issue                                    
08-05-06 17:35 voss           Note Added: 0011440                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
