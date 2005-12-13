From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001219]: alsamixer cannot handle mixer controls that have separate mute for each channel.
Date: Tue, 13 Dec 2005 13:30:55 +0100
Message-ID: <577f63f078a219ad96dc540e3195eb7c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 51D121C8
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2005 13:30:55 +0100 (MET)
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
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             06-29-2005 11:11 CEST
Last Modified:              12-13-2005 13:30 CET
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
 tiwai - 07-08-05 14:46 
----------------------------------------------------------------------
OK, clsoing.

----------------------------------------------------------------------
 jcdutton - 12-13-05 13:30 
----------------------------------------------------------------------
Fixed in alsa-driver/lib 1.0.10

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
12-13-05 13:30 jcdutton       Status                   resolved => closed  
12-13-05 13:30 jcdutton       Note Added: 0007013                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
