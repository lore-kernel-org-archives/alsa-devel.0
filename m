From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000410]: Cannot listen to line-in and aux at the same time
Date: Wed, 29 Sep 2004 02:14:33 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040929001433.6094446008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CBA5F317
	for <alsa-devel@alsa-project.org>; Wed, 29 Sep 2004 02:14:33 +0200 (MEST)
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


The following bug has been REOPENED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=0000410
======================================================================
Reported By:                skamp
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     410
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     feedback
Distribution:               LFS 5.1.1, BLFS 5.1
Kernel Version:             2.4.26
======================================================================
Date Submitted:             07-27-2004 18:48 CEST
Last Modified:              09-29-2004 02:14 CEST
======================================================================
Summary:                    Cannot listen to line-in and aux at the same time
Description: 
I cannot listen to sound coming from line-in and aux at the same time,
since I have to switch between either one of them with the "capture"
switch.
I can't listen to both line-in or aux and pcm, for that matter, since I
have to switch H/W and H/W 1 from PCM Out to H/W In 0 and vice versa.

I have my TV plugged to line-in, and my DXR3 MPEG2 decoder plugged to aux,
and I found it convenient with my former sound card (Sound Blaster Live!
with OSS drivers) to be able to listen to either source (TV, DVD or PCM)
without unplugging my headphones or triggering any switch.
======================================================================

----------------------------------------------------------------------
 tiwai - 07-30-2004 16:51 CEST 
----------------------------------------------------------------------
Isn't it a hardware limitation?

----------------------------------------------------------------------
 skamp - 08-01-2004 14:29 CEST 
----------------------------------------------------------------------
How would I know? I can't believe a €80+ sound card wouldn't provide this
feature anyway - if that's the case, then I've been really screwed...

----------------------------------------------------------------------
 skamp - 08-01-2004 18:00 CEST 
----------------------------------------------------------------------
OK, I just installed Windows Server 2003 in order to test Terratec's
official drivers, and I found out what I expected: the drivers and control
panel allow me to listen to as well as record from all sources (pcm,
line-in, aux...), either each one separately or all of them
simultaneously. I can actually select exactly which source(s) I want to
listen to or record from. This is the expected feature set, and it works
right out of the box.

I would like to know what is needed for bringing full support of this
sound card to linux (via alsa, I guess): documentation from the
manufacturer? time? motivation? money? more developers? user feedback?
testing?

----------------------------------------------------------------------
 tiwai - 08-02-2004 18:21 CEST 
----------------------------------------------------------------------
AFAIK, some inputs are just a connection from AC97 codec.
You can try to adjust Line, Aux, etc playback volumes and
choose 'Mix' as the capture source, so that the mixed playback
(passthru) signals on that ac97 chip is routed back to the
capture.

----------------------------------------------------------------------
 ungod - 09-28-2004 22:37 CEST 
----------------------------------------------------------------------
This is fixed in the latest CVS (See bugnote 0000510 for details)

----------------------------------------------------------------------
 tiwai - 09-28-2004 23:15 CEST 
----------------------------------------------------------------------
Ok, then close this bug now.

----------------------------------------------------------------------
 skamp - 09-29-2004 02:14 CEST 
----------------------------------------------------------------------
I just installed alsa-* from CVS: the bug is NOT fixed. I still can't
listen to both line-in AND sound coming from applications (line-out - I'm
not talking about optical-out). Besides, line-in is now monophonic,
although I can hear the sound in both speakers of my headphones.
"amixer cset numid=24 on,off" (that's the "Capture switch") returns
"values=off,on", and so does "amixer cset numid=24 off,off".
The mixer (or driver, I don't know) is also very buggy (as you predicted);
it took me about 15 minutes just to figure out how to hear sound coming
from line-in at a reasonable volume.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-27-04 18:48 skamp          New Bug                                      
07-27-04 18:48 skamp          File Added: aadebug                          
07-27-04 18:48 skamp          Distribution              => LFS 5.1.1, BLFS 5.1
07-27-04 18:48 skamp          Kernel Version            => 2.4.26          
07-30-04 16:51 tiwai          Bugnote Added: 0001491                       
08-01-04 14:29 skamp          Bugnote Added: 0001515                       
08-01-04 18:00 skamp          Bugnote Added: 0001516                       
08-02-04 18:21 tiwai          Bugnote Added: 0001523                       
09-28-04 22:37 ungod          Bugnote Added: 0001958                       
09-28-04 23:15 tiwai          Bugnote Added: 0001959                       
09-28-04 23:15 tiwai          Assigned To               => tiwai           
09-28-04 23:15 tiwai          Resolution               open => fixed       
09-28-04 23:15 tiwai          Status                   new => resolved     
09-29-04 02:14 skamp          Bugnote Added: 0001963                       
09-29-04 02:14 skamp          Resolution               fixed => reopened   
09-29-04 02:14 skamp          Status                   resolved => feedback
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
