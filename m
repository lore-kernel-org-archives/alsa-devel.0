From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001018]: resampler produces noise
Date: Tue, 29 Mar 2005 15:55:12 +0200
Message-ID: <e52e4c164dfb984c21f81dae405eca12@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 86C93267
	for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2005 15:55:12 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1018> 
======================================================================
Reported By:                grabner
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   1018
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-26-2005 22:51 CET
Last Modified:              03-29-2005 15:55 CEST
======================================================================
Summary:                    resampler produces noise
Description: 
Sad to say, but after some recent improvements (thanks to tiwai) the
resampling code is still buggy. Under certain conditions, noise peaks are
added to the signal, which are clearly audible.
To make sure that this is not a problem with any particular hardware
driver, I created a test case using the "file" and "null" plugins (i.e.,
no output on audio hardware). See below for details.
======================================================================

----------------------------------------------------------------------
 grabner - 03-26-05 23:10 
----------------------------------------------------------------------
It seems that the text entered in the field "Steps To Reproduce" has been
lost, so here it is again:
*) unpack the attached archive
*) copy ".asoundrc" to your $HOME
*) execute "resample.sh"
*) listen to "out1.32000.1.wav"
You will hear the sine wave and a periodic clicking with changing
amplitude (credits for the input files go to a previous poster on a
similar issue).

----------------------------------------------------------------------
 tiwai - 03-29-05 15:55 
----------------------------------------------------------------------
Fixed on CVS (pcm_rate.c rev.1.92).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-26-05 22:51 grabner        New Issue                                    
03-26-05 22:51 grabner        File Added: resampling_bug_demo.tbz               
    
03-26-05 22:53 grabner        Issue Monitored: grabner                     
03-26-05 23:10 grabner        Note Added: 0004218                          
03-29-05 15:55 tiwai          Status                   new => resolved     
03-29-05 15:55 tiwai          Resolution               open => fixed       
03-29-05 15:55 tiwai          Assigned To               => tiwai           
03-29-05 15:55 tiwai          Note Added: 0004245                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
