From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000154]: Master volume only controls front output (emu10k1)
Date: Sun, 12 Mar 2006 21:27:27 +0100
Message-ID: <9bcfc84b291b9c6d5ce7622c006f5670@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D06131E9
	for <alsa-devel@alsa-project.org>; Sun, 12 Mar 2006 21:27:27 +0100 (MET)
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


The following issue has been marked as UNRELATED TO issue 0000172.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=154> 
======================================================================
Reported By:                wzzrd
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   154
Category:                   2_mixer
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
======================================================================
Date Submitted:             03-23-2004 17:31 CET
Last Modified:              03-09-2006 11:34 CET
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
has duplicate       0001256 surround51: Master Volume control and M...
has duplicate       0001071 Help with Volume Controls
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

----------------------------------------------------------------------
 Miwer - 05-20-05 22:02 
----------------------------------------------------------------------
adamk75 I agree with you - we've been waiting for this problem to be fixed
for a LONG time now. This has been a problem for at least 18 months now,
according to various forum posts.

rlrevell why is it taking so long? You say that it's beeing worked on, but
that's not what it looks like when reading alsa-user or alsa-devel. You
tell us to be patient, but it's not easy when nothing's happening. I don't
mean to disrespect you, but when you make a statement like "I should have
this working real soon now", then why is this still open after yet another
4 months?

----------------------------------------------------------------------
 rlrevell - 05-20-05 22:05 
----------------------------------------------------------------------
Sorry, I don't have time to work on this.  Please bug the ALSA developers
to get the abstract mixer layer finished.

----------------------------------------------------------------------
 muffty - 03-09-06 11:34 
----------------------------------------------------------------------
Please, take a look at
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=172. I added a
possible solution there.

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
05-20-05 20:39 Miwer          Issue Monitored: Miwer                       
05-20-05 22:02 Miwer          Note Added: 0004699                          
05-20-05 22:05 rlrevell       Note Added: 0004700                          
07-13-05 18:56 rlrevell       Relationship added       has duplicate 0001256
07-16-05 17:11 jdthood        Relationship added       has duplicate 0001071
09-02-05 19:55 blueSceaDa     Issue Monitored: blueSceaDa                    
03-09-06 11:34 muffty         Note Added: 0008388                          
03-09-06 11:37 muffty         Issue Monitored: muffty                      
03-12-06 21:27 rlrevell       Relationship deleted     related to 0000172  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
