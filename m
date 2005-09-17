From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000306]: compiles, but no sound comes out
Date: Sat, 17 Sep 2005 20:13:54 +0200
Message-ID: <48c90de599c9a00bfa3ee62b60fdc74c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1BD53166
	for <alsa-devel@alsa-project.org>; Sat, 17 Sep 2005 20:13:55 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=306> 
======================================================================
Reported By:                Quietti
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   306
Category:                   PPC - powermac
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             self-compiled 2.6.6 vanilla.
======================================================================
Date Submitted:             05-25-2004 20:35 CEST
Last Modified:              09-17-2005 20:13 CEST
======================================================================
Summary:                    compiles, but no sound comes out
Description: 
This is a plain vanilla kernel 2.6.6, which uses ALSA 1.0.4.

The kernel compiles fine, the snd_powermac module loads without any error,
but no sound comes up.

Running alsamixer gives me a mixer screen where none of the sliders can be
moved.
======================================================================

----------------------------------------------------------------------
 Quietti - 08-31-05 11:44 
----------------------------------------------------------------------
Kernel 2.6.13 shows some major improvements: 
Almost everything ALSA works on Burgundy as it should! :-) 
Whoever worked on this since 2.6.11 deserves a big hug!

master volume:    works as expected.
headphone volume: seems to control the internal stereo speakers instead.
Oops!
headphone detect: (what is this supposed to do?)
analog CD volume: works as expected.
line input:       (no analog signal to feed the input jack and test it)
microphone input: (feedbacks if I rise it high enough, so I'd assume it
works)
mono PC speaker:  seems to control the stereo headphones instead. Oops!
auto-mute:        (what is this supposed to do?)
console beep:     works as expected.

On a general note, I cannot seem to completely silence the internal stereo
speakers or the headphones, other than by muting the master volume.

Still, this is already a *major* improvement over previous ALSA releases:
I finally get some sound on this iMac CRT's Burgundy chip! Many thanks!
:-)

----------------------------------------------------------------------
 Quietti - 09-17-05 20:13 
----------------------------------------------------------------------
The Debian PPC community is compiling a list of current ALSA status for
each PowerMac chipset at http://wiki.debian.net/?PowerpcSoundcards

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-25-04 20:35 Quietti        New Issue                                    
05-25-04 20:35 Quietti        File Added: asound.state                     
05-25-04 20:35 Quietti        Distribution              => Debian          
05-25-04 20:35 Quietti        Kernel Version            => self-compiled 2.6.6
vanilla.
05-25-04 20:38 Quietti        Issue Monitored: Quietti                     
05-28-04 21:18 tiwai          Note Added: 0001274                          
05-28-04 21:37 Quietti        Note Added: 0001275                          
07-25-04 20:16 Quietti        Note Added: 0001473                          
09-08-04 06:32 Quietti        Note Added: 0001726                          
10-20-04 00:38 Quietti        Note Added: 0002209                          
01-06-05 18:14 Quietti        Note Added: 0003093                          
01-06-05 18:27 rlrevell       Note Added: 0003094                          
01-06-05 19:43 Quietti        Note Added: 0003095                          
01-07-05 00:00 Quietti        Note Added: 0003096                          
01-07-05 00:19 Quietti        Note Added: 0003097                          
01-07-05 00:30 Quietti        Note Added: 0003098                          
01-14-05 00:53 Quietti        Note Added: 0003206                          
02-04-05 09:22 Quietti        Note Added: 0003496                          
02-04-05 13:04 tiwai          Note Added: 0003499                          
04-02-05 13:33 Quietti        Note Added: 0004297                          
08-06-05 20:24 Quietti        Note Added: 0005682                          
08-06-05 20:31 rlrevell       Note Added: 0005683                          
08-06-05 20:32 rlrevell       Note Added: 0005684                          
08-06-05 20:53 rlrevell       Note Added: 0005685                          
08-06-05 21:17 rlrevell       Note Added: 0005686                          
08-06-05 23:54 rlrevell       Note Added: 0005687                          
08-06-05 23:55 rlrevell       Note Deleted: 0005683                        
08-06-05 23:55 rlrevell       Note Deleted: 0005684                        
08-07-05 10:03 pochini        Note Added: 0005689                          
08-07-05 10:31 Quietti        Note Added: 0005690                          
08-07-05 10:46 rlrevell       Note Added: 0005691                          
08-07-05 11:36 Quietti        Note Added: 0005692                          
08-07-05 11:44 Quietti        Note Added: 0005693                          
08-07-05 20:27 rlrevell       Note Added: 0005697                          
08-08-05 14:53 Quietti        Note Added: 0005708                          
08-08-05 19:42 rlrevell       Note Added: 0005711                          
08-11-05 13:09 Johannes Berg  Note Added: 0005755                          
08-11-05 13:09 Johannes Berg  Issue Monitored: Johannes Berg                    
08-31-05 11:44 Quietti        Note Added: 0005986                          
09-17-05 20:13 Quietti        Note Added: 0006259                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
