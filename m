From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001591]: dmix not enabled for snd-ice1724
Date: Wed, 14 Dec 2005 23:35:53 +0100
Message-ID: <3610284d84ac077e06f8beb08eaa9dbc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E5490178
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2005 23:35:53 +0100 (MET)
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


The following issue has been RESOLVED.
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
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-22-2005 21:14 CET
Last Modified:              12-14-2005 23:35 CET
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
 AdamW - 11-22-05 22:06 
----------------------------------------------------------------------
Modified ICE1724.conf attempting to enable dmix. Playback works but dmix
does not seem to.

----------------------------------------------------------------------
 rlrevell - 12-14-05 23:35 
----------------------------------------------------------------------
Fixed in CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-22-05 21:14 AdamW          New Issue                                    
11-22-05 21:38 rlrevell       Note Added: 0006801                          
11-22-05 22:04 AdamW          Note Added: 0006804                          
11-22-05 22:06 AdamW          Note Added: 0006805                          
11-23-05 08:27 AdamW          File Added: ICE1724.conf                     
12-14-05 23:35 rlrevell       Status                   assigned => resolved
12-14-05 23:35 rlrevell       Resolution               open => fixed       
12-14-05 23:35 rlrevell       Note Added: 0007044                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
