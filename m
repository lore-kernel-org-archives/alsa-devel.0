From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000963]: Sounc card is mute
Date: Thu, 17 Mar 2005 23:07:38 +0100
Message-ID: <3f5779a4923cb69e202be4fd1c4649cc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6889822D
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2005 23:07:38 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=963> 
======================================================================
Reported By:                jnilles
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   963
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               SuSE
Kernel Version:             
======================================================================
Date Submitted:             03-04-2005 19:07 CET
Last Modified:              03-17-2005 23:07 CET
======================================================================
Summary:                    Sounc card is mute
Description: 
I have a Turtle Beach Santa Cruz. It worked perfectly with SuSE Linux 9.0
and still works perfectly under Windows XP. I "upgraded" to SuSE 9.2 and
the sound card is inoperative, mute, lifeless, sound-free. The only advice
I got from SuSE support was that I shouldn't have skipped from 9.0 to 9.2
without going thgrough 9.1 on the way. That sounds like pretty stupid
advice.
I have spent weeks twiddling with settings  recommended by member sof the
alsa users group, to no avail.
======================================================================

----------------------------------------------------------------------
 jdthood - 03-17-05 10:11 
----------------------------------------------------------------------
This doesn't look good:

    control.37 {
        comment.access 'read write'
        comment.type BOOLEAN
        iface MIXER
        name 'Master Playback Switch'
        index 1
        value false
    }
    control.38 {
        comment.access 'read write'
        comment.type INTEGER
        comment.range '0 - 63'
        iface MIXER
        name 'Master Playback Volume'
        index 1
        value.0 0
        value.1 0
    }


As an experiment you can edit asound.state and run 'alsactl restore'
to load the values into the hardware.  If you don't want to do that
then I suggest you kill all mixer applications (except gamix) and
try to raise the Master Playback levels using gamix.

----------------------------------------------------------------------
 jnilles - 03-17-05 23:07 
----------------------------------------------------------------------
OK, gamix solved it, at least for playing CDs and setting microphone
volumes. The key was to enable the External Amplifier switch, which KAMix
apparently ignored. So much for KAMix.
The gamix controls to the right of the External Amplifier switch don't
seem to affect anything; are they for a nonexistent second sound card or
what?

Thanks for the help; this was a major barrier to my switching a lot of my
activities from Win XP to Linux.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-04-05 19:07 jnilles        New Issue                                    
03-04-05 19:07 jnilles        Distribution              => SuSE            
03-09-05 18:53 tiwai          Note Added: 0003840                          
03-10-05 00:21 jnilles        Note Added: 0003846                          
03-10-05 15:01 jdthood        Note Added: 0003856                          
03-10-05 20:29 jnilles        Note Added: 0003872                          
03-10-05 22:04 jdthood        Note Added: 0003874                          
03-16-05 01:33 jnilles        Note Added: 0003926                          
03-16-05 12:31 tiwai          Note Added: 0003941                          
03-16-05 22:52 jnilles        Note Added: 0003972                          
03-17-05 10:11 jdthood        Note Added: 0003980                          
03-17-05 23:07 jnilles        Note Added: 0003986                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
