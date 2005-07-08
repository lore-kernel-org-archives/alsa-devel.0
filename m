From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001219]: alsamixer cannot handle mixer controls that have separate mute for each channel.
Date: Fri, 8 Jul 2005 14:46:00 +0200
Message-ID: <4f3891c154fd8881c38bd771363f2777@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A13A317C
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 14:46:00 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1219> 
======================================================================
Reported By:                jcdutton
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   1219
Category:                   simple mixer
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             06-29-2005 11:11 CEST
Last Modified:              07-08-2005 14:46 CEST
======================================================================
Summary:                    alsamixer cannot handle mixer controls that have
separate mute for each channel.
Description: 
When a mixer control has a mute control for each channel, alsamixer is only
able to adjust the left channel mute.
For example, with a snd-intel8x0 driver with the ac97 ALC650 codec, this
has a separate mute control for surround left and surround right.
alsamixer is only able to adjust/toggle the surround left mute control.
So far in my investigations, this does not appear to be a bug in
alsamixer. This still might be a bug in alsa-lib functions:
snd_mixer_selem_get_playback_switch(elem, chn_right, &sw);
snd_mixer_selem_set_playback_switch(elem, chn_right, !sw);
or in alsa-kernel ac97_codec.c where is manages the stereo mute controls.

I will investigate further when I get a chance.
======================================================================

----------------------------------------------------------------------
 jcdutton - 06-29-05 22:32 
----------------------------------------------------------------------
I just checked in fix to alsa-lib CVS. It was a typo.

----------------------------------------------------------------------
 tiwai - 07-08-05 14:46 
----------------------------------------------------------------------
OK, clsoing.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-29-05 11:11 jcdutton       New Issue                                    
06-29-05 20:07 tiwai          Note Added: 0005309                          
06-29-05 21:26 jcdutton       Note Added: 0005315                          
06-29-05 22:32 jcdutton       Note Added: 0005317                          
07-08-05 14:45 tiwai          Status                   new => resolved     
07-08-05 14:46 tiwai          Resolution               open => fixed       
07-08-05 14:46 tiwai          Assigned To               => tiwai           
07-08-05 14:46 tiwai          Note Added: 0005427                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
