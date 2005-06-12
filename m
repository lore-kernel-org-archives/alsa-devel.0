From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0001164]: aoss + skype: volume_adjust: SOUND_MIXER_WRITE_IGAIN failed: Invalid argument
Date: Sun, 12 Jun 2005 19:35:22 +0200
Message-ID: <0d44d0c9935f2a9e3fc3e209fb21f762@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 314CC1A3
	for <alsa-devel@alsa-project.org>; Sun, 12 Jun 2005 19:35:23 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1164> 
======================================================================
Reported By:                sst4
Assigned To:                
======================================================================
Project:                    ALSA - liboss
Issue ID:                   1164
Category:                   
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             06-07-2005 00:33 CEST
Last Modified:              06-12-2005 19:35 CEST
======================================================================
Summary:                    aoss + skype: volume_adjust: SOUND_MIXER_WRITE_IGAIN
failed: Invalid argument
Description: 
I've tried 'skype' with my M-Audio Revolution 7.1.

Soon (probably in a second) after this command line:

aoss skype &

the terminal window gets filled with

volume_adjust: SOUND_MIXER_WRITE_IGAIN failed: Invalid argument

messages, and I do not hear anything in 'skype' connecting to their
automated 'echo123' service.

The message is not quite clear, and I believe it shouldn't flood the
screen.

I mean, the code should first check capabilities of the card and its
configuration and
issue the message once.


What is IGAIN in the message above ? Input gain ? That is, capture gain ?

======================================================================

----------------------------------------------------------------------
 tiwai - 06-08-05 14:53 
----------------------------------------------------------------------
With revo 7.1, this might not work, too, since revo has really no "Capture
Volume" (corresponding to IGAIN in OSS).

If so, it must be a bug of Skype.  Skype must check DEVMASK before reading
IGAIN.

----------------------------------------------------------------------
 sst4 - 06-12-05 19:35 
----------------------------------------------------------------------
Takashi,

thanks for you reply.

I do not think it's that much of a bug in Skype.

I think it's hard to find a soundcard which doesn't have input gain
control
under Windows.

And I believe that the card should have, and it's possible to do, input
gain control - please see

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1187
.

Aslo, I'm repeating what I've said in the issue above:

"
*** I still have no capture with my Revolution 7.1 (issue 0001096) ***
.

Since I'm not getting it work, I've been trying to use ALSA utilities
('amixer',
'alsamixer', 'aoss') - "trial and error" approach - to make it work, and
have
found other problems on the way.

Resolution of these other problem, including introduction of gain
control,
will not solve my main problem - lack of capture.


I would appreciate getting an answer to the question in

https://bugtrack.alsa-project.org/alsa-bug/view.php [^]?id=1096 :

"
Maybe my previous question does not contain enough details.

Here is the rephrased question:

Running 'amixer' with this command line

amixer cget numid=<number>

, where <number is in 5..12 range, I see output like this:

"
  ; type=ENUMERATED,access=rw---,values=1,items=5
  ; Item 0 'PCM Out'
  ; Item 0000001 'H/W In 0'
  ; Item 0000002 'H/W In 1'
  ; Item 0000003 'IEC958 In L'
  ; Item 0000004 'IEC958 In R'
  : values=0
".

Can any of these controls be related to enabling capture ?

Thanks,
  Sergei.
".

Or, to be more precise, getting an answer to the question in general:
"How
to enable capture in M-Audio Revolution 7.1 ?".
".

Thanks,
  Sergei.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-07-05 00:33 sst4           New Issue                                    
06-08-05 14:50 tiwai          Note Added: 0004923                          
06-08-05 14:51 tiwai          File Added: aoss-igain-fix.diff                   

06-08-05 14:53 tiwai          Note Added: 0004926                          
06-08-05 14:54 tiwai          File Added: aoss-igain-fix2.diff                  
 
06-08-05 14:55 tiwai          File Deleted: aoss-igain-fix.diff                 
  
06-12-05 19:35 sst4           Note Added: 0004999                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
