From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000907]: The sound is choppy and sometimes played at wrong speed
Date: Sat, 28 May 2005 12:29:11 +0200
Message-ID: <5e1e9f8aa3781271f2603ff1ea286099@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 721AE214
	for <alsa-devel@alsa-project.org>; Sat, 28 May 2005 12:29:11 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=907> 
======================================================================
Reported By:                sHINOBI
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   907
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Fedora Core 3
Kernel Version:             2.6.10-1.766_FC3
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             02-13-2005 11:36 CET
Last Modified:              05-28-2005 12:29 CEST
======================================================================
Summary:                    The sound is choppy and sometimes played at wrong
speed
Description: 
The soundcard is working, although the sound is choppy when playing sound
at 44100 Hz. 48000 Hz audio like the one at DVD's is played correctly.
======================================================================

----------------------------------------------------------------------
 Cimmo - 04-20-05 18:23 
----------------------------------------------------------------------
Ok resolver, I have to do 'make install' instead of copying only one
module.

Seems that your patch works!!! I played some files that previous has some
choppy sound, now seems OK!!!

Only doom3 has always bad sound, and it always write in the terminal:
idAudioHardwareALSA::Write: 4096 frames overflowed and dropped
snd_pcm_writei short write: 690 out of 1024
snd_pcm_writei short write: 690 out of 1024
snd_pcm_writei short write: 690 out of 1024
snd_pcm_writei short write: 690 out of 1024
snd_pcm_writei short write: 690 out of 1024
snd_pcm_writei short write: 690 out of 1024


OVER OVER AND OVER AGAIN!

----------------------------------------------------------------------
 jcdutton - 05-28-05 12:29 
----------------------------------------------------------------------
Reporter says the problem is fixed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-13-05 11:36 sHINOBI        New Issue                                    
02-13-05 11:36 sHINOBI        Distribution              => Fedora Core 3   
02-13-05 11:36 sHINOBI        Kernel Version            => 2.6.10-1.766_FC3
02-13-05 11:38 sHINOBI        Note Added: 0003583                          
03-02-05 13:22 Juha           Note Added: 0003770                          
03-19-05 18:24 jcdutton       Note Added: 0004064                          
03-22-05 22:14 tiwai          Note Added: 0004138                          
03-22-05 22:56 sHINOBI        Note Added: 0004144                          
03-23-05 12:56 tiwai          Note Added: 0004155                          
03-23-05 19:40 sHINOBI        Note Added: 0004185                          
03-27-05 01:13 sHINOBI        Note Added: 0004219                          
03-27-05 16:08 Cimmo          Note Added: 0004222                          
03-27-05 16:09 Cimmo          File Added: .asoundrc                        
03-28-05 01:31 Alinoe         Issue Monitored: Alinoe                      
03-28-05 14:09 Alinoe         Note Added: 0004240                          
04-14-05 12:51 jcdutton       Note Added: 0004490                          
04-14-05 12:51 jcdutton       Status                   assigned => feedback
04-14-05 13:25 Cimmo          Note Added: 0004492                          
04-14-05 17:34 Cimmo          Note Added: 0004494                          
04-20-05 17:00 Cimmo          Note Added: 0004541                          
04-20-05 18:23 Cimmo          Note Added: 0004542                          
05-28-05 12:29 jcdutton       Status                   feedback => resolved
05-28-05 12:29 jcdutton       Resolution               open => fixed       
05-28-05 12:29 jcdutton       Note Added: 0004771                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
