From: noreply@alsa-project.org
Subject: [ALSA - driver 0000252]: input select seems wrong
Date: Fri, 16 Jul 2004 14:32:02 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716123202.4AF222C005@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9FAA1244
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 14:32:02 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000252
======================================================================
Reported By:                jwe21
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     252
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.6.5
======================================================================
Date Submitted:             05-03-2004 17:26 CEST
Last Modified:              07-16-2004 14:32 CEST
======================================================================
Summary:                    input select seems wrong
Description: 
Attempting to record from mic when input select set to "mic" gives error
pcm_read timeout error upon using arecord. Attempting same with input
select set to "line" correctly records.

lspci says:
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 50)

======================================================================

----------------------------------------------------------------------
 jwe21 - 05-03-2004 17:31 CEST 
----------------------------------------------------------------------
On re-reading my description, maybe it's not clear: in all cases I am
trying to record from the mic.

----------------------------------------------------------------------
 tiwai - 05-03-2004 18:03 CEST 
----------------------------------------------------------------------
i'm not sure which motherboard is affected by this switch.

if it's really a minor feature no mobo uses, we can ommit this
to avoid confusion, or rename mic/line to somewhat more generic
such as input1/input2.

to be sure: if you select "Line", does the mic input work fine,
right?  and does line-input work at the same time properly?

----------------------------------------------------------------------
 jwe21 - 05-03-2004 18:17 CEST 
----------------------------------------------------------------------
Had not tried to test line in till now. Neither choice of input select nor
mic select allowed to record line in.

Input Select = "Mic" ==> pcm_read error (see the "steps to reproduce")
Input Select = "Line" ==> recording from mic works, line-in apparently
ignored

Mic Select = "Mic1" or "Mic2" has no effect.

Your msg suggests info on motherboard might be useful. lspci says:
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP]
Host Bridge
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge

----------------------------------------------------------------------
 tiwai - 05-03-2004 18:22 CEST 
----------------------------------------------------------------------
hmm, did you choose Line as the "Capture Source", not in the
"Input Source"?  on alsamixer, you can choose it by hitting Space
on "Mic".

(it's a dumb question - again, to be sure :-)

----------------------------------------------------------------------
 jwe21 - 05-03-2004 18:57 CEST 
----------------------------------------------------------------------
Not dumb I think. I was choosing line as "Input Source Select". I've tried
again with muted and unmuted "mic" in alsamixer (which I presume is what
you mean - pressing space doesnt seem to do anything) and no effect, still
cannot _record_ the line input. However I am hearing the line input on the
headphone output, and can control its volume by adjusting the volume on
"Line" in alsamixer.

----------------------------------------------------------------------
 tiwai - 05-03-2004 19:01 CEST 
----------------------------------------------------------------------
hmm, do you have the red 'CAPTUR' on the top of Line volumr bar?
(the above is a typo.  you need to hit space not on "Mic" but on "Line",
of course)

BTW, the volume of 'Line' is the playback volume of line-input.
it has nothing to do with the recording level.

----------------------------------------------------------------------
 jwe21 - 05-03-2004 20:17 CEST 
----------------------------------------------------------------------
Ok yes, I should have RTFM! Have now managed to record "line" and "mic".
Everything works, this is merely user confusion! - your suggestion of
changing input source select options to have more generic names such as
input1/input2 sounds like the right one.

It would be cool if it could be automatically detected if only one input
source is present (and then not present the option of input2).

----------------------------------------------------------------------
 tiwai - 05-06-2004 15:29 CEST 
----------------------------------------------------------------------
fixed on CVS.  now it's Line1 / Line2.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
05-03-04 17:26 jwe21          New Bug                                      
05-03-04 17:26 jwe21          Distribution              => Gentoo          
05-03-04 17:26 jwe21          Kernel Version            => 2.6.5           
05-03-04 17:31 jwe21          Bugnote Added: 0001022                       
05-03-04 18:03 tiwai          Bugnote Added: 0001024                       
05-03-04 18:17 jwe21          Bugnote Added: 0001025                       
05-03-04 18:22 tiwai          Bugnote Added: 0001026                       
05-03-04 18:57 jwe21          Bugnote Added: 0001029                       
05-03-04 19:01 tiwai          Bugnote Added: 0001030                       
05-03-04 20:17 jwe21          Bugnote Added: 0001033                       
05-06-04 15:29 tiwai          Bugnote Added: 0001061                       
05-06-04 15:29 tiwai          Assigned To               => tiwai           
05-06-04 15:29 tiwai          Resolution               open => fixed       
05-06-04 15:29 tiwai          Status                   new => resolved     
07-16-04 14:32 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
