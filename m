From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000653]: poor microphone recording quality on pcicmi
Date: Mon, 7 Nov 2005 20:56:51 +0100
Message-ID: <624f27f341a13152732d2d37c52859a8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 25B831A2
	for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2005 20:57:06 +0100 (MET)
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
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.9-gentoo-r4
======================================================================
Date Submitted:             11-18-2004 10:58 CET
Last Modified:              11-07-2005 20:56 CET
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
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
