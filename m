From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000410]: Cannot listen to line-in and aux at the same time
Date: Tue, 28 Sep 2004 22:37:27 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040928203727.8C0F446008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EDADE2D7
	for <alsa-devel@alsa-project.org>; Tue, 28 Sep 2004 22:37:27 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000410
======================================================================
Reported By:                skamp
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     410
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               LFS 5.1.1, BLFS 5.1
Kernel Version:             2.4.26
======================================================================
Date Submitted:             07-27-2004 18:48 CEST
Last Modified:              09-28-2004 22:37 CEST
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
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
