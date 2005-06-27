From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000653]: poor microphone recording quality on pcicmi
Date: Mon, 27 Jun 2005 15:58:45 +0200
Message-ID: <d7e1138b69caa7f8ffd6b9bf7d62b3db@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 870671DD
	for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2005 15:58:45 +0200 (MEST)
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


The following issue has been set as RELATED TO issue 0001192.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=653> 
======================================================================
Reported By:                pbienst
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   653
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.9-gentoo-r4
======================================================================
Date Submitted:             11-18-2004 10:58 CET
Last Modified:              06-27-2005 15:58 CEST
======================================================================
Summary:                    poor microphone recording quality on pcicmi
Description: 
I have a C-Media PCI CMI8738-MC6 (rev 16) from a Hercules Muse DVD soundd
card.

When recording from a headset microphone, sound quality is really bad: low

volume and quite some noise / distortion.

I have my microphone mixers maxed out, 'Mic boost' is on, 'Mic as
Center/LFE' 
is off.

I've fiddled with all the other options, but they don't seem to affect the

quality.

I do my recording with:

arecord -D hw:1,0 -d 4 test.wav

Under Windows, sound quality is a lot better with the same setup.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001192 Microphone doesn't work in record and/o...
======================================================================

----------------------------------------------------------------------
 tiwai - 11-18-04 18:07 
----------------------------------------------------------------------
Could you try the attached patch and play with "MICBST", "EMUCB"
and "VADMIC3" mixer switches?

(AFAIK, "Mic Boost" affects only the mic playback volume.)

----------------------------------------------------------------------
 pbienst - 11-18-04 19:11 
----------------------------------------------------------------------
I applied the patch, but I'm not able to change these settings. With
alsamixer, they don't budge, and with amixer I get:

pbienst@pbienst:~: amixer -c 1 set MICBST unmute
Simple mixer control 'MICBST',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]

But immediately afterwards:

pbienst@pbienst:~: amixer -c 1 get MICBST
Simple mixer control 'MICBST',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]

----------------------------------------------------------------------
 pbienst - 11-18-04 19:26 
----------------------------------------------------------------------
In the absense of any user controls, I tried changing the options by
changing e.g.

CMIPCI_MIXER_SW_MONO("MICBST", CM_REG_EXTENT_IND, 2, 0),

to

CMIPCI_MIXER_SW_MONO("MICBST", CM_REG_EXTENT_IND, 2, 1),

In the module.

Unfortunately, none of these options seems to make any difference.

Trouble is course that there are so many different options, and if they
interact, it's like a combinatorial explosion.

Are there any mixer settings which could be important, and others which
are definitely unimportant for this problem?

----------------------------------------------------------------------
 tiwai - 11-18-04 19:33 
----------------------------------------------------------------------
They could be read only.  Do all of them behave so?

----------------------------------------------------------------------
 pbienst - 11-18-04 19:36 
----------------------------------------------------------------------
Yes, all 3 of them behave like that. But changing the driver source as I
did should have done the trick too?

----------------------------------------------------------------------
 tiwai - 11-18-04 19:54 
----------------------------------------------------------------------
No, the last argument is the inverse - you just flipped the meaning of 0
and 1.  So these bits also play nothing.

It seems that all existing mixer switches have no influence on your
problem at all.  No matter which combination, it's liekly useless.

Sorry, simply lack of hardware information.  I can't do any more.

----------------------------------------------------------------------
 pbienst - 11-18-04 20:01 
----------------------------------------------------------------------
Well, I don't think we have explored all options then, since I haven't been
able to set the "MICBST", "EMUCB" and "VADMIC3" mixer switches.

Which lines in the driver do I need to change to set these?

----------------------------------------------------------------------
 tiwai - 11-18-04 20:22 
----------------------------------------------------------------------
When you can't change the values via amixer properly, they are read-only 
values.  Changing the driver won't help then.  You can forget the patch.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-18-04 10:58 pbienst        New Issue                                    
11-18-04 10:58 pbienst        Distribution              => Gentoo          
11-18-04 10:58 pbienst        Kernel Version            => 2.6.9-gentoo-r4 
11-18-04 18:07 tiwai          Note Added: 0002453                          
11-18-04 18:08 tiwai          File Added: cmipci-test.diff                    
11-18-04 19:11 pbienst        Note Added: 0002459                          
11-18-04 19:26 pbienst        Note Added: 0002460                          
11-18-04 19:33 tiwai          Note Added: 0002461                          
11-18-04 19:36 pbienst        Note Added: 0002462                          
11-18-04 19:54 tiwai          Note Added: 0002467                          
11-18-04 20:01 pbienst        Note Added: 0002468                          
11-18-04 20:22 tiwai          Note Added: 0002469                          
06-27-05 15:58 tiwai          Relationship added       related to 0001192  
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
