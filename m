From: noreply@alsa-project.org
Subject: [ALSA - driver 0000193]: cannot use more then 2 analog channels with cmipci
Date: Fri, 16 Jul 2004 12:47:13 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716104713.307DA26008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7708D255
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:47:13 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000193
======================================================================
Reported By:                konmal
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     193
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               SUSE 8.2
Kernel Version:             2.4.25-fe5
======================================================================
Date Submitted:             04-06-2004 23:25 CEST
Last Modified:              07-16-2004 12:47 CEST
======================================================================
Summary:                    cannot use more then 2 analog channels with cmipci
Description: 
I have 
C-Media PCI CMI8738-MC6 (model 55) at 0xe800, irq 7
Somewhere between 1.0.? and 1.0.4 something has changed,
so I cannot use more then 2 channels (analog, no SPDIF) now.
I tried speakers-test, aplay, mplayer...
All of them gives "invalid number of channels" if try to get 4.0 or 5.1
playback, like:
./speaker-test -D surround51 -c 6

speaker-test 0.0.4

Playback device is surround51
Stream parameters are 44100Hz, S16_LE, 6 channels
Sine wave rate is 440.0000Hz
Channels count (6) not available for playbacks: Invalid argument
Setting of hwparams failed: Invalid argument

I tried to switch IEC958 output on/off, IEC958 Loop etc - no way.
======================================================================

----------------------------------------------------------------------
 tiwai - 04-23-2004 17:22 CEST 
----------------------------------------------------------------------
which ALSA version?
do you have CMI8738-MC6.conf in /usr/share/alsa/cards?

----------------------------------------------------------------------
 konmal - 04-26-2004 21:41 CEST 
----------------------------------------------------------------------
Yes there is /usr/share/alsa/cards/CMI8738-MC6.conf
alsa is 1.0.4
Meanwhile I found the reason for the reported misbehaviour: KDE
Its sound control sets mixer settings to some very strange values.
I.e. after using KDE multichannel sound is not available.
As workaround, I have restored mixer settings to the reasonable ones,
saved /etc/asound.state as /etc/asound.state.ok 
and use 
sudo alsactl -f /etc/asound.state.ok in my login script.
Also /etc/asound.state.ok is saved before shutting the system down,
so it starts with good sound settings.

----------------------------------------------------------------------
 tiwai - 04-30-2004 11:38 CEST 
----------------------------------------------------------------------
oh my...

could you show the "wrong" asound.state KDE did if you still have?

----------------------------------------------------------------------
 konmal - 05-04-2004 22:44 CEST 
----------------------------------------------------------------------
Sorry, I didn't stored the KDE-broken asound.state
But the error is away now. I had some KDE upgrades via apt-get and 
the sound works now as expected, after KDE session too.
 I guess you can close the bug.

IIRC the right channel was muted/set to 0 and a funny combination of SPDIF
throughput/4 channels mode was set.

----------------------------------------------------------------------
 tiwai - 05-05-2004 11:11 CEST 
----------------------------------------------------------------------
ok, then anyway it's not the problem of sound driver.
i'll close this bug now.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
04-06-04 23:25 konmal         New Bug                                      
04-06-04 23:25 konmal         Distribution              => SUSE 8.2        
04-06-04 23:25 konmal         Kernel Version            => 2.4.25-fe5      
04-23-04 17:22 tiwai          Bugnote Added: 0000903                       
04-23-04 17:30 tiwai          Assigned To               => tiwai           
04-23-04 17:30 tiwai          Status                   new => assigned     
04-26-04 21:41 konmal         Bugnote Added: 0000955                       
04-30-04 11:38 tiwai          Bugnote Added: 0000980                       
05-04-04 22:44 konmal         Bugnote Added: 0001045                       
05-05-04 11:11 tiwai          Bugnote Added: 0001052                       
05-05-04 11:39 tiwai          Resolution               open => fixed       
05-05-04 11:39 tiwai          Status                   assigned => resolved
07-16-04 12:47 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
