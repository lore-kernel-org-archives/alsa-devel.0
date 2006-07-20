From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002295]: Maximal volume far too low
Date: Thu, 20 Jul 2006 12:42:55 +0200
Message-ID: <6c60837ac3d5809f2b8de0fce391c11f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 30A8D169
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Jul 2006 12:42:56 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2295> 
======================================================================
Reported By:                LiquidAcid
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2295
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.16-gentoo-r13
======================================================================
Date Submitted:             07-20-2006 12:42 CEST
Last Modified:              07-20-2006 12:42 CEST
======================================================================
Summary:                    Maximal volume far too low
Description: 
Hi there,

I have sort of a major problem with the hda-intel ALSA drivers. The
problem is the volume control. I'm also using Windows 2000 on this
notebook and using the default drivers (I got them from the Dell support
site) I can set the volume slider in the middle and get a quite good level
for listening even when not sitting in front of the notebook.
Using gentoo I always really have to max out the sliders to get an
acceptable listening volume.

uname -a : Linux Leena 2.6.16-gentoo-r13 #1 PREEMPT Tue Jul 18 00:39:46
CEST 2006 i686 Intel(R) Celeron(R) M processor 1.50GHz GNU/Linux

I don't use the in-kernel embedded drivers but the 1.0.11 release. As far
as the changelog for 1.0.12rc1 is concerned nothing important has been
done about the hda-intel part, so I haven't testet the 12rc1 yet.

The soundchip chipset seems to be a STAC9200, and the notebook is a Dell
inspiron 1300/b130.
I tried multiple audio players (audacious, bmpx, mpg321, mpg123) but all
with the same result. The volume is just too low
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-20-06 12:42 LiquidAcid     New Issue                                    
07-20-06 12:42 LiquidAcid     Distribution              => Gentoo          
07-20-06 12:42 LiquidAcid     Kernel Version            => 2.6.16-gentoo-r13
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
