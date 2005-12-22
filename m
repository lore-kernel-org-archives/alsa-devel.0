From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001575]: Multi ice1712 cards don't work in duplex mode
Date: Thu, 22 Dec 2005 17:18:39 +0100
Message-ID: <187694b194caa4b1e056106a18cce51e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EFBED1C5
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2005 17:18:39 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1575> 
======================================================================
Reported By:                johnrigg
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1575
Category:                   1_pcm - digital audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             11-18-2005 01:12 CET
Last Modified:              12-22-2005 17:18 CET
======================================================================
Summary:                    Multi ice1712 cards don't work in duplex mode
Description: 
ice 1712 cards have 12 capture channels and 10 playback. This prevents
multi pcm
plugin from working in duplex mode. If I use following in .asoundrc:

slaves.a.pcm "hw:0,0"
slaves.a.channels 12
slaves.b.pcm "hw:1,0"
slaves.b.channels 12

I can only start jackd with -C option. Attempting to start with both -C
and -P
just produces error message 
ALSA: no playback configurations available (Invalid argument)
ALSA: cannot configure playback channel

Similarly if I set channels to 10 I can only start jackd with -P option.
Using
both -C and -P gives error
ALSA: no playback configurations available (invalid argument)
ALSA: cannot configure capture channel

These cards don't have separate subdevices for capture and playback, so
it
isn't possible to define two different multi configs and combine them with
asym
plugin. If channels is set to anything other than 10 or 12 (eg. 8) it
produces error eg. ALSA: cannot set channel count to 8 for capture.

I can use one card at a time in duplex mode with
`jackd -d alsa -d hw:0'  or `jackd -d alsa -d hw:1'.
jack is obviously happy to run with 12 capture and 10 playback channels, 
it just appears that the multi plugin can't deal with this.
======================================================================

----------------------------------------------------------------------
 johnrigg - 12-22-05 00:57 
----------------------------------------------------------------------
I just noticed a couple of days ago that envy24control from
alsa-tools-1.0.10
with the patch for the word clock doesn't work on 2.6.13 kernel, only on
2.6.14
(and hopefully 2.6.15-rc?). On 2.6.13 it can't read word clock status (the
thing the patch fixes on 2.6.14). Maybe if you try removing the patch it
will work again on 2.6.13.
envy24control also has another quirk. The second card can't be locked to
the word clock input without clicking on the S/PDIF In button first. Then
the Word Clock button works.
Unfortunately I still haven't found why the poll timeout is occurring. I
can use
duplex multi_pcm mode with kernels up to 2.6.14-rt20 with patched
pcm_multi, but -rt22 breaks it again. I'm about to try 2.6.15-rc5-rt4 to
see if it works again
on my system.
There's a long thread on jackit-devel about this:
http://sourceforge.net/mailarchive/forum.php?thread_id=9270417&forum_id=3040

----------------------------------------------------------------------
 Schafwoller - 12-22-05 17:18 
----------------------------------------------------------------------
I tried to use two m-audio delta 1010 in one box:

SuSE 10.0 (kernel 2.6.13)
jackd 0.100.0+MMAP-patch
alsa-lib-1.0.10
alsa-driver-1.0.10

No chance to get duplex-mode running. Also Midi? Getting error-messages
regarding MIDI when starting apps like qjackctl -> Midi is not available
in connections-window. Don't see any way to handle midi-connections via
envy24control, qjackctl or any other App

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-18-05 01:12 johnrigg       New Issue                                    
12-03-05 20:09 johnrigg       Note Added: 0006902                          
12-03-05 22:56 johnrigg       Note Added: 0006905                          
12-21-05 23:16 Roman          Issue Monitored: Roman                       
12-21-05 23:16 Roman          Issue End Monitor: Roman                     
12-21-05 23:59 Roman          Note Added: 0007113                          
12-22-05 00:00 Roman          Issue Monitored: Roman                       
12-22-05 00:57 johnrigg       Note Added: 0007114                          
12-22-05 17:18 Schafwoller    Note Added: 0007128                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
