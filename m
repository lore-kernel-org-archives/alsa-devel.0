From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000653]: poor microphone recording quality on pcicmi
Date: Thu, 18 Nov 2004 19:11:55 +0100
Message-ID: <ec955919727ef9697190b95f5301a60a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 593E1243
	for <alsa-devel@alsa-project.org>; Thu, 18 Nov 2004 19:11:55 +0100 (MET)
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
Last Modified:              11-18-2004 19:11 CET
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

----------------------------------------------------------------------
 tiwai - 11-18-04 18:07 
----------------------------------------------------------------------
Could you try the attached patch and play with "MICBST", "EMUCB"
and "VADMIC3" mixer switches?

(AFAIK, "Mic Boost" affects only the mic playback volume.)

----------------------------------------------------------------------
 pbienst - 11-18-04 19:11 
----------------------------------------------------------------------
I applied the patch, but I'm not able to change these settings. With
alsamixer, they don't budge, and with amixer I get:

pbienst@pbienst:~: amixer -c 1 set MICBST unmute
Simple mixer control 'MICBST',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]

But immediately afterwards:

pbienst@pbienst:~: amixer -c 1 get MICBST
Simple mixer control 'MICBST',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-18-04 10:58 pbienst        New Issue                                    
11-18-04 10:58 pbienst        Distribution              => Gentoo          
11-18-04 10:58 pbienst        Kernel Version            => 2.6.9-gentoo-r4 
11-18-04 18:07 tiwai          Note Added: 0002453                          
11-18-04 18:08 tiwai          File Added: cmipci-test.diff                    
11-18-04 19:11 pbienst        Note Added: 0002459                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
