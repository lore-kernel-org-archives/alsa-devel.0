From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001002]: Software volume control should be enabled by default for CMI9761
Date: Sat, 19 Mar 2005 20:42:21 +0100
Message-ID: <404d0c7f5d474d1416a8c57b9ccc5390@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 72CA01E9
	for <alsa-devel@alsa-project.org>; Sat, 19 Mar 2005 20:42:21 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1002> 
======================================================================
Reported By:                e_val
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1002
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             03-19-2005 20:42 CET
Last Modified:              03-19-2005 20:42 CET
======================================================================
Summary:                    Software volume control should be enabled by default
for CMI9761
Description: 
Sinc version 1.0.8, ALSA provides softvol plugin to deal with those chips
which does not provide hardware volume control. So, according to the
changelog, defunct  volume bars 'PCM Playback Volume' and similiar were
removed from /usr/share/alsa/*.conf for thos cards. In theory, they should
not be removed but replaced with softvol, as it was done for some chips.
(eg. Azalia).

The simple construct
pcm.!default {
  type softvol
  slave.pcm "hw:0,0"
  control {
    name "PCM Playback Volume"
  }
}
in /etc/asound.conf is sufficient for my CMI9761-based audiocard to work.
I think it would be beter to integrate a more advenced version of the code
into system-wide configs.


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-19-05 20:42 e_val          New Issue                                    
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
