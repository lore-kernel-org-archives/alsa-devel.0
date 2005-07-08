From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000958]: noisy output on low sample rate files when using dmix
Date: Fri, 8 Jul 2005 10:34:26 +0200
Message-ID: <d1a2f51a75ed12ffb34a1d86b8171176@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 81EFD17A
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 10:34:26 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=958> 
======================================================================
Reported By:                mtraum
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   958
Category:                   2_mixer
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-02-2005 21:23 CET
Last Modified:              07-08-2005 10:34 CEST
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
 Rottwang - 03-24-05 01:40 
----------------------------------------------------------------------
I had no problems with 1.0.7 and 1.0.8-rc1 was fine too (I'm using it now).

----------------------------------------------------------------------
 tiwai - 03-24-05 21:32 
----------------------------------------------------------------------
Fixed on CVS (pcm_rate.c rev.1.91).  Will appear in 1.0.9-rc3 or final.

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
03-24-05 21:32 tiwai          Status                   new => resolved     
03-24-05 21:32 tiwai          Resolution               open => fixed       
03-24-05 21:32 tiwai          Assigned To               => tiwai           
03-24-05 21:32 tiwai          Note Added: 0004201                          
04-08-05 14:15 ikonst         Issue Monitored: ikonst                      
07-08-05 10:34 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
