From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002258]: nForce4 + intel8x0 + Dolby
	Digital 5.1 + S/PDIF = crackle at start of playback
Date: Tue, 11 Jul 2006 18:54:26 +0200
Message-ID: <a667e2b91e9c47ea793e05abfb2f26ea@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 130A31AC
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Jul 2006 18:54:26 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2258> 
======================================================================
Reported By:                Human
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2258
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               KnoppMyth
Kernel Version:             2.6.17-chw-2
======================================================================
Date Submitted:             07-05-2006 22:12 CEST
Last Modified:              07-11-2006 18:54 CEST
======================================================================
Summary:                    nForce4 + intel8x0 + Dolby Digital 5.1 + S/PDIF =
crackle at start of playback
Description: 
Playing stereo audio never causes a crackle.  However, playback of 5.1
Dobly Digital content (standalone audio or audio embedded in video) causes
a quick but very loud sub-second audio crackle before playback continues,
when the previous playback was _not_ also multi-channel content.  The
problem always happens when the card is being asked to _switch_ to
multichannel audio _from_ either stereo or a non-initialized state.  The
crackle happens on both coaxial and optical S/PDIF connections to the
nForce4 (CK804) onboard soundcard.

The same receiver has not had a problem with S/PDIF with a different card
(Chaintech AV-710 / ice1724).
======================================================================

----------------------------------------------------------------------
 tiwai - 07-11-06 18:38 
----------------------------------------------------------------------
It's a known problem of SPDIF on nForce chipsets.  SPDIF non-audio output
doesn't work well because of lack of proper SPDIF status bit setting. 
Since SPDIF is transmitted directly from the audio chip, the changing
register in AC97 codec doesn't help.

Unfortuantely, we have no datasheet to fix this...

----------------------------------------------------------------------
 Human - 07-11-06 18:54 
----------------------------------------------------------------------
Hi, tiwai.  I don't understand the cause fully, but maybe I can still help.
 Is a workaround possible?  Half a second of silence would be far better
than half a second of static.  Perhaps muting the line, then using the
buggy procedure, then unmuting?  Or is the problem that the receiver is
being asked to switch to multichannel mode in such a way that the receiver
interprets part of the switch request as audible noise, so muting the
source would not help?  Is any workaround possible?

As for a real fix, has nVidia refused to provide the necessary datasheet
for the nForce4 chipset when asked?  If you tell me what specifically
would help fix the problem, I will do what I can to provide it.  I don't
exactly have an "in" with nVidia, but as a vendor who sells nVidia
products, they have assigned Linux troubleshooting techs to my requests in
the past.

Finally, if you point me to the relevant code in which the S/PDIF status
bit is set, couldn't I iterate through all possible settings and
eventually find the right one?  If the solution space is small enough, it
may be feasible.  Are we talking a 4-bit value or a 16-bit value?

If it's not appropriate to keep conversing back and forth in this bug
report, we can switch to email.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-05-06 22:12 Human          New Issue                                    
07-05-06 22:12 Human          File Added: asound.conf                      
07-05-06 22:12 Human          Distribution              => KnoppMyth       
07-05-06 22:12 Human          Kernel Version            => 2.6.17-chw-2    
07-05-06 22:13 Human          Issue Monitored: Human                       
07-11-06 18:34 Human          Note Added: 0010977                          
07-11-06 18:38 tiwai          Note Added: 0010978                          
07-11-06 18:54 Human          Note Added: 0010979                          
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
