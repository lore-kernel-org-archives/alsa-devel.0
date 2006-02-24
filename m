From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001618]: No Sound on Acer with Intel ICH6 HDA and Realtek ALC260
Date: Fri, 24 Feb 2006 12:21:55 +0100
Message-ID: <4c6fad194237dd6da7e58d66e687af96@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 57E5219A
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2006 12:21:56 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1618> 
======================================================================
Reported By:                robertw
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1618
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu 5.10
Kernel Version:             2.6.12-10-686
======================================================================
Date Submitted:             12-04-2005 21:24 CET
Last Modified:              02-24-2006 12:21 CET
======================================================================
Summary:                    No Sound on Acer with Intel ICH6 HDA and Realtek
ALC260
Description: 
I can load the snd-hda-intel module and play a file via aplay or xmms or
play a cd without any error, but I cannot hear anything neither via the
build-in speakers nor via headphones. All volume controllers are at 70%
and unmuted, except for PCM, because there is no mute/unmute-button.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001517 No sound on hda-intel on Acer TravelMat...
======================================================================

----------------------------------------------------------------------
 jwoithe - 02-23-06 01:12 
----------------------------------------------------------------------
Catching up on some recent posts here...

AndyP: I have noticed tinny output once: when trying to play though the
mic/linein jack.  As per my recent post on alsa-devel, I'm not entirely
sure what causes this yet.  In my case the tinny sound is not affected by
the setting of the respective pin mode control, so your situation is a
little different to mine (and also somewhat strange).  I really cannot
imagine why the enabling of the headphone amp should cause a loss of bass
in your case, and I'll need to think about this a bit more.  One thing I
will check: you've supplied your PCI ids in an earlier post, so I'll
compare those with the ones reported by my laptop.  Maybe we're dealing
with a different chip revision or something strange like that.

AndyP: I would look into the cause of those alsaplayer errors.  A quick
glance suggests that alsaplayer is having some difficulty and may indeed
be a reason why alsaplayer doesn't give any audio output.  One thing which
confuses me slightly though: if alsaplayer is nonfunctional, how did you
generate the audio you reported as being output from LINE1 on 18 Feb?  I
guess you used aplay for that, or some other audio player.

AndyP: the report of the LINE2 mode switch affecting the *treble* is
interesting.  We've had the reports of a loss of bass in some situations,
but not a loss of treble.  You also reported a loss of bass in another
situation.  Interesting.

lobstaj: it is true that to the best of my knowledge all analog controls
of the ALC260 chip are presented when "test" mode is active.  I have
however had another thought about these Acer laptops.  The ALC260 also has
a number of general purpose IO lines (GPIO) which are currently all set to
zero.  I'm wondering whether in some laptops (such as the acer) they are
used to switch on various external features for some pins - external power
amps, filters and the like.  To this end I will see about adding mixer
controls for these so we can see if they make any practical difference. 
It'll probably be early next week before I can get a patch out onto the
net.

----------------------------------------------------------------------
 lobstaj - 02-24-06 12:21 
----------------------------------------------------------------------
Good news! Sound on internal speakers on my Acer.. :-)

jwoithe: Yes, bingo! It was the GPIO.

Here's how I got it to work: I created a separate model for Acer and
copied everything from the 'test' model (init verbs, mixer, etc.). Then I
replaced the first line of the init verbs
  {0x01, AC_VERB_SET_GPIO_MASK, 0},

by the following 3 lines:
  {0x01, AC_VERB_SET_GPIO_MASK, 0x01},
  {0x01, AC_VERB_SET_GPIO_DIRECTION, 0x01},
  {0x01, AC_VERB_SET_GPIO_DATA, 0x01},

Where can I hand in a patch? Should I join the alsa-devel mailing list for
that?

