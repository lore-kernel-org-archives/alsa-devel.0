From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000899]: Cannot aplay to Sound Galaxy card with alsa-lib 1.0.8: looks for "/usr/share/alsa/cards/Sound Galaxy.conf"
Date: Wed, 9 Feb 2005 17:14:59 +0100
Message-ID: <474710ccd6365d7e0702a196168df45a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CAE3326C
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2005 17:14:59 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=899> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   899
Category:                   general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-09-2005 17:14 CET
Last Modified:              02-09-2005 17:14 CET
======================================================================
Summary:                    Cannot aplay to Sound Galaxy card with alsa-lib
1.0.8: looks for "/usr/share/alsa/cards/Sound Galaxy.conf"
Description: 
This is forwarded Debian bug report
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=293907.  Please see
http://bugs.debian.org/293907 for the full report.

The submitter says that with his Sound Galaxy card he cannot get aplay
to work.  He gets the following error when he runs aplay:

-------------- error message ----------------------

ALSA lib conf.c:2792:(snd_config_hook_load) "/usr/share/alsa/cards/Sound
Galaxy.conf" is not a word
ALSA lib conf.c:2672:(snd_config_hooks_call) function
snd_config_hook_load_for_all_cards returned error: Invalid argument
ALSA lib pcm.c:1947:(snd_pcm_open_conf) Invalid type for PCM default
definition (id: default, value: cards.pcm.default)
aplay: main:508: audio open error: Invalid argument

------------ end error message ---------------------

There is no "Sound Galaxy.conf" file, but the user doesn't get an error
message when he uses alsa-lib 1.0.7.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-09-05 17:14 jdthood        New Issue                                    
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
