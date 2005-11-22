From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001591]: dmix not enabled for snd-ice1724
Date: Tue, 22 Nov 2005 22:06:42 +0100
Message-ID: <d2a660d221c644be1eb4899478737198@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F09B419E
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2005 22:06:42 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1591> 
======================================================================
Reported By:                AdamW
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   1591
Category:                   1_pcm_d - direct PCM plugins (dmix+)
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
======================================================================
Date Submitted:             11-22-2005 21:14 CET
Last Modified:              11-22-2005 22:06 CET
======================================================================
Summary:                    dmix not enabled for snd-ice1724
Description: 
Upstream default ALSA config files in /usr/share/alsa/cards/ now seem to
enable dmix by default for most drivers, but not snd-ice1724. I have tried
to enable dmix for snd-ice1724 by editing
/usr/share/alsa/cards/ICE1724.conf and adding the section which seems to
enable dmix on other cards - I copied and pasted it from ENS1371.conf,
with the obvious change of ENS1371 to ICE1724 - but then sound playback no
longer worked. mplayer would give these errors:

ALSA lib pcm_direct.c:812:(snd_pcm_direct_initialize_slave) requested or
auto-format is not available
ALSA lib pcm_dmix.c:831:(snd_pcm_dmix_open) unable to initialize slave
alsa-init: playback open error: Invalid argument
Could not open/initialize audio device -> no sound.

So, a few questions. Is dmix not being enabled by default intentional,
perhaps due to bugs with ice1724's support for dmix? Was my attempt to
turn it on performed wrong, or does the problem lie elsewhere? Thanks.

Please note I am using ALSA 1.1.0, this version was not available on the
'product version' list when I reported this bug. I have already mentioned
this to Mandriva's ALSA packager, Thierry Vignaud; he suggested I should
report it upstream.
======================================================================

----------------------------------------------------------------------
 AdamW - 11-22-05 22:04 
----------------------------------------------------------------------
OK, that makes music work without errors, but dmix still doesn't appear to
work properly - I can't play more than one thing at once. I will attach
the modified ICE1724.conf file so you can see if anything's missing.
Thanks for the pointer.

----------------------------------------------------------------------
 AdamW - 11-22-05 22:06 
----------------------------------------------------------------------
Modified ICE1724.conf attempting to enable dmix. Playback works but dmix
does not seem to.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-22-05 21:14 AdamW          New Issue                                    
11-22-05 21:38 rlrevell       Note Added: 0006801                          
11-22-05 22:04 AdamW          Note Added: 0006804                          
11-22-05 22:06 AdamW          Note Added: 0006805                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
