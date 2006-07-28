From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000653]: poor microphone recording
	quality on pcicmi
Date: Fri, 28 Jul 2006 10:58:17 +0200
Message-ID: <693c382afd1e093aa80876df0bb3062c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A010B165
	for <alsa-devel@alsa-project.org>;
	Fri, 28 Jul 2006 10:58:17 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=653> 
======================================================================
Reported By:                pbienst
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   653
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo
Kernel Version:             2.6.9-gentoo-r4
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-18-2004 10:58 CET
Last Modified:              07-28-2006 10:58 CEST
======================================================================
Summary:                    poor microphone recording quality on pcicmi
Description: 
I have a C-Media PCI CMI8738-MC6 (rev 16) from a Hercules Muse DVD soundd
card.

When recording from a headset microphone, sound quality is really bad: low

volume and quite some noise / distortion.

I have my microphone mixers maxed out, 'Mic boost' is on, 'Mic as
Center/LFE' 
is off.

I've fiddled with all the other options, but they don't seem to affect the

quality.

I do my recording with:

arecord -D hw:1,0 -d 4 test.wav

Under Windows, sound quality is a lot better with the same setup.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001192 Microphone doesn't work in record and/o...
======================================================================

----------------------------------------------------------------------
 tiwai - 06-27-05 15:59 
----------------------------------------------------------------------
Try the patch in #1192.

----------------------------------------------------------------------
 thorstenhirsch - 11-07-05 20:56 
----------------------------------------------------------------------
problem (mic boost) is solved since alsa 1.0.10rc1 / kernel 2.6.13

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-18-04 10:58 pbienst        New Issue                                    
11-18-04 10:58 pbienst        Distribution              => Gentoo          
11-18-04 10:58 pbienst        Kernel Version            => 2.6.9-gentoo-r4 
11-18-04 18:07 tiwai          Note Added: 0002453                          
11-18-04 18:08 tiwai          File Added: cmipci-test.diff                    
11-18-04 19:11 pbienst        Note Added: 0002459                          
11-18-04 19:26 pbienst        Note Added: 0002460                          
11-18-04 19:33 tiwai          Note Added: 0002461                          
11-18-04 19:36 pbienst        Note Added: 0002462                          
11-18-04 19:54 tiwai          Note Added: 0002467                          
11-18-04 20:01 pbienst        Note Added: 0002468                          
11-18-04 20:22 tiwai          Note Added: 0002469                          
06-27-05 15:58 tiwai          Relationship added       related to 0001192  
06-27-05 15:59 tiwai          Note Added: 0005273                          
11-07-05 20:56 thorstenhirsch Note Added: 0006618                          
07-28-06 10:58 Adrian Bunk    Status                   assigned => resolved
07-28-06 10:58 Adrian Bunk    Resolution               open => fixed       
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
