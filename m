From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001548]: "alsa-play: xrun of at least 0.009 msecs. resetting stream" : inopportune small pauses while playing
Date: Sat, 7 Jan 2006 02:14:24 +0100
Message-ID: <67c2fe0254a6d669a1a8cea462096f28@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1694913A
	for <alsa-devel@alsa-project.org>; Sat,  7 Jan 2006 02:14:24 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1548> 
======================================================================
Reported By:                moncnam
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1548
Category:                   PCI - intel8x0m
Reproducibility:            random
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               debian sarge 3.1
Kernel Version:             2.6.13-rc7
======================================================================
Date Submitted:             11-12-2005 10:58 CET
Last Modified:              01-07-2006 02:14 CET
======================================================================
Summary:                    "alsa-play: xrun of at least 0.009 msecs. resetting
stream" : inopportune small pauses while playing
Description: 
whatever the player i use (alsaplayer, xmms, mplayer) i experience small
pause while playing (half of a second)
using mplayer, i can see the following message appearing when the pause
occur
<<alsa-play: xrun of at least 0.009 msecs. resetting stream>>
the playing doesn't stop, it continue well, just a small pause
i have no other messages in `dmesg` or in syslog
======================================================================

----------------------------------------------------------------------
 moncnam - 01-04-06 22:38 
----------------------------------------------------------------------
I UNDERSTOOD MY PROBLEM - no pb with alsa

well, 
i ithink i understand what had happend : 
no problem with alsa and i will explain 
- in playing a music throught xmms or noatun, i get no problem (1)
- in playing a title with the command line "mplayer atitle.mp3", i get
some error messages as stated above (2)
the difference should be the priority my process has, in (2), i have a low
priority level for my process (i run this as a common user)

one thing i could add here (not directly related to the topic, but may be
usefull in case...)
i use artsd to forward its sound flow to alsa
once should configure in kcontrol that the rate is manually set to 48000
for exemple in order to have a good output (as 48000 is the default for
alsa) otherwise, the sound do comes out but in a strange way for very bass
or high frequency

remark : 
at the adress
http://www.alsa-project.org/alsa-doc/alsa-lib/pcm_plugins.html
the text doesn't well explain what the "periods" parameter should expect
as a sample valid value (1024 ? or just 1, 2, 3 ?)

btw, here is my ~.asoundrc file (just in case someone would appreciate
it), i don't bet it is a model to follow but it works for me (bellow is my
hardware config) 
<<
pcm.!default { type plug slave.pcm "dmix" }
pcm.!dmix {
        type dmix
        ipc_key 1
        ipc_perm 0660
        ipc_key_add_uid true
        slave {
                pcm "hw:0,0"
                format  S16_LE
                rate    48000
                channels        2
                period_time 0
                buffer_size 16384
                periods 16384
        }
        bindings { 0 0 1 1 }
}
>>
note : modifying buff_size and periods to 16384 didn't solved my original
pb, i am pretty sure i have to type something like "nice --10 mplayer..."
unfortunatelly, i can't directly do this as a normal user, so i should
make an suid wrapper or some kind of

i add period_time, buffer_size and periods to support oss throught alsa

it used to work the same with my previous file : 
<<
pcm.!default { type plug slave.pcm "dmix" }
pcm.!dmix {
        type dmix
        ipc_key 1
        ipc_key_add_uid true
        slave {
                pcm "hw:0,0"
                period_time 1024
                buffer_size 4096
        }
        bindings { 0 0 1 1 }
}
>>

hardware : 
dell inspiron 9300
ram : 1GB
cpu : 
model name      : Intel(R) Pentium(R) M processor 1.86GHz
stepping        : 8
cpu MHz         : 1862.368

----------------------------------------------------------------------
 sashak - 01-07-06 02:14 
----------------------------------------------------------------------
You may try larger period_size and of course more than just one period to
prevent underruns (perdiod_size should be <= buffer_size/2 ).

BTW did you try default ALSA config (without .asoundrc)? Default settings
are reasonable for many cases.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-12-05 10:58 moncnam        New Issue                                    
11-12-05 10:58 moncnam        Distribution              => debian sarge 3.1
11-12-05 10:58 moncnam        Kernel Version            => 2.6.13-rc7      
11-21-05 23:56 sashak         Note Added: 0006779                          
11-22-05 00:04 moncnam        Note Added: 0006781                          
11-22-05 00:31 sashak         Note Added: 0006783                          
11-22-05 00:31 sashak         Assigned To              sashak =>           
11-22-05 00:43 moncnam        Note Added: 0006784                          
01-04-06 22:38 moncnam        Note Added: 0007456                          
01-07-06 02:14 sashak         Note Added: 0007503                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
