From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000955]: CN-126 - USB 5.1 Audio adapter
Date: Wed, 2 Mar 2005 14:19:57 +0100
Message-ID: <33c6e4d9b56307ce57e5bd23ddee1b1c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id BA06D1F3
	for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2005 14:19:57 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=955> 
======================================================================
Reported By:                mano1979
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   955
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Mandrake 10.1
Kernel Version:             2.6.10.3
======================================================================
Date Submitted:             03-02-2005 00:13 CET
Last Modified:              03-02-2005 14:19 CET
======================================================================
Summary:                    CN-126 - USB 5.1 Audio adapter
Description: 
I am in really need of a driver for this card. It needs to support 5.1
surround and speaker setup....... well like the original software.

Please let me know if you're able to make it.

Regards, 

Armand Blaaker
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 03-02-05 14:14 
----------------------------------------------------------------------
This device has only one volume control for all six output channels. 
Setting a seperate volume per speaker can only be done if it is emulated
in software.  (ALSA has a softvol plugin, but currently it doesn't allow
one control for each channel, either.)


The device has two output formats: two channels and six channels.  When
you play a stereo file, the device says "I can do this", and whatever
happens with these two channels is up to the device.  Apparently, it
doesn't do upmixing.

To emulate upmixing in software, you can create a virtual stereo device
named "upmix" in your ~/.asoundrc:

pcm.upmix {
    type plug
    slave {
        pcm "hw:0"
        channels 6
    }
    ttable.0.0 1        # L -> front L
    ttable.1.1 1        # R -> front R
    ttable.0.2 0.5      # L -> center
    ttable.1.2 0.5      # R -> center
    ttable.0.3 0.5      # L -> LFE
    ttable.1.3 0.5      # R -> LFE
    ttable.0.4 1        # L -> surround L
    ttable.1.5 1        # R -> surround R
}

The zero in "hw:0" is the card number, replace this with the actual card
number (see /proc/asound/cards).
Such a virtual device won't work with application that use the old OSS API
(/dev/dsp*).

----------------------------------------------------------------------
 mano1979 - 03-02-05 14:19 
----------------------------------------------------------------------
I very gratefull for this info but i have no idea how to make an virtual
stereo device. are you able to make an Rpm file or something like that?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-02-05 00:13 mano1979       New Issue                                    
03-02-05 00:13 mano1979       Distribution              => Mandrake 10.1   
03-02-05 00:13 mano1979       Kernel Version            => 2.6.10.3        
03-02-05 00:14 mano1979       Issue Monitored: mano1979                    
03-02-05 09:28 Clemens LadischNote Added: 0003762                          
03-02-05 12:34 mano1979       Note Added: 0003763                          
03-02-05 12:44 Clemens LadischNote Added: 0003764                          
03-02-05 12:46 mano1979       Note Added: 0003765                          
03-02-05 12:48 mano1979       Note Added: 0003766                          
03-02-05 12:58 Clemens LadischNote Added: 0003767                          
03-02-05 13:05 mano1979       Note Added: 0003769                          
03-02-05 14:14 Clemens LadischNote Added: 0003773                          
03-02-05 14:19 mano1979       Note Added: 0003774                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
