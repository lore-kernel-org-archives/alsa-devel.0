From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000374]: Support for SB Audigy LS Soundcards
Date: Tue, 10 Aug 2004 12:00:15 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040810100015.927F41102F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id F2305207
	for <alsa-devel@alsa-project.org>; Tue, 10 Aug 2004 12:00:15 +0200 (MEST)
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


The following bug has been RESOLVED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=0000374
======================================================================
Reported By:                whity
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     374
Category:                   OTHERS
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               ALL (especially SuSE 9.1 an above)
Kernel Version:             2.6.5
Resolution:                 fixed
======================================================================
Date Submitted:             07-10-2004 11:16 CEST
Last Modified:              08-10-2004 12:00 CEST
======================================================================
Summary:                    Support for SB Audigy LS Soundcards
Description: 
ALSA and EMU10k1 does not support the Audigy LS Card.
Only OSS/Linux support it but it costs. Is it possible to use the OSS
Drivers with ALSA? Or can anybody develop a working driver?
======================================================================

----------------------------------------------------------------------
 jcdutton - 07-10-2004 13:07 CEST 
----------------------------------------------------------------------
I am in the process of reverse engineering the Audigy LS, and there is
currently a audigyls driver in the alsa-driver CVS that can produce
sound.
As we don't have datasheets, progress is slow.

----------------------------------------------------------------------
 whity - 07-10-2004 13:57 CEST 
----------------------------------------------------------------------
Can you send me a detailed installation tutorial for SuSE 9.1 Professional?
or your email/ICQ?
Iam not a professional so i need some help.

----------------------------------------------------------------------
 jcdutton - 07-10-2004 14:03 CEST 
----------------------------------------------------------------------
As you are "not a professional", I suggest that the best action to take is
to wait for the next alsa-driver release. Date for release is not set.

----------------------------------------------------------------------
 Luke - 07-10-2004 14:53 CEST 
----------------------------------------------------------------------
I just checked out the audigyls driver and it compiled. As I am writing
that, I am listening to a web radio via xmms and sound quality is pretty
good.
But I am having problems setting up capturing. I don't understand your
comments in 'audigyls.c':

"*    Notes on how to capture sound:
 *      The AC97 is used in the PLAYBACK direction.
 *      The output from the AC97 chip, instead of reaching the speakers,
is fed into the Philips 1361T ADC.
 *      So, to record from the MIC, set the MIC Playback volume to max,
 *      unmute the MIC and turn up the MASTER Playback volume.
 *      So, to prevent feedback when capturing, minimise the "Capture
feedback into Playback" volume."

I don't have any "MASTER Playback volume" to configure. After playing
around with it a bit, my system hung. I'm using gentoo, kernel 2.6.7. I
tried several configs with 'arecord -f cd test.wav' and 'aplay test.wav'
but couldn't get more than some noises.

----------------------------------------------------------------------
 whity - 08-03-2004 23:10 CEST 
----------------------------------------------------------------------
Especially for J. C. Dutton i asked the Creative Open Source Department for
a Description of the Audigy LS Hardware he answered the following:

"Email: From: ghiebert@creativelabs.com | Re: Linux Audigy LS Card
Information needed

I'm currently working with the Creative legal department to create an NDA
for use by open source developers such as yourself.  The specification
would be released to an individual developer under NDA such that they
could create code based on the specification but could not re-distribute
the specification itself.  I don't know when this NDA will be available,
but I'm hoping that it can be ready by the end of August. 

Garin"

So at the End of August, you can ask him again to get the NDA for the
Audigy LS to develop a good working Driver much faster.

Greets WHiTY

----------------------------------------------------------------------
 perex - 08-10-2004 12:00 CEST 
----------------------------------------------------------------------
Audigy LS driver is in 1.0.6rc driver packages. Please, create another bug
report for specific problems.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-10-04 11:16 whity          New Bug                                      
07-10-04 11:16 whity          Distribution              => ALL (especially SuSE 9.1 an above)
07-10-04 11:16 whity          Kernel Version            => 2.6.5           
07-10-04 13:07 jcdutton       Bugnote Added: 0001398                       
07-10-04 13:57 whity          Bugnote Added: 0001399                       
07-10-04 14:03 jcdutton       Bugnote Added: 0001400                       
07-10-04 14:53 Luke           Bugnote Added: 0001401                       
08-03-04 23:10 whity          Bugnote Added: 0001531                       
08-10-04 12:00 perex          Bugnote Added: 0001549                       
08-10-04 12:00 perex          Assigned To               => perex           
08-10-04 12:00 perex          Resolution               open => fixed       
08-10-04 12:00 perex          Status                   new => resolved     
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
