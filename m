From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000483]: alsa-libs samplerate-conversion causes assertion frames <= snd_pcm_mmap_avail
Date: Sun, 20 Mar 2005 22:12:11 +0100
Message-ID: <76bdb4fcbe7928e8c88ce14cf4d19af5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8AF45209
	for <alsa-devel@alsa-project.org>; Sun, 20 Mar 2005 22:12:11 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=483> 
======================================================================
Reported By:                jwrdegoede
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   483
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             09-06-2004 11:39 CEST
Last Modified:              03-20-2005 22:12 CET
======================================================================
Summary:                    alsa-libs samplerate-conversion causes assertion
frames <= snd_pcm_mmap_avail
Description: 
When running xmame (x.mame.net) with alsa selected for sound output on my
es1688. I get the following error:
pcm.c:5957: snd_pcm_mmap_commit: Assertion frames <=
snd_pcm_mmap_avail(pcm)' failed.

I checked the source for the alsa driver (I'm one of the xmame developers)
and the number of frames it is passing to snd_pcm_writei is always smaller
then or equal to the value
returned by:
err = snd_pcm_status(priv->pcm_handle, status);
/* check err */
frames = snd_pcm_status_get_avail(status);

After some more testing I noticed that alsa returns 22050 as the actual
acquired samplerate, but I know from the oss days that my card can only do
22095 not 22050. So I thought this error might be caused by the
alsa-lib-samplerate conversion code, which appearantly is default enabled
(Fedora feature?)

To test my hypothesis I tried creating an almost empty .asoundrc:
pcm.!default {
type hw
card 0
}

ctl.!default {
type hw
card 0
}

And now alsa-lib returns 22095 as the acquired samplerate and everything
works fine! So IMHO this problem is clearly somewhere in alsa-libs
samplerate conversion.

I've searched the internet for this assertion and I believe this bug has
bitten more people and applications and needs fixing ASAP. (note I'm not
saying this because I need it fixed, since the .asoundrc workaround works
fine for me, but I'm saying this in the general interest)

======================================================================

----------------------------------------------------------------------
 Belegdol - 03-20-05 13:49 
----------------------------------------------------------------------
Same problem here. Mandrake 10.1 Official, Gigabyte GA-8IPE1000 Pro-G
motherboard (Intel 865PE). I have no /etc/asound.conf file but I have the
following /etc/asound.state:

state.ICH5 {
  [...cut here - not related - perex...]
}

HTH



----------------------------------------------------------------------
 Belegdol - 03-20-05 22:12 
----------------------------------------------------------------------
I've also encountered this error when playing doom 3:

...
--- Common Initialization Complete ---
terminal support enabled ( use +set in_tty 0 to disabled )
pid: 7663
1008 MB System Memory
guessing video ram ( use +set sys_videoRam to force ) ..
found XNVCtrl extension 1.6
128 MB Video Memory
Async thread started
snd_pcm_writei short write: 4095 out of 4096
snd_pcm_writei short write: 4095 out of 4096
snd_pcm_writei short write: 1022 out of 1024
idAudioHardwareALSA::Write: 4096 frames overflowed and dropped
doom.x86: pcm.c:5957: snd_pcm_mmap_commit: Assertion `frames <=
snd_pcm_mmap_avail(pcm)' failed.
signal caught: Aborted
si_code -6
Trying to exit gracefully..
--------- Game Map Shutdown ----------
--------------------------------------
double fault Segmentation fault, bailing out
shutdown terminal support
Shutting down sound hardware
----------- Alsa Shutdown ------------
close pcm
dlclose
--------------------------------------
idRenderSystem::Shutdown()
Segmentation fault
[jsikorski@DOMOWY jsikorski]$

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-06-04 11:39 jwrdegoede     New Issue                                    
03-19-05 19:26 jdthood        Note Added: 0004067                          
03-19-05 19:51 jwrdegoede     Note Added: 0004068                          
03-20-05 09:43 Belegdol       Note Added: 0004075                          
03-20-05 10:12 Belegdol       Note Edited: 0004075                         
03-20-05 10:39 Belegdol       Note Edited: 0004075                         
03-20-05 13:39 perex          Category                 ordinary pcm => pcm -
digital audio
03-20-05 13:49 perex          Note Edited: 0004075                         
03-20-05 13:49 perex          Note Edited: 0004075                         
03-20-05 22:12 Belegdol       Note Added: 0004102                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
