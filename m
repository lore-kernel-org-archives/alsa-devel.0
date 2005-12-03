From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001575]: Multi ice1712 cards don't work in duplex mode
Date: Sat, 3 Dec 2005 20:09:50 +0100
Message-ID: <a3d39a6d6851fde044f4e896a3d48bdc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 458EB192
	for <alsa-devel@alsa-project.org>; Sat,  3 Dec 2005 20:09:50 +0100 (MET)
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
Last Modified:              12-03-2005 20:09 CET
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
 johnrigg - 12-03-05 20:09 
----------------------------------------------------------------------
After further testing I found the following:

alsa-lib-1.0.8 works with pcm_multi and jackd in duplex mode
alsa-lib-1.0.9rc1 onwards gives poll time out

Both tested with same jackd version, 0.100.7 with MMAP_COMPLEX patch
on Debian 3.1 system.

John

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-18-05 01:12 johnrigg       New Issue                                    
12-03-05 20:09 johnrigg       Note Added: 0006902                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
