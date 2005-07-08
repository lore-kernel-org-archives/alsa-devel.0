From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001002]: Software volume control should be enabled by default for CMI9761
Date: Fri, 8 Jul 2005 10:34:31 +0200
Message-ID: <7fb991d8ccc6fe0fe7acd89962be2294@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 65BBC17A
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 10:34:31 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1002> 
======================================================================
Reported By:                e_val
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   1002
Category:                   1_pcm - digital audio
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-19-2005 20:42 CET
Last Modified:              07-08-2005 10:34 CEST
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

----------------------------------------------------------------------
 tiwai - 03-22-05 19:35 
----------------------------------------------------------------------
softvol and dmix are used as default in 1.0.9.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-19-05 20:42 e_val          New Issue                                    
03-22-05 19:35 tiwai          Status                   new => resolved     
03-22-05 19:35 tiwai          Resolution               open => fixed       
03-22-05 19:35 tiwai          Assigned To               => tiwai           
03-22-05 19:35 tiwai          Note Added: 0004127                          
07-08-05 10:34 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
