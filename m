From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001074]: pcm_dmix hangs on device close
Date: Tue, 9 Aug 2005 13:44:45 +0200
Message-ID: <cba1edd2918f69f60ce98e944ee79add@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1C7841D1
	for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2005 13:44:45 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1074> 
======================================================================
Reported By:                ikonst
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   1074
Category:                   1_pcm - digital audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             04-24-2005 08:48 CEST
Last Modified:              08-09-2005 13:44 CEST
======================================================================
Summary:                    pcm_dmix hangs on device close
Description: 
The fix in pcm_dmix.c revision 1.71 causes the following regression:

Everytime I access a Flash site thru my 'aoss'-wrapped Mozilla, it hangs:

#0  0x40a951c3 in poll () from /lib/tls/libc.so.6
#1  0x4001a1fd in poll () from /usr/lib/libaoss.so
#2  0x40c7bf78 in snd_pcm_wait_nocheck (pcm=0x9a7a6a0, timeout=-1)
    at pcm.c:2234
#3  0x40cb27fb in snd_pcm_dmix_drain (pcm=0x9a7a6a0) at pcm_dmix.c:504
#4  0x40c79bd4 in snd_pcm_drain (pcm=0xfffffffc) at pcm.c:1044
#5  0x40c8cbb7 in snd_pcm_generic_drain (pcm=0xfffffffc) at
pcm_generic.c:151
#6  0x40c79bd4 in snd_pcm_drain (pcm=0xfffffffc) at pcm.c:1044
#7  0x40bb24e7 in lib_oss_pcm_close () from /usr/lib/libalsatoss.so.0
#8  0x400199b4 in close () from /usr/lib/libaoss.so
#9  0x441712b9 in PlatformSoundMix::UnlockAudioCallback ()
   from /usr/lib/flashplugin-nonfree/libflashplayer.so
...

======================================================================

----------------------------------------------------------------------
 tiwai - 05-15-05 15:45 
----------------------------------------------------------------------
Yeah, that's really bad.  We need to change these ioctls.
Meanwhile, I'll apply your patch as a temporary workaround.

----------------------------------------------------------------------
 tiwai - 05-17-05 17:51 
----------------------------------------------------------------------
This should be fixed on CVS now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-24-05 08:48 ikonst         New Issue                                    
05-09-05 17:33 chtephan       Note Added: 0004627                          
05-09-05 17:53 chtephan       Issue Monitored: chtephan                    
05-09-05 20:41 chtephan       File Added: timer-flush-blocking.diff             
      
05-09-05 20:42 chtephan       Note Added: 0004629                          
05-11-05 17:23 ikonst         Note Added: 0004638                          
05-11-05 18:11 tiwai          Note Added: 0004639                          
05-12-05 13:34 chtephan       Note Added: 0004641                          
05-12-05 13:50 tiwai          Note Added: 0004642                          
05-13-05 22:57 chtephan       Note Added: 0004656                          
05-15-05 15:45 tiwai          Note Added: 0004662                          
05-17-05 17:51 tiwai          Status                   new => resolved     
05-17-05 17:51 tiwai          Resolution               open => fixed       
05-17-05 17:51 tiwai          Assigned To               => tiwai           
05-17-05 17:51 tiwai          Note Added: 0004680                          
08-09-05 13:44 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
