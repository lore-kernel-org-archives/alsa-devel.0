From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000565]: Bug reported to gnomemeeting team
Date: Mon, 18 Oct 2004 18:03:37 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041018160337.E07CF11030@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3E43B2D9
	for <alsa-devel@alsa-project.org>; Mon, 18 Oct 2004 18:03:38 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000565
======================================================================
Reported By:                mirko
Assigned To:                
======================================================================
Project:                    ALSA - lib
Bug ID:                     565
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             10-04-2004 14:35 CEST
Last Modified:              10-18-2004 18:03 CEST
======================================================================
Summary:                    Bug reported to gnomemeeting team
Description: 
http://bugzilla.gnome.org/show_bug.cgi?id=153770

D. Sandras says it's a big-endian/little-endian problem and suggested to
report it here.



======================================================================

----------------------------------------------------------------------
 jcdutton - 10-04-2004 15:01 CEST 
----------------------------------------------------------------------
Summary of bug:
S16_BE format fails.
The following works:
arecord -f S16_LE -c 1 -r 8000 -D plughw:0 >test1.wav
The following fails:
arecord -f S16_BE -c 1 -r 8000 -D plughw:0 >test1.wav
arecord: begin_wave:1617: Wave doesn't support S16_BE format...

As this is a plug device, it should work.

----------------------------------------------------------------------
 tiwai - 10-04-2004 15:58 CEST 
----------------------------------------------------------------------
WAV format doesn't support big-endian.  That's independent from plug
layer.

----------------------------------------------------------------------
 jdthood - 10-17-2004 15:13 CEST 
----------------------------------------------------------------------
What is probably the same bug was reported to the Debian BTS:

    http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=245040

----------------------------------------------------------------------
 tiwai - 10-18-2004 18:03 CEST 
----------------------------------------------------------------------
Hmm, too little info.  Can't you get a bt with symbols?

At least, we need to know the h/w information and hw_params,
sw_params setting running in GM.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
10-04-04 14:35 mirko          New Bug                                      
10-04-04 15:01 jcdutton       Bugnote Added: 0002010                       
10-04-04 15:58 tiwai          Bugnote Added: 0002011                       
10-17-04 15:13 jdthood        Bugnote Added: 0002192                       
10-18-04 18:03 tiwai          Bugnote Added: 0002198                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
