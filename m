From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002279]: Surround outputs not working,
	or touching mixer controls kills all outputs
Date: Thu, 20 Jul 2006 20:52:45 +0200
Message-ID: <dd0cfa3096b10be511649fab99c9e69b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 17593183
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Jul 2006 20:52:45 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2279> 
======================================================================
Reported By:                laurie
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2279
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu Dapper 6.06
Kernel Version:             2.6.15-26-amd64-k8
======================================================================
Date Submitted:             07-12-2006 22:45 CEST
Last Modified:              07-20-2006 20:52 CEST
======================================================================
Summary:                    Surround outputs not working, or touching mixer
controls kills all outputs
Description: 
I have an Asus A8V-VM with onboard AD1986A, that I can get to output front
audio with a working mixer by passing model=3stack with alsa-driver
versions 1.0.10 (with ubuntu patches), 1.0.11, 1.0.12rc1, and cvs20060712,
but no output on rear, center or lfe. By passing model=6stack (or pretty
much anything other than 3stack - position_fix=1 is also needed for
earlier versions), I get surround, but touching a mixer control kills the
audio until the module is reloaded.
======================================================================

----------------------------------------------------------------------
 tiwai - 07-19-06 20:36 
----------------------------------------------------------------------
How did you test surround outputs exactly?  Via speaker-test?

----------------------------------------------------------------------
 laurie - 07-20-06 20:52 
----------------------------------------------------------------------
Umm.. by playing sound and listening, one of the sources of sound I used
was speaker-test, yes. (sorry if I'm missing something here, how else
would I check surround outputs?)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-12-06 22:45 laurie         New Issue                                    
07-12-06 22:45 laurie         Distribution              => Ubuntu Dapper 6.06
07-12-06 22:45 laurie         Kernel Version            => 2.6.15-26-amd64-k8
07-12-06 22:46 laurie         Issue Monitored: laurie                      
07-19-06 20:36 tiwai          Note Added: 0011099                          
07-20-06 20:52 laurie         Note Added: 0011137                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
