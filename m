From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000270]: Audigy 2 ZS side surround channels not supported
Date: Fri, 27 Aug 2004 20:20:48 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040827182048.0CFA72C008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 652CE1F6
	for <alsa-devel@alsa-project.org>; Fri, 27 Aug 2004 20:20:48 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000270
======================================================================
Reported By:                wraiden
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     270
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               LFS
Kernel Version:             2.6.5
======================================================================
Date Submitted:             05-11-2004 11:14 CEST
Last Modified:              08-27-2004 20:20 CEST
======================================================================
Summary:                    Audigy 2 ZS side surround channels not supported
Description: 
There is no Support for the side surround channels on SB Audigy 2 ZS (
Platinum Pro ) in Alsa.

I'll try to get it work and test everything you give me to test.
======================================================================

----------------------------------------------------------------------
 pzad - 05-11-2004 14:41 CEST 
----------------------------------------------------------------------
First you must find where are these outputs connected.

in file alsa-driver/alsa-kernel/pci/emu10k1/emufx.c
is row with
A_PUT_STEREO_OUTPUT(A_EXTOUT_AFRONT_L, A_EXTOUT_AFRONT_R, playback +
SND_EMU10K1_PLAYBACK_CHANNELS); 

append after it this row
A_PUT_STEREO_OUTPUT(0x0c, 0x0d, playback + SND_EMU10K1_PLAYBACK_CHANNELS);


compile, instal, play something. If they are working, let me know.
If not then try change 
0x0c to 0x12 and 0x0d to 0x13
if stil not working try these too
0x12,0x13
0x14,0x15
0x19,0x1a
0x1b,0x1c
0x1d,0x1e

----------------------------------------------------------------------
 wraiden - 05-21-2004 16:21 CEST 
----------------------------------------------------------------------
side L ans R channels are working.
patch used for testing is attached.
is 6.1 and 7.1 Surround support in alsa planed?

----------------------------------------------------------------------
 pzad - 05-24-2004 09:21 CEST 
----------------------------------------------------------------------
I can create volume control (+ controls for mirroring stereo -> 7.1) for
these speakers, and devices something like rearside, and surround71. I
think under linux not many apps uses 7.1 speaker configuration.

----------------------------------------------------------------------
 wraiden - 05-24-2004 16:18 CEST 
----------------------------------------------------------------------
Nice :)

let me know when it's done and i'll test it.

7.1 related:
- dts and dolby codecs have support up to 7.1 ( and more ).
- sooner or later an decoder will support that.
- support for this speaker configuration would be a benefit for alsa.

----------------------------------------------------------------------
 pzad - 05-31-2004 08:38 CEST 
----------------------------------------------------------------------
Could you test attached patch audigy2zs_driver.diff ???
Mirroring should work.
There are two new controls:
PCM Side Playback Volume - this is not working for now.
Side Playback Volume - this controls mirroring to side speakers.

This is not final version.
TODO:
- Audigy 2 ZS detection
- alsa lib part

----------------------------------------------------------------------
 bryanhundven - 06-10-2004 22:48 CEST 
----------------------------------------------------------------------
I tried audigy2zs_driver.diff with alsa-driver-1.0.5a.
Seems to work, but as noted above PCM Side doesn't seem to work.

If you would like me to test anything specific other than xmms...
...Just Ask. :-D

----------------------------------------------------------------------
 wraiden - 06-15-2004 15:56 CEST 
----------------------------------------------------------------------
i've tested the patch against 1.0.5 and can verify the
above post.

i'll rebuild my entire system over the next weekend
and upgrade to the latest releases of everything.

I want to support alsa with code contributions and plan
to look at the API Documentation however i didn't know
where to begin ( any hints or links ? ).

7.1 related:
xine player seems to support 7.1 a/52 sound
i'm hounting for a good test 7.1 DVD ( a/52 and dts ) now.

----------------------------------------------------------------------
 pzad - 06-15-2004 16:41 CEST 
----------------------------------------------------------------------
I don't think that xine supports 7.1 (maybe I am wrong)

For 7.1 playback only changes in .conf files are needed in alsa-lib.
Driver should be ok with this patch.

