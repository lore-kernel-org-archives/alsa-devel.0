From: noreply@alsa-project.org
Subject: [ALSA - driver 0000272]: Sound playback fast
Date: Fri, 16 Jul 2004 12:54:15 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716105415.0F22526008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 84B5D217
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:54:15 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000272
======================================================================
Reported By:                r_f_o_t
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     272
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Slackware current
Kernel Version:             2.4.26
======================================================================
Date Submitted:             05-13-2004 00:09 CEST
Last Modified:              07-16-2004 12:54 CEST
======================================================================
Summary:                    Sound playback fast
Description: 
Sound files playback at higher than normal pitch using both pre-compiled
Slackware packages and self-compiled sources. Downgraded to 1.0.3 and no
problems.
======================================================================

----------------------------------------------------------------------
 tiwai - 05-13-2004 12:55 CEST 
----------------------------------------------------------------------
show the ac97 codec info/registers in /proc/asound/card0/codec97#0/* files.

----------------------------------------------------------------------
 r_f_o_t - 05-13-2004 23:58 CEST 
----------------------------------------------------------------------
info:
0-0/0: Realtek ALC101

Capabilities     :
DAC resolution   : 16-bit
ADC resolution   : 16-bit
3D enhancement   : Realtek 3D Stereo Enhancement

Current setup
Mic gain         : +20dB [+20dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : on
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=1 AMAP DSA=0
Extended status  :

registers:
Version 1.0.3

0:00 = 5800
0:02 = 0707
0:04 = 0000
0:06 = 0000
0:08 = 0000
0:0a = 001e
0:0c = 001f
0:0e = 005f
0:10 = 1f1f
0:12 = 0303
0:14 = 0000
0:16 = 1f1f
0:18 = 0303
0:1a = 0606
0:1c = 0000
0:1e = 0000
0:20 = 2000
0:22 = 0000
0:24 = 0000
0:26 = 800f
0:28 = 0600
0:2a = 0000
0:2c = 0000
0:2e = 0000
0:30 = 0000
0:32 = 0000
0:34 = 0000
0:36 = 0000
0:38 = 0000
0:3a = 0000
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 0000
0:5e = 0000
0:60 = 0000
0:62 = 0000
0:64 = 0000
0:66 = 0000
0:68 = 0000
0:6a = 0000
0:6c = 0000
0:6e = 0002
0:70 = 0002
0:72 = 0058
0:74 = 0000
0:76 = 0000
0:78 = 0000
0:7a = 0000
0:7c = 414c
0:7e = 4730

Version 1.0.4

0:00 = 5800
0:02 = 0707
0:04 = 0000
0:06 = 0000
0:08 = 0000
0:0a = 001e
0:0c = 001f
0:0e = 005f
0:10 = 1f1f
0:12 = 0303
0:14 = 0000
0:16 = 1f1f
0:18 = 0303
0:1a = 0606
0:1c = 0000
0:1e = 0000
0:20 = 2000
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 0600
0:2a = 0000
0:2c = 0000
0:2e = 0000
0:30 = 0000
0:32 = 0000
0:34 = 0000
0:36 = 0000
0:38 = 0000
0:3a = 0000
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 0000
0:5e = 0000
0:60 = 0000
0:62 = 0000
0:64 = 0000
0:66 = 0000
0:68 = 0000
0:6a = 0000
0:6c = 0000
0:6e = 0002
0:70 = 0002
0:72 = 0058
0:74 = 0000
0:76 = 0000
0:78 = 0000
0:7a = 0000
0:7c = 414c
0:7e = 4730

Difference is line 20, v1.0.3 800f, v1.0.4 000f
Hope this is what you wanted.

P.S. I did not mean to make the "View Status" private.

edited on: 05-13-04 23:58

----------------------------------------------------------------------
 tiwai - 05-14-2004 12:20 CEST 
----------------------------------------------------------------------
is the info identical between 1.0.3 and 1.0.4?
the register 0x26 should be ok, it's EAPD bit.

if the info is correct, the chip doesn't support VRA, so it
supports only 48k Hz.  if you play mp3 with hw:0, you *MUST*
have fast playback.

what didn't work exactly and what DID work with 1.0.3?

----------------------------------------------------------------------
 r_f_o_t - 05-14-2004 16:16 CEST 
----------------------------------------------------------------------
the info is identical

wav files playback fine in 1.0.3 but playback fast in 1.0.4

----------------------------------------------------------------------
 tiwai - 05-14-2004 16:35 CEST 
----------------------------------------------------------------------
which app did you use?
try "aplay some-44khz.wav" as the test.

if you still get a fast playback, check 
/proc/asound/card0/pcm0p/sub0/hw_params
during the playback, whether the sample rate 48000 is set
correctly.

----------------------------------------------------------------------
 r_f_o_t - 05-14-2004 18:04 CEST 
----------------------------------------------------------------------
OK, it's seems to be KDE's arts daemon (1.2.2) that is not playing nice
with 1.0.4 With 1.0.3, it sets the sample rate correctly at 48000, but
with 1.0.4, it sets the sample rate at 44100. When I kill X, it stays at
the wrong rate.
Tried in gnome, xfce, console, with aplay and play, all good. Start kde,
fast playback until reboot. If I set custom sample rate in kde, it works
fine until killing X, then it's wrong in console again.

----------------------------------------------------------------------
 tiwai - 05-25-2004 18:47 CEST 
----------------------------------------------------------------------
ok close now this bug, since it's a KDE specific problem.

----------------------------------------------------------------------
 r_f_o_t - 05-25-2004 19:07 CEST 
----------------------------------------------------------------------
I'm sorry, I don't understand how this is not a bug. As I noted in bugnote
of 05-14-04 18:04, version 1.0.3 works fine, version 1.0.4 does not. The
only change was alsa from 1.0.3 - 1.0.4, while all KDE stuff, including
artsd stayed the same.
Thanks, Chuck

----------------------------------------------------------------------
 tiwai - 05-25-2004 19:36 CEST 
----------------------------------------------------------------------
the problem is that you set 'IEC958 Output Switch' on, regardless of
the ALSA version...  it's fixed now on CVS.  will appear on 1.0.5-rc2.

----------------------------------------------------------------------
 r_f_o_t - 05-25-2004 19:47 CEST 
----------------------------------------------------------------------
Thanks very much for the clarification.
Chuck

----------------------------------------------------------------------
 tiwai - 05-26-2004 14:40 CEST 
----------------------------------------------------------------------
closing this again :)

