From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000881]: Distorted sound with enabled dmix plugin
Date: Fri, 4 Feb 2005 15:30:38 +0100
Message-ID: <4e9391443058848ef5bba9a065f08e7c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DD8741A3
	for <alsa-devel@alsa-project.org>; Fri,  4 Feb 2005 15:30:39 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=881> 
======================================================================
Reported By:                yure
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   881
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-03-2005 12:25 CET
Last Modified:              02-04-2005 15:30 CET
======================================================================
Summary:                    Distorted sound with enabled dmix plugin
Description: 
After 10-20 minutes listening music with xmms or beep-media-player I hear
distorted sound. Appear noise.
This problem is appear when enabled dmix plugin through configuration file
~/.asoundrc.
======================================================================

----------------------------------------------------------------------
 tiwai - 02-04-05 14:53 
----------------------------------------------------------------------
I've seen similar problems only on ICH test boards around me.
The AMD machines are OK.

Are you using the patched xmms/bmp with multi-threading?
Does it happen with plug layer, too?  (Give plug:dmix in the device entry
of ALSA output plugin)

----------------------------------------------------------------------
 yure - 02-04-05 15:30 
----------------------------------------------------------------------
Yes. I use pathced xmms.bmp with multi-threading.
Here fragment from my .asoundrc:
pcm.swmix {
        type dmix
        # any unique number here
        ipc_key 31334567
        slave {
                pcm "hw:0,0"
                # these settings may require tweaking for different sound
                # cards; this is for the Powerbook's built-in
snd-powermac
                # probably not required at all for well-behaved cards...
                period_time 0
                period_size 1024
                buffer_size 8192
                # mentioning rate fixes wrong speed/pitch in native ALSA
stuff
                rate 44100
        }

    # bindings are cool. This says, that only the first
    # two channels are to be used by swmix, which is enough for
    # (most) oss apps and also lets multichannel chios work
    # much faster:
    bindings {
        0 0   # from 0 => to 0
        1 1   # from 1 => to 1
    }
}

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-03-05 12:25 yure           New Issue                                    
02-04-05 10:39 yure           Note Added: 0003497                          
02-04-05 10:39 yure           Issue Monitored: yure                        
02-04-05 14:53 tiwai          Note Added: 0003506                          
02-04-05 15:30 yure           Note Added: 0003508                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
