From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000154]: Master volume only controls front output (emu10k1)
Date: Tue, 22 Feb 2005 09:56:45 +0100
Message-ID: <db7e7ba38841e8673a9f6a9f851823d7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3CD49176
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2005 09:56:45 +0100 (MET)
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


The following issue has been set as RELATED TO issue 0000919.
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
Last Modified:              02-17-2005 23:28 CET
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
has duplicate       0000786 Master can't handle all channel
related to          0000172 Master volume control only controls fro...
related to          0000919 Master volume doesn't control rear spea...
======================================================================

----------------------------------------------------------------------
 djtm - 03-26-04 20:21 
----------------------------------------------------------------------
Also applies to the intel8x0-driver.

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
 djtm - 10-23-04 01:10 
----------------------------------------------------------------------
An improved script based on delmonico's but with function and variable
channel names. PCM volume restriction does not yet work though. I'd
appreciate if someone finds the bug. and thanks to delmonico!

see alsavol.sh!!

edited on: 10-23-04 01:10

----------------------------------------------------------------------
 Miwer - 01-04-05 21:01 
----------------------------------------------------------------------
Any news on this one?

----------------------------------------------------------------------
 rlrevell - 01-04-05 21:11 
----------------------------------------------------------------------
It's not really a question of "finding the bug", these controls are simply
not implemented yet.  As you can see, it does not make sense to further
bloat the drivers by fixing it there.

Since the problem can obviously be solved in userspace, and affects more
than one driver, it seems the fix should be implemented in alsa-lib.  All
we need is a way to define new controls and link others to them.

----------------------------------------------------------------------
 pzad - 01-04-05 21:29 
----------------------------------------------------------------------
But something can be fixed in driver (and this bug can be partially fixed
in driver for emu10k1, and this is simpler solution).

----------------------------------------------------------------------
 rlrevell - 01-04-05 21:38 
----------------------------------------------------------------------
Peter,

So the fix for SBLive is to just create an extra control in the driver,
and have it change the values of all the per channel controls?  IOW, do
exactly what the alsavol.sh script does, but inside the driver?

I might try to implement this.  Does it need to be fixed for SBLive and
Audigy too?

----------------------------------------------------------------------
 pzad - 01-04-05 22:30 
----------------------------------------------------------------------
Audigy is OK - this was fixed in past.

SB Live is worse, because there is not one signal path from analog inputs
to front speakers, but two (audigy has only one).

If you are interested in fixing this, I can send you how SB Live alsa
mixer looks now and how it should look after.

This will fix - partially "master" control (this bug repport), spdif
volume controls (for digital speakers) (another bug report) and signal
distortion when using bass and treble controls (another bug report).

----------------------------------------------------------------------
 rlrevell - 01-04-05 22:38 
----------------------------------------------------------------------
Yes, please send me this info, and I'll try to fix the driver.

----------------------------------------------------------------------
 adamk75 - 01-27-05 01:00 
----------------------------------------------------------------------
pzad, could you send me this info as well?

----------------------------------------------------------------------
 adamk75 - 02-01-05 22:57 
----------------------------------------------------------------------
pzad, please? :-)

----------------------------------------------------------------------
 rlrevell - 02-03-05 20:20 
----------------------------------------------------------------------
Peter Zubaj and Mikael Magnusson have provided me with all the necessary
info to implement a proper master volume for the SBLive.  I should have
this working real soon now.

----------------------------------------------------------------------
 adamk75 - 02-17-05 22:01 
----------------------------------------------------------------------
Just checking to see if there's an update on the status of this bug yet?

Adam

----------------------------------------------------------------------
 rlrevell - 02-17-05 22:59 
----------------------------------------------------------------------
Please check the recent postings for alsa-user and alsa-devel lists before
asking this question.  If you read them you would know that yes, it's
being worked on,  and no, it's not fixed yet.

If you want to pay me to work on this, please mail me privately. 
Otherwise be patient.

----------------------------------------------------------------------
 adamk75 - 02-17-05 23:28 
----------------------------------------------------------------------
I've been waiting since early last year.  I thought I was being patient
:-)

Anyway, I was only asking because the thread back and forth on alsa-devel
and alsa-user about the problem stopped almost a week ago.  Since the
volume levels of alsa-devel and alsa-user are way too high for me, I
figured I'd check up here.

Anyway, the driver has been broken for so long, I can certainly wait a
little longer.

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
10-23-04 01:09 djtm           File Added: alsavol.sh                       
10-23-04 01:10 djtm           Note Edited: 0002253                         
11-25-04 12:46 rpolach        Issue Monitored: rpolach                     
01-04-05 21:01 Miwer          Note Added: 0003081                          
01-04-05 21:11 rlrevell       Note Added: 0003082                          
01-04-05 21:29 pzad           Note Added: 0003083                          
01-04-05 21:38 rlrevell       Note Added: 0003084                          
01-04-05 22:30 pzad           Note Added: 0003085                          
01-04-05 22:38 rlrevell       Note Added: 0003086                          
01-07-05 18:23 tiwai          Relationship added       has duplicate 0000786
01-09-05 20:28 voroskoi       Issue Monitored: voroskoi                    
01-27-05 00:58 adamk75        Issue Monitored: adamk75                     
01-27-05 01:00 adamk75        Note Added: 0003418                          
02-01-05 22:57 adamk75        Note Added: 0003475                          
02-03-05 20:20 rlrevell       Note Added: 0003493                          
02-17-05 22:01 adamk75        Note Added: 0003642                          
02-17-05 22:59 rlrevell       Note Added: 0003646                          
02-17-05 23:28 adamk75        Note Added: 0003647                          
02-22-05 09:56 perex          Relationship added       related to 0000919  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