if you still have problems with 1.0.5, reopen once more...

Bug History
Date Modified  Username       Field                    Change              
======================================================================
05-13-04 00:09 r_f_o_t        New Bug                                      
05-13-04 00:09 r_f_o_t        Distribution              => Slackware current
05-13-04 00:09 r_f_o_t        Kernel Version            => 2.4.26          
05-13-04 00:10 r_f_o_t        Bug Monitored: r_f_o_t                       
05-13-04 12:55 tiwai          Bugnote Added: 0001102                       
05-13-04 18:26 r_f_o_t        Bugnote Added: 0001105                       
05-13-04 23:58 r_f_o_t        Bugnote Edited: 0001105                      
05-14-04 12:20 tiwai          Bugnote Added: 0001109                       
05-14-04 16:16 r_f_o_t        Bugnote Added: 0001112                       
05-14-04 16:35 tiwai          Bugnote Added: 0001113                       
05-14-04 18:04 r_f_o_t        Bugnote Added: 0001115                       
05-25-04 18:47 tiwai          Bugnote Added: 0001228                       
05-25-04 18:47 tiwai          Assigned To               => tiwai           
05-25-04 18:47 tiwai          Resolution               open => not a bug   
05-25-04 18:47 tiwai          Status                   new => resolved     
05-25-04 19:02 r_f_o_t        Bug End Monitor: r_f_o_t                     
05-25-04 19:02 r_f_o_t        Bug Monitored: r_f_o_t                       
05-25-04 19:07 r_f_o_t        Bugnote Added: 0001229                       
05-25-04 19:07 r_f_o_t        Resolution               not a bug => reopened
05-25-04 19:07 r_f_o_t        Status                   resolved => feedback
05-25-04 19:36 tiwai          Bugnote Added: 0001233                       
05-25-04 19:47 r_f_o_t        Bugnote Added: 0001234                       
05-26-04 14:40 tiwai          Bugnote Added: 0001258                       
05-26-04 14:40 tiwai          Resolution               reopened => fixed   
05-26-04 14:40 tiwai          Status                   feedback => resolved
07-16-04 12:54 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
