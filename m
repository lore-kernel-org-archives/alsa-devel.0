From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0001164]: aoss + skype: volume_adjust: SOUND_MIXER_WRITE_IGAIN failed: Invalid argument
Date: Mon, 13 Jun 2005 16:05:17 +0200
Message-ID: <4cebf837f11daad255b9933115747339@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C285F137
	for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2005 16:05:17 +0200 (MEST)
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
Last Modified:              06-13-2005 16:05 CEST
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
 tiwai - 06-13-05 14:30 
----------------------------------------------------------------------
No, such a software conversion shouldn't be in the kernel code.  It's a job
of user-space.  That is, such a feature could be implemented easily on
alsa-lib, but this can't be used through kernel OSS emulation.

The fix of alsamixer should be already fixed in 1.0.9b.  Please update
your system.

I know there is a bug in amixer (the bug report isn't closed), but
currently this is still in the deep of my long TODO list.  If anyone can
take a look and debug it, it'd be appreciated.

BTW, you can do the following instead of amixer, if you don't like the
interactive program:
- alsactl -f somefile store
- edit somefile manuall
- alsactl -f somefile restore

----------------------------------------------------------------------
 sst4 - 06-13-05 16:05 
----------------------------------------------------------------------
Takashi,

regatrding

"
you can do the following instead of amixer, if you don't like the
interactive program:
- alsactl -f somefile store
- edit somefile manuall
- alsactl -f somefile restore
"
- please find attached 'asound.state.generated_by_alsaconf' file
generated
by  'alsaconf'. Before generation I cleaned up /etc/modprobe.conf by
removing
all sound related entries from it.

Could you please tell me which lines to change and how in the
'asound.state.generated_by_alsaconf' in order to enable capture ?

Please note that the word "capture" does not appear in the file.

Regarding 'amixer'. The bug that I filed affects only control number 0 -
maybe
'amixer' is still good enough to enable capture ?

Anyway, please let me know how to enable capture either through changes
in
the 'asound.state.generated_by_alsaconf' file or using 'amixer'.

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
06-13-05 13:03 tiwai          Note Added: 0005006                          
06-13-05 14:12 sst4           Note Added: 0005009                          
06-13-05 14:30 tiwai          Note Added: 0005010                          
06-13-05 15:55 sst4           File Added: asound.state.geberated_by_alsaconf    
               
06-13-05 15:59 sst4           File Added: asound.state.generated_by_alsaconf    
               
06-13-05 16:05 sst4           Note Added: 0005012                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
