From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000963]: Sounc card is mute
Date: Wed, 23 Mar 2005 01:00:03 +0100
Message-ID: <cc792c88997fd4103857dd89b61324ea@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7B164D2
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2005 01:00:03 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=963> 
======================================================================
Reported By:                jnilles
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   963
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     acknowledged
Distribution:               SuSE
Kernel Version:             
======================================================================
Date Submitted:             03-04-2005 19:07 CET
Last Modified:              03-23-2005 01:00 CET
======================================================================
Summary:                    Sounc card is mute
Description: 
I have a Turtle Beach Santa Cruz. It worked perfectly with SuSE Linux 9.0
and still works perfectly under Windows XP. I "upgraded" to SuSE 9.2 and
the sound card is inoperative, mute, lifeless, sound-free. The only advice
I got from SuSE support was that I shouldn't have skipped from 9.0 to 9.2
without going thgrough 9.1 on the way. That sounds like pretty stupid
advice.
I have spent weeks twiddling with settings  recommended by member sof the
alsa users group, to no avail.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0000988 No errors, but no sound output
======================================================================

----------------------------------------------------------------------
 jdthood - 03-22-05 14:58 
----------------------------------------------------------------------
Before we mark this "resolved", can you please check that you are
able to control the 'External Amplifier' setting with both alsamixer
and amixer?

----------------------------------------------------------------------
 madCoder - 03-23-05 01:00 
----------------------------------------------------------------------
The duplicate of this bug was my submission.
External Amplifier can be set by both amixer and alsamixer on my system. 
It also works with the alsamixer gui.

What exactly does this mixer switch control?  Turning it on was not needed
in older versions of ALSA, so I'm just curious what has changed to make it
now control whether sound is produced, when it never did before.  It might
also be worth mentioning in the changelog, since most people would not
have this enabled in their previous mixer configuration for this card (and
it is "Off" by default).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-04-05 19:07 jnilles        New Issue                                    
03-04-05 19:07 jnilles        Distribution              => SuSE            
03-09-05 18:53 tiwai          Note Added: 0003840                          
03-10-05 00:21 jnilles        Note Added: 0003846                          
03-10-05 15:01 jdthood        Note Added: 0003856                          
03-10-05 20:29 jnilles        Note Added: 0003872                          
03-10-05 22:04 jdthood        Note Added: 0003874                          
03-16-05 01:33 jnilles        Note Added: 0003926                          
03-16-05 12:31 tiwai          Note Added: 0003941                          
03-16-05 22:52 jnilles        Note Added: 0003972                          
03-17-05 10:11 jdthood        Note Added: 0003980                          
03-17-05 23:07 jnilles        Note Added: 0003986                          
03-18-05 14:38 jdthood        Note Added: 0003993                          
03-18-05 17:59 tiwai          Note Added: 0003997                          
03-18-05 22:42 jnilles        Note Added: 0004006                          
03-19-05 09:44 jdthood        Note Added: 0004025                          
03-19-05 18:55 jnilles        Note Added: 0004066                          
03-22-05 14:58 jdthood        Note Added: 0004125                          
03-22-05 15:13 jdthood        Relationship added       has duplicate 0000988
03-22-05 15:14 jdthood        Severity                 major => minor      
03-22-05 15:14 jdthood        Status                   new => acknowledged 
03-23-05 01:00 madCoder       Note Added: 0004147                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