----------------------------------------------------------------------
 wraiden - 06-15-2004 19:55 CEST 
----------------------------------------------------------------------
i've misinterpreted an article that was talking about the capability
of xine to streaming a/52 and dts sound to an external decoder, sorry.

just for the sake of completeness:

The Audigy 2 ZS cards also have support for an 6.1 speaker setup,
i don't know if the appopriate channel for the rear-center is the
left or the right channel of the side channels. i can't test it
because i don't have 6.1 speakers.
( i also didn't have a windoZZ version to test via driverswitch )

[ i'll try to find a way to find out the channel for rear-center now ]

bearbeitet am: 06-15-04 19:55

----------------------------------------------------------------------
 pzad - 06-22-2004 13:00 CEST 
----------------------------------------------------------------------
Can someone of you test this:

http://sourceforge.net/mailarchive/forum.php?thread_id=4976762&forum_id=1752

If it works for you I will make patch from this.

For one user this worked.

----------------------------------------------------------------------
 elklein - 06-22-2004 16:39 CEST 
----------------------------------------------------------------------
Yesterday, I reported that this worked, and it does, however I just wanted
to add a note. In order to get it to fully work, there are some changes
that need to be made:
1) Add the following lines to alsa.conf (after the corresponding
center_lfe lines):
defaults.pcm.side.card defaults.pcm.card
defaults.pcm.side.device defaults.pcm.device
2) Add the following line to alsa.conf (after the corresponding center_lfe
line):
pcm.side cards.pcm.side
3) DON'T add the surround70 lines from Peter's patch (since there is no
7.0 defined, just 7.1). This is just a quibling detail, so it doesn't
really hurt to have it there, but it also doesn't help.
4) Add appropriate code to alsa-lib install code to install side.conf and
surround71.conf to the /usr/share/alsa directories.

Hope that helps,

----------------------------------------------------------------------
 wraiden - 06-27-2004 22:00 CEST 
----------------------------------------------------------------------
i've tested it and can verify it's working ...

----------------------------------------------------------------------
 jcdutton - 06-27-2004 22:53 CEST 
----------------------------------------------------------------------
Although xine mentions 7.1 audio. If the user selects 7.1, it will still
only output to 5.1. The idea is the user tells xine what speaker
arrangement they have, and then xine will choose how best to use it.

----------------------------------------------------------------------
 jcdutton - 08-27-2004 20:20 CEST 
----------------------------------------------------------------------
Confirmed fixed in CVS.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
05-11-04 11:14 wraiden        New Bug                                      
05-11-04 11:14 wraiden        Distribution              => LFS             
05-11-04 11:14 wraiden        Kernel Version            => 2.6.5           
05-11-04 14:41 pzad           Bugnote Added: 0001084                       
05-21-04 16:15 wraiden        File Added: wraiden-alsa-emu10k1-side.patch                    
05-21-04 16:21 wraiden        Bugnote Added: 0001166                       
05-24-04 09:21 pzad           Bugnote Added: 0001181                       
05-24-04 16:18 wraiden        Bugnote Added: 0001188                       
05-31-04 08:32 pzad           File Added: audigy2zs_driver.diff                    
05-31-04 08:38 pzad           Bugnote Added: 0001281                       
06-10-04 22:48 bryanhundven   Bugnote Added: 0001298                       
06-15-04 15:56 wraiden        Bugnote Added: 0001309                       
06-15-04 16:41 pzad           Bugnote Added: 0001310                       
06-15-04 19:44 wraiden        Bugnote Added: 0001311                       
06-15-04 19:55 wraiden        Bugnote Edited: 0001311                      
06-22-04 13:00 pzad           Bugnote Added: 0001328                       
06-22-04 16:39 elklein        Bugnote Added: 0001329                       
06-27-04 22:00 wraiden        Bugnote Added: 0001341                       
06-27-04 22:53 jcdutton       Bugnote Added: 0001342                       
07-30-04 12:46 BiO            Bug Monitored: BiO                           
07-30-04 12:47 BiO            Bug End Monitor: BiO                         
08-27-04 20:20 jcdutton       Bugnote Added: 0001656                       
08-27-04 20:20 jcdutton       Status                   new => closed       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
