From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001389]: snd-ens1371 / es1938 Creative
	Ectiva silent playout + new line-in capture failure
Date: Mon, 10 Jul 2006 19:36:36 +0200
Message-ID: <94520c48c049b9ea5807036016a7244d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 17DCF19D
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Jul 2006 19:36:36 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1389> 
======================================================================
Reported By:                wood
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1389
Category:                   PCI - ens1371
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Modified Redhat 9.0
Kernel Version:             2.4.24 self compiled
======================================================================
Date Submitted:             09-01-2005 20:32 CEST
Last Modified:              07-10-2006 19:36 CEST
======================================================================
Summary:                    snd-ens1371 / es1938 Creative Ectiva silent playout
+ new line-in capture failure
Description: 
Soundcard: Creative Soundblaster PCI (Ectiva) Model:CT4730
Chip Label: Creative EV1938

Platform: Stable 2.4.24 Linux kernel on VIA MiniITX ME6000/M10000
          w/ multiple soundcards. ALSA compiled from source
          works with VIA motherboard Audio
          and some other Creative PCI soundcards. Need a stable ALSA
driver
          for this soundcard.

Problem:
The snd-ens1371 module loads correctly as 3rd sound device (First audio
device is VIA 8235 from motherboard, 2nd is PCSP).

Alsamixer -c 2 shows a reasonable set of
controls. Playout either with OSS emulation (play) or ALSA player
(aplay) plays WAV files but only silence for both 1.0.9 and 1.0.10rc1
releases.  
On ALSA 1.0.9 codebase,the Master Volume does not always show in
alsamixer. 
In 1.0.10rc1 it does always show.
ALSO:
  On ALSA 1.0.9 code, the Line-In capture works under both OSS Emulation
and with ALSA arecord.
On the latest development release ALSA 1.0.10rc1, the Line-In
capture no longer works. So a new problem has been introduced from .9 to
.10.


Other info:
Native OSS driver es1371 works fine with this card. But I want to switch
to ALSA.

Earlier model Creative PCI128, Model CT4750 loads snd-ens1371 and
works fine with both tested ALSA releases using same platform
configuration.

Audigy 2 Value also works fine using snd-emu10k1 with same configuration
(I included this card info to rule out basic config problems).

======================================================================

----------------------------------------------------------------------
 Raymond - 07-10-06 18:14 
----------------------------------------------------------------------
Refer to the tests performed by yafrank in
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1023

It is because the snd_es1731_codec_read() fails most of the time for
ev1938 and this cause both snd_ac97_try_bit() and
check_volume_resolution() fail

Most likely someone has to find out how to make snd_es1371_codec_read()
and snd_es1371_codec_write() work so that ev1938 can read/write ac97
codec.

----------------------------------------------------------------------
 wood - 07-10-06 19:36 
----------------------------------------------------------------------
Raymond,
   Thanks much for the research on this problem and narrowing down the
issue to 
snd_es1731_codec_read() failure. I have been much too busy to get back to
testing this issue. It could be a while longer yet before I can do more
work. Right now, I am using my hacked version of the ALSA code, but of
course a real and integrated solution would be best.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-01-05 20:32 wood           New Issue                                    
09-01-05 20:32 wood           Distribution              => Modified Redhat 9.0
09-01-05 20:32 wood           Kernel Version            => 2.4.24 self compiled
06-13-06 05:06 Raymond        Note Added: 0010186                          
06-13-06 06:43 wood           Note Added: 0010188                          
06-13-06 07:05 Raymond        Note Added: 0010189                          
06-13-06 07:28 Raymond        Note Edited: 0010189                         
06-13-06 16:26 wood           Note Added: 0010194                          
06-13-06 16:51 Raymond        Note Added: 0010196                          
06-13-06 16:59 wood           Note Added: 0010197                          
06-13-06 19:05 Raymond        Note Added: 0010201                          
06-13-06 19:46 wood           Note Added: 0010203                          
06-14-06 14:42 Raymond        Note Added: 0010212                          
07-06-06 04:04 Raymond        Note Added: 0010851                          
07-09-06 17:17 Raymond        Note Deleted: 0010851                        
07-10-06 10:52 Raymond        Note Deleted: 0010212                        
07-10-06 18:14 Raymond        Note Added: 0010962                          
07-10-06 19:36 wood           Note Added: 0010963                          
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
