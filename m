From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000214]: ac3 passthrough not working
Date: Mon, 20 Sep 2004 19:55:22 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040920175522.4CBB34904D@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id BB314335
	for <alsa-devel@alsa-project.org>; Mon, 20 Sep 2004 19:55:22 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000214
======================================================================
Reported By:                m_stolle
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     214
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.4.25
======================================================================
Date Submitted:             04-16-2004 05:06 CEST
Last Modified:              09-20-2004 19:55 CEST
======================================================================
Summary:                    ac3 passthrough not working
Description: 
I have a Dell Inspiron 8200 with an Intel ICH3/Cirrus Logic CS4205 sound
card.  Unfortunately, the hardware AC3 passthrough does not work. 
Instead, I only get a high-pitched funny noise.

The symptoms are the same in mplayer as well as in xine.  Verbose output
of mplayer provided below:
======================================================================

----------------------------------------------------------------------
 m_stolle - 09-11-2004 05:25 CEST 
----------------------------------------------------------------------
This bug is still present in 2.6.8.1  Am I the only one with this bug?

----------------------------------------------------------------------
 tiwai - 09-13-2004 15:41 CEST 
----------------------------------------------------------------------
How about ALSA-1.0.7rc1?  2.6.8.1 includes the older version.

----------------------------------------------------------------------
 m_stolle - 09-17-2004 05:05 CEST 
----------------------------------------------------------------------
I just recompiled alsa 1.0.7rc1

still same problem 8-(

----------------------------------------------------------------------
 stoffel - 09-17-2004 10:45 CEST 
----------------------------------------------------------------------
I have the same notebook and the same problem with SuSE 9.0 and alsa 1.06a
(kernel 2.4.27). So, any solution for that problem ?

 The 5.1 sound works without passthrough with following entry in
.xine/config

audio.alsa_a52_device:iec958:AES0=0x4,AES1=0x82,AES2=0x0,AES3=0x2.

First I start mplayer with

#mplayer -ao alsa1x:spdif dvd://
.

After that I could start xine and my 5.1 Soundsystem works (without
passthrough !!!)
 
I don't know how I get the information for the xine entry. I still probe
many tools for alsa & co and so I've got the information. Where ? I don't
know, sorry.

edited on: 09-17-04 10:43

edited on: 09-17-04 10:45

----------------------------------------------------------------------
 m_stolle - 09-17-2004 14:12 CEST 
----------------------------------------------------------------------
I have tried recreating those steps, but it still doesn't work.  I first
start mplayer with exactly the options you describe (no sound though?). 
Then I edited .xine/config, started xine, switched to 5.1 surround
(instead of stereo 2.0), restart xine, no more sound.  Redid the mplayer
command, started xine again, still no sound.

Which version of xine/mplayer are you using?  AFAIK, the alsa1x driver for
mplayer is not used anymore, it's just alsa ?  My Xine version is 0.99.1,
my mplayer version is   1.0pre5-3.3.4.

Thanks,
  Martin

----------------------------------------------------------------------
 stoffel - 09-18-2004 16:55 CEST 
----------------------------------------------------------------------
Hello m_stolle,

my mplayer version is  1.0pre4-3.3.1 and it works fine with mplayer and
the alsa1x:spdif option. With xine (since version 0.98, I beleave) I must
probe something. Most of the time it will be work, sometime it doesn*t
;-(. But anytime with mplayer. 
The 5.1 output by the laptop is on the left side (video and audio -> av
adapter ). This output I connect with a 5.1 System (loudspeaker with an
internal 5.1 decoder). Because the passthrough don't work, the 5.1 system
play the 5.1 sound from the laptop (notebook). The internal decoder of the
5.1 system will not be use.

Sorry, for the bad english. I need a new course in english.I hope you
understand me ;-).

stefan

edited on: 09-18-04 16:54

edited on: 09-18-04 16:55

----------------------------------------------------------------------
 m_stolle - 09-18-2004 17:50 CEST 
----------------------------------------------------------------------
I think I understand you, but I am not sure what you mean.  The Inspiron
8.2k does not have a 5.1 output, only a digital S/PDIF output (via dongle
on the left side).  In general, when playing a DVD using software, there
are two ways the sound can get out of the computer:  Either a Software
surround (AC3/DTS) decoder is used and the decoded sound is to a sound
card with multiple discrete analog outputs (not possible on I8.2k, because
no such sound card), OR, the digital sound is "passed-through" to the
S/PDIF and decoded by an external decoder.  I am assuming your speakers
have a built-in digital decoder and use the S/PDIF output via the dongle. 
Hence, you _ARE_ using pass-through.  Pass-through means bypassing the
software decoder and using an external decoder.

Maybe we should take this discussion off this bug-trackign system, can you
eMail me at mstoll@sus.mcgill.ca ? (In case you are German, you can eMail
me in German, as I am German, too)

----------------------------------------------------------------------
 tiwai - 09-20-2004 17:44 CEST 
----------------------------------------------------------------------
As tests, try ac3dec included in alsa-utils package.
(Run with -C option.)

This eliminates an ambiguous factor (the difference of apps).

----------------------------------------------------------------------
 stoffel - 09-20-2004 19:55 CEST 
----------------------------------------------------------------------
Maybe you are right ;-). The internal decoder is by mplayer or xine. I
don't know why, but I've got 5.1 Sound over the left output (av - adapter;
in the middle a yellow plug for video and on the side a same plug for
audio) without passthrough !!! Our Laptop is a dell inspiron 8200. If I
switch on passthrough I've got the same ugly noise like you get.
Sorry is the only thing I can tell you.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
04-16-04 05:06 m_stolle       New Bug                                      
04-16-04 05:06 m_stolle       Distribution              => Debian          
04-16-04 05:06 m_stolle       Kernel Version            => 2.4.25          
09-11-04 05:25 m_stolle       Bugnote Added: 0001744                       
09-13-04 15:41 tiwai          Bugnote Added: 0001747                       
09-17-04 05:05 m_stolle       Bugnote Added: 0001775                       
09-17-04 10:21 stoffel        Bugnote Added: 0001776                       
09-17-04 10:42 stoffel        Bugnote Added: 0001778                       
09-17-04 10:43 stoffel        Bugnote Edited: 0001776                      
09-17-04 10:43 stoffel        Bugnote Deleted: 0001778                     
09-17-04 10:45 stoffel        Bugnote Edited: 0001776                      
09-17-04 14:12 m_stolle       Bugnote Added: 0001779                       
09-18-04 16:52 stoffel        Bugnote Added: 0001782                       
09-18-04 16:54 stoffel        Bugnote Edited: 0001782                      
09-18-04 16:55 stoffel        Bugnote Edited: 0001782                      
09-18-04 17:50 m_stolle       Bugnote Added: 0001783                       
09-20-04 17:44 tiwai          Bugnote Added: 0001791                       
09-20-04 19:55 stoffel        Bugnote Added: 0001793                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
