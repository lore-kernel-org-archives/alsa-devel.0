From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000268]: High frequency tones placed on DAC2 outputs (Revo7.1)
Date: Sun, 3 Apr 2005 20:08:01 +0200
Message-ID: <f14ba672fa7f27c7cb0491d885cb472d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D4C3D1EF
	for <alsa-devel@alsa-project.org>; Sun,  3 Apr 2005 20:08:01 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=268> 
======================================================================
Reported By:                MWP
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   268
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               LFS
Kernel Version:             2.6.6
======================================================================
Date Submitted:             05-10-2004 16:11 CEST
Last Modified:              04-03-2005 20:08 CEST
======================================================================
Summary:                    High frequency tones placed on DAC2 outputs
(Revo7.1)
Description: 
On playing audio to any of the ICE1724 ouputs through ALSA enabled
software, a high pitched constant tone (at a guess
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2#3/8 of sample rate) is
played through the secondary DAC's (2,3,4 stereo pairs) ouputs (and mixed
with audio if playing through those outputs).
The tone is not present on the first DAC (front) analog outputs.

The tone is not effected by volume settings of the DAC2 output pairs.

The tone however is not produced when using JACK to play audio to the
card.
======================================================================

----------------------------------------------------------------------
 MWP - 05-18-04 13:28 
----------------------------------------------------------------------
Ok, now we are getting somewhere.

I was using the asound config:

---------------------------------

pcm.envy_1
{
    type hw
    card 1
    device 0
    subdevice 0
}

pcm.envy_2
{
    type hw
    card 1
    device 2
    subdevice 0
}

pcm.envy_3
{
    type hw
    card 1
    device 2
    subdevice 1
}

pcm.envy_4
{
    type hw
    card 1
    device 2
    subdevice 2
}

---------------------------------

Using all 8 chans from aplay using device pcm0p doesnt cause the problem.

So it is a problem with using the pcm2p subdevices to access the DAC2
channels.

----------------------------------------------------------------------
 jdthood - 04-03-05 20:08 
----------------------------------------------------------------------
> So it is a problem with using the pcm2p subdevices to access the DAC2
channels.

Did you get any further in figuring out the problem?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-10-04 16:11 MWP            New Issue                                    
05-10-04 16:11 MWP            Distribution              => LFS             
05-10-04 16:11 MWP            Kernel Version            => 2.6.6           
05-10-04 16:13 MWP            Note Added: 0001079                          
05-11-04 14:56 tiwai          Note Added: 0001085                          
05-11-04 16:53 MWP            Note Added: 0001086                          
05-12-04 19:02 MWP            Note Added: 0001095                          
05-12-04 19:12 tiwai          Note Added: 0001096                          
05-12-04 19:34 MWP            Note Added: 0001099                          
05-13-04 11:37 MWP            Note Added: 0001101                          
05-13-04 11:38 MWP            Note Edited: 0001101                         
05-17-04 17:24 MWP            Note Added: 0001134                          
05-17-04 17:28 MWP            Note Added: 0001135                          
05-18-04 11:27 tiwai          Note Added: 0001138                          
05-18-04 12:38 MWP            Note Added: 0001139                          
05-18-04 13:03 tiwai          Note Added: 0001140                          
05-18-04 13:28 MWP            Note Added: 0001141                          
04-03-05 20:08 jdthood        Note Added: 0004318                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
