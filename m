From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002158]: play produces i/o error on
	ad1845 (miro)
Date: Mon, 29 May 2006 23:21:55 +0200
Message-ID: <2bcd6835ba8206e5b1e5980424798191@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ECE55152
	for <alsa-devel@alsa-project.org>;
	Mon, 29 May 2006 23:21:55 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2158> 
======================================================================
Reported By:                martin
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2158
Category:                   ISA - miro
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             05-24-2006 15:13 CEST
Last Modified:              05-29-2006 23:21 CEST
======================================================================
Summary:                    play produces i/o error on ad1845 (miro)
Description: 
At first I will mention that 1.0.10final works without problems. And
1.0.11rc3 or any newer version fails always during the fifth hw_writei
with this Input/Output error:

aplay -Dplughw:1 /data/audio/lisboa_reloaded_1_20060421.wav Playing WAVE
'/data/audio/lisboa_reloaded_1_20060421.wav' : Signed 16 bit Little 
Endian, Rate 44100 Hz, Stereo
hw_writei: frames = 4096, xferi.result = 4096, err = 0
hw_writei: frames = 4096, xferi.result = 4096, err = 0
hw_writei: frames = 4096, xferi.result = 4096, err = 0
hw_writei: frames = 4096, xferi.result = 4096, err = 0
hw_writei: frames = 4096, xferi.result = -5, err = -5
aplay: pcm_write:1264: write error: Input/output error

My snd-miro uses an AD1845 which will be driven by the cs4231-lib. It's
really possible that other cards with an ad1845 will have the same
problem. BTW, recording seems to work without problems.

Unfortunately I haven't found the bug, yet. It was introduced between
1.0.10 and 1.0.11rc3. Well, if rc1/rc2 would compile, I could be more
precise here.

A strace log is attached. Any ideas? (Just before I start the hard way:
fixing the rc1/2 compilation bug and hunting for the bad patch...)
======================================================================

----------------------------------------------------------------------
 martin - 05-29-06 23:21 
----------------------------------------------------------------------
I have to correct myself. After trying out a bunch of things it's obvious
that it fails on x86. OTOH it works on an alpha cpu without problems.
Sorry, I've mixed x86/alpha results in my former report.

Trying out an old and new version I can confirm for same miro pcm20 hw:
1.0.9b and 1.0.11: snd-miro works fine on alpha
1.0.9b and 1.0.11: snd-miro fails on x86 with this i/o error

Both systems are using a general ISA bus (I guess), but the AlphaBIOS
doesn't support PnP. 

Ok, let's play a little bit with pnp stuff. Alsa compile option
--with-isapnp=no doesn't make a difference. Disable PNP support in the
BIOS doesn't make a difference again.

Building a new kernel with PNP support disabled doesn't help, but at least
I saw another message now: "miro.c:1265: unable to detect OPTi9xx chip".

Weird. It goes through all loops of snd_card_miro_detect() and can't find
my 924. I guess it's time to look for an opti924 datasheet now.
Hmm, but why does this card work on alphas then?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-24-06 15:13 martin         New Issue                                    
05-24-06 15:13 martin         File Added: miro.log.gz                      
05-29-06 23:21 martin         Note Added: 0010014                          
======================================================================
