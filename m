From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000958]: noisy output on low sample rate files when using dmix
Date: Thu, 24 Mar 2005 01:40:51 +0100
Message-ID: <81c373df2d3483b88e522c82991bc6cc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C7A682AA
	for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2005 01:40:51 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=958> 
======================================================================
Reported By:                mtraum
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   958
Category:                   mixer
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             03-02-2005 21:23 CET
Last Modified:              03-24-2005 01:40 CET
======================================================================
Summary:                    noisy output on low sample rate files when using
dmix
Description: 
When using dmix, I get noise when playing files with low sample rates. The
level of noise increases the lower the sample rate is. This noise does not
exist when playing files without dmix, and I'm playing them with 'aplay'.


Files sampled at 44100 have no noticeable noise (at least for me), so I'm
assumming there's a problem with the resampling algorithm.

Just to be sure, I generated some test tones with sgen
(http://www.comp.leeds.ac.uk/jj/linux/siggen.html). You can clearly hear
the noise on these samles, which I am attaching.
======================================================================

----------------------------------------------------------------------
 grabner - 03-24-05 00:39 
----------------------------------------------------------------------
I confirm in a slightly different situation: playing through plughw on a
device with fixed sampling rate (39063Hz), even without dmix.

The bug is in src/pcm/pcm_rate.c at line 128 (or line 194 for 16 bit
samples), where the last frame of a period is repeated if no more frames
are available. This adds to the original signal a peak with an amplitude
proportional to the slope of the signal at this point, which is larger for
higher frequency signals or lower sampling rates.

A working solution to this problem existed in alsa-lib up to version
1.0.7, where the last frame of each period was available when processing
the next period. However, for reasons unknown to me, this method has been
replaced by a broken algorithm in version 1.0.8, which causes the noise
reported in this issue.

A note to the previous posters on this topic: could you please check if
the problem also occurs with alsa-lib 1.0.7? This would verify if we are
actually talking about the same thing, and help fixing it.

----------------------------------------------------------------------
 Rottwang - 03-24-05 01:40 
----------------------------------------------------------------------
I had no problems with 1.0.7 and 1.0.8-rc1 was fine too (I'm using it now).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-02-05 21:23 mtraum         New Issue                                    
03-02-05 21:23 mtraum         File Added: testtones.tar.gz                    
03-02-05 22:08 hamel_g        Note Added: 0003781                          
03-13-05 09:43 Rottwang       Note Added: 0003901                          
03-22-05 00:01 eradicator     Issue Monitored: eradicator                    
03-24-05 00:39 grabner        Note Added: 0004188                          
03-24-05 00:39 grabner        Issue Monitored: grabner                     
03-24-05 01:40 Rottwang       Note Added: 0004189                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
