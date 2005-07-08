From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001042]: Segfault when using "arecord -fS16_LE -r96000 -c2 -Ddefault" with the hardware doing 48000.
Date: Fri, 8 Jul 2005 10:37:23 +0200
Message-ID: <4e349e64b9dbb6dac59ec02b7f9f37c9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AC9AC18A
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 10:37:23 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1042> 
======================================================================
Reported By:                jcdutton
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   1042
Category:                   1_pcm - digital audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             04-09-2005 18:48 CEST
Last Modified:              07-08-2005 10:37 CEST
======================================================================
Summary:                    Segfault when using "arecord -fS16_LE -r96000 -c2
-Ddefault" with the hardware doing 48000.
Description: 
(gdb) run -fS16_LE -r96000 -c2 -Ddefault:2
Starting program: /usr/bin/arecord -fS16_LE -r96000 -c2 -Ddefault:2
[Thread debugging using libthread_db enabled]
[New Thread 16384 (LWP 10130)]
RIFF$\uffff\uffffWAVEfmt w\uffffdata\uffff\uffffRecording WAVE 'stdout' :
Signed 16 bit Little Endian, Rate 96000 Hz, Stereo

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 16384 (LWP 10130)]
snd_pcm_rate_expand_s16 (dst_areas=0x805c000, dst_offset=0,
dst_frames=8192, src_areas=0x806e380, src_offset=0,
    src_frames=4096, channels=2, rate=0x80556b8) at pcm_rate.c:187
187                     new_sample = rate->old_sample[channel];
(gdb) bt
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0 
snd_pcm_rate_expand_s16 (dst_areas=0x805c000, dst_offset=0,
dst_frames=8192, src_areas=0x806e380, src_offset=0,
    src_frames=4096, channels=2, rate=0x80556b8) at pcm_rate.c:187
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1  0xb7e63e0e in
snd_pcm_rate_avail_update (pcm=0x8055530) at
pcm_rate.c:785
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2  0xb7e46edb in
snd_pcm_avail_update (pcm=0x2000) at pcm.c:2265
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3  0xb7e4cc14 in
snd_pcm_read_areas (pcm=0x8055530, areas=0xbfe01ad0,
offset=0, size=8192,
    func=0xb7e680b0 <snd_pcm_mmap_read_areas>) at pcm.c:6250
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4  0xb7e6838f in
snd_pcm_mmap_readi (pcm=0x8055530, buffer=0x2000,
size=8192) at pcm_mmap.c:236
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5  0xb7e44e88 in
snd_pcm_readi (pcm=0x0, buffer=0x8071170, size=8192) at
pcm_local.h:402
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=6  0x0804dc8b in
capture_go ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=7  0x0804f234 in capture
()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=8  0x08050bde in main ()

======================================================================

----------------------------------------------------------------------
 tiwai - 04-19-05 18:36 
----------------------------------------------------------------------
fixed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-09-05 18:48 jcdutton       New Issue                                    
04-19-05 18:36 tiwai          Status                   new => resolved     
04-19-05 18:36 tiwai          Resolution               open => fixed       
04-19-05 18:36 tiwai          Assigned To               => tiwai           
04-19-05 18:36 tiwai          Note Added: 0004537                          
07-08-05 10:37 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