These things need to be done:
  - somebody needs to verify that these 3 lines are correct (I mean they
work, yes, but I have no idea if they don't do something else too..)
  - the init verbs and mixer will have to be adjusted so that they only
have the parts that are useful for ALC260 on Acer

If somebody else could try these lines, thanks! Until now I only now they
work on Extensa 6702WLMi, no idea about the Aspire. Good luck and enjoy!
:-)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-04-05 21:24 robertw        New Issue                                    
12-04-05 21:24 robertw        Distribution              => Ubuntu 5.10     
12-04-05 21:24 robertw        Kernel Version            => 2.6.12-10-686   
12-05-05 07:12 jwoithe        Note Added: 0006908                          
12-05-05 19:35 timmy          Note Added: 0006914                          
12-06-05 15:52 tiwai          Note Added: 0006925                          
12-06-05 18:10 robertw        Note Added: 0006930                          
12-06-05 20:07 tiwai          Note Added: 0006934                          
12-06-05 20:08 tiwai          File Added: alc-cvs-fix.diff                    
12-06-05 20:09 tiwai          Note Added: 0006935                          
12-06-05 22:51 robertw        Note Added: 0006938                          
12-07-05 14:59 tiwai          Note Added: 0006941                          
12-07-05 15:00 tiwai          File Added: alc-cvs-fix2.diff                    
12-07-05 23:10 robertw        Note Added: 0006952                          
12-08-05 17:19 tiwai          Note Added: 0006957                          
12-08-05 22:01 robertw        File Added: codec#0                          
12-08-05 22:02 robertw        File Added: codec#1                          
12-08-05 22:03 robertw        File Added: asound.state                     
12-08-05 22:05 robertw        Note Added: 0006963                          
12-09-05 15:09 tiwai          Note Added: 0006966                          
12-09-05 16:35 robertw        Note Added: 0006967                          
12-09-05 17:03 tiwai          Note Added: 0006969                          
12-09-05 17:17 robertw        Note Added: 0006970                          
12-14-05 13:22 mytux          Issue Monitored: mytux                       
12-19-05 02:11 rlrevell       Note Added: 0007077                          
01-02-06 21:55 robertw        Note Added: 0007391                          
01-04-06 17:29 tiwai          Note Added: 0007441                          
01-04-06 22:00 robertw        Note Added: 0007453                          
01-04-06 22:16 robertw        Note Edited: 0007453                         
01-11-06 23:38 lobstaj        Note Added: 0007572                          
01-11-06 23:48 rlrevell       Note Added: 0007573                          
01-12-06 00:20 lobstaj        Note Added: 0007575                          
01-12-06 00:26 rlrevell       Note Added: 0007576                          
01-12-06 01:16 mytux          Note Added: 0007577                          
01-12-06 01:20 mytux          Note Edited: 0007577                         
01-12-06 14:13 robertw        Note Added: 0007586                          
01-12-06 14:43 lobstaj        Note Added: 0007587                          
01-12-06 16:45 eudoxos        Issue Monitored: eudoxos                     
01-12-06 21:04 rlrevell       Note Added: 0007591                          
01-13-06 01:11 rlrevell       Relationship added       duplicate of 0001517
01-13-06 08:03 eudoxos        Note Added: 0007631                          
01-13-06 11:30 er-ku          Issue Monitored: er-ku                       
01-16-06 00:32 jwoithe        Note Added: 0007682                          
01-17-06 23:32 ilovetronik    Issue Monitored: ilovetronik                    
01-19-06 23:36 ajmitch        Issue Monitored: ajmitch                     
02-08-06 14:46 svilen         Note Added: 0007965                          
02-09-06 00:29 jwoithe        Note Added: 0007969                          
02-09-06 09:04 hweigel        Issue Monitored: hweigel                     
02-10-06 11:02 svilen         Note Added: 0007999                          
02-12-06 21:42 AndyP          Note Added: 0008031                          
02-12-06 22:11 wattazoum      Note Added: 0008032                          
02-12-06 22:14 rlrevell       Note Added: 0008033                          
02-12-06 23:05 er-ku          Note Added: 0008034                          
02-12-06 23:07 er-ku          Note Edited: 0008034                         
02-13-06 00:45 jwoithe        Note Added: 0008035                          
02-13-06 06:42 er-ku          Note Added: 0008037                          
02-13-06 06:43 er-ku          Note Edited: 0008037                         
02-14-06 00:07 jwoithe        Note Added: 0008066                          
02-18-06 23:48 AndyP          Note Added: 0008125                          
02-19-06 10:41 er-ku          Note Added: 0008131                          
02-19-06 16:49 AndyP          Note Added: 0008134                          
02-22-06 18:29 lobstaj        Note Added: 0008160                          
02-23-06 01:12 jwoithe        Note Added: 0008165                          
02-24-06 12:21 lobstaj        Note Added: 0008173                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
