From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000498]: audigyls plays sound 1.5 times fast
Date: Wed, 15 Sep 2004 16:18:42 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040915141842.4022447005@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id AD3332F9
	for <alsa-devel@alsa-project.org>; Wed, 15 Sep 2004 16:18:42 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000498
======================================================================
Reported By:                andii
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Bug ID:                     498
Category:                   PCI - audigyls
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo 2004.2
Kernel Version:             linux-2.6.7-gentoo-r11
======================================================================
Date Submitted:             09-12-2004 06:23 CEST
Last Modified:              09-15-2004 16:18 CEST
======================================================================
Summary:                    audigyls plays sound 1.5 times fast
Description: 
audigyls plays sound 1.5 times faster then it should.

Example:
andy@gordon andy $ time plaympeg 01-radio_moscow.mp3
01-radio_moscow.mp3: MPEG audio stream
        Audio MPEG-1 Layer 3 128kbit/s 44100Hz stereo
        Size: 404165
        Total time: 25.260312

real    0m17.163s
user    0m0.374s
sys     0m0.015s

1st thought it might just be mp3s but also wav files and games,
everything!

Note: I downloaded and installed alsa-lib, alsa-drivers and alsa-utils by
hand, I did not use gentoo's emerge.
======================================================================

----------------------------------------------------------------------
 tiwai - 09-13-2004 15:40 CEST 
----------------------------------------------------------------------
Does it happen with 48kHz samples?
Did you test OSS apps or ALSA native apps?

----------------------------------------------------------------------
 andii - 09-15-2004 14:31 CEST 
----------------------------------------------------------------------
I'm not sure if plaympeg is OSS or ALSA, so I tried with mpg123:

root@gordon andy # time mpg123 01-radio_moscow.mp3
Playing MPEG stream from 01-radio_moscow.mp3 ...
MPEG 1.0 layer III, 128 kbit/s, 44100 Hz joint-stereo

[0:25] Decoding of 01-radio_moscow.mp3 finished.

real    0m16.674s
user    0m0.153s
sys     0m0.092s

Same fast play results. But:

root@gordon andy # time mpg123 -r 48000 01-radio_moscow.mp3
Playing MPEG stream from 01-radio_moscow.mp3 ...
MPEG 1.0 layer III, 128 kbit/s, 44100 Hz joint-stereo
Warning, flexible rate not heavily tested!

[0:25] Decoding of 01-radio_moscow.mp3 finished.

real    0m25.383s
user    0m0.183s
sys     0m0.045s

Sounded fine.

Also xmms using libOSS.so 1.2.10 also sounds fine, but xmms using
libALSA.so 1.2.10 again plays fast. I have only tried with SDL based games
still play fast.

----------------------------------------------------------------------
 jcdutton - 09-15-2004 16:18 CEST 
----------------------------------------------------------------------
This seems rather strange, because I set the AudigyLS to only do 48khz or
96khz in hardware, so for 44.1khz, alsa-lib should be doing sample rate
conversions.
The AudigyLS can do 44.1khz in hardware, but when I tried it, it sounded
horrible, so I disabled the hardware 44.1khz mode.
We don't seem to have received any other reports of sample rate conversion
problems for other cards that can only do 48khz.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-12-04 06:23 andii          New Bug                                      
09-12-04 06:23 andii          Distribution              => Gentoo 2004.2   
09-12-04 06:23 andii          Kernel Version            => linux-2.6.7-gentoo-r11
09-13-04 15:40 tiwai          Bugnote Added: 0001746                       
09-15-04 14:31 andii          Bugnote Added: 0001761                       
09-15-04 16:18 jcdutton       Bugnote Added: 0001762                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
