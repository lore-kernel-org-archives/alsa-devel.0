From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000483]: alsa-libs samplerate-conversion causes assertion frames <= snd_pcm_mmap_avail
Date: Sat, 19 Mar 2005 19:26:28 +0100
Message-ID: <0987febaeb5fc0778b6c0f63d5173148@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DE2C81FD
	for <alsa-devel@alsa-project.org>; Sat, 19 Mar 2005 19:26:28 +0100 (MET)
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
Category:                   ordinary pcm
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             09-06-2004 11:39 CEST
Last Modified:              03-19-2005 19:26 CET
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
 jdthood - 03-19-05 19:26 
----------------------------------------------------------------------
What was in your /etc/asound.conf before you added the .asoundrc?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-06-04 11:39 jwrdegoede     New Issue                                    
03-19-05 19:26 jdthood        Note Added: 0004067                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
