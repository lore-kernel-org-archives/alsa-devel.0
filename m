From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000154]: Master volume only controls front output (emu10k1)
Date: Sat, 23 Oct 2004 01:09:21 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40f2593e3f4fd6ab62102f4c34902adf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DD0E12B3
	for <alsa-devel@alsa-project.org>; Sat, 23 Oct 2004 01:09:21 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=154> 
======================================================================
Reported By:                wzzrd
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   154
Category:                   mixer
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
======================================================================
Date Submitted:             03-23-2004 17:31 CET
Last Modified:              10-23-2004 01:09 CEST
======================================================================
Summary:                    Master volume only controls front output (emu10k1)
Description: 
Setting the alsamixer Master Volume slider only controls the front two
speakers. The rear speakers have to be controlled with the Wave Surround
setting. I'm not sure whether this is an alsamixer bug or a alsa-driver
bug. If I'm wrong putting it here, sorry.

It would be very convenient to be able to control all four speakers with
the Master Volume setting and to have a Front and Rear slider to control
the front and rear speakers individually.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0000176 Master volume does not alters center, L...
related to          0000172 Master volume control only controls fro...
======================================================================

----------------------------------------------------------------------
 delmonico - 05-24-04 22:51 
----------------------------------------------------------------------
I wrote this little, dirty workaround-script that works just fine for me.
Anyway I would love to see a really working Master-Slider in a new
alsa-version :)

File uploading didn't work so i'll just post it:
#!/bin/sh
#SB Live! global volume control by Christoph 'delmonico' Neuroth
#License: GNU General Public License
#PCM will not go over 75% because higher values sound crappy.

PCM=`amixer get PCM | grep "Front Left: Playback" | awk '{print $5 }' | tr
 -d '\[' | tr -d '%\]'`

case "$1" in
up)
        amixer -q set 'Master' 5%+
        if test $PCM -lt 75
                then amixer -q set 'PCM' 5%+
        fi
        amixer -q set 'Wave Center' 5%+
        amixer -q set 'Wave LFE' 5%+
        amixer -q set 'Wave Surround' 5%+
        amixer -q set 'EMU10K1 PCM' 5%+
;;

down)
        amixer -q set 'Master' 5%-
        amixer -q set 'PCM' 5%-
        amixer -q set 'Wave Center' 5%-
        amixer -q set 'Wave LFE' 5%-
        amixer -q set 'Wave Surround' 5%-
        amixer -q set 'EMU10K1 PCM' 5%-
;;

mute)
        amixer -q set 'Master' 0
        amixer -q set 'PCM' 0
        amixer -q set 'Wave Center' 0
        amixer -q set 'Wave LFE' 0
        amixer -q set 'Wave Surround' 0
        amixer -q set 'EMU10K1 PCM' 0
;;


*)
        amixer -q set 'Master' $1%
        if test $1 -lt 75
                then amixer -q set 'PCM' $1%
                else amixer -q set 'PCM' 75%
        fi
        amixer -q set 'Wave Center' $1%
        amixer -q set 'Wave LFE' $1%
        amixer -q set 'Wave Surround' $1%
        amixer -q set 'EMU10K1 PCM' $1%
;;
esac

----------------------------------------------------------------------
 djtm - 10-23-04 01:09 
----------------------------------------------------------------------
An improved script based on delmonico's but with function and variable
channel names. PCM volume restriction does not yet work though. I'd
appreciate if someone finds the bug. and thanks to delmonico!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-23-04 17:31 wzzrd          New Issue                                    
03-23-04 18:42 perex          View Status              @0@ => public       
03-23-04 18:42 perex          Description Updated                          
03-23-04 18:42 perex          Additional Information Updated                    
03-23-04 18:43 perex          Status                   new => assigned     
03-23-04 18:43 perex          Assigned To               => perex           
03-26-04 20:21 djtm           Note Added: 0000708                          
04-19-04 02:47 tarball        Issue Monitored: tarball                     
04-19-04 21:23 perex          Relationship added       has duplicate 0000176
05-24-04 22:51 delmonico      Note Added: 0001199                          
10-22-04 16:44 perex          Relationship added       related to 0000172  
10-23-04 01:09 djtm           Note Added: 0002253                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
