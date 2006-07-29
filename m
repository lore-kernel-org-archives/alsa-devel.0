From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002310]: Asus W2Jb laptop sound not
	working
Date: Sat, 29 Jul 2006 02:00:24 +0200
Message-ID: <84bf1d73aad182abc482a266319f79fd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6B8D6151
	for <alsa-devel@alsa-project.org>;
	Sat, 29 Jul 2006 02:00:24 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2310> 
======================================================================
Reported By:                TornSoul
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2310
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.17-gentoo-r4
======================================================================
Date Submitted:             07-29-2006 02:00 CEST
Last Modified:              07-29-2006 02:00 CEST
======================================================================
Summary:                    Asus W2Jb laptop sound not working
Description: 
The Asus W2Jb uses Realtek High Definition Audio, which is the same as
Intel High Definition Audio.

Realtek has a driver available for download here:
http://www.realtek.com.tw/downloads/dlac97-2.aspx?lineid=5&famid=12&series=8&Software=True

However, the driver won't compile.  If I use the hda-intel drivers, they
install and detect the card properly, however no sound comes out when you
try to play audio.  (The mixer has been entirely unmuted and turned to the
maximum volumes)
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-29-06 02:00 TornSoul       New Issue                                    
07-29-06 02:00 TornSoul       Distribution              => Gentoo          
07-29-06 02:00 TornSoul       Kernel Version            => 2.6.17-gentoo-r4
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
