From: bugtrack@alsa-project.org
Subject: [ALSA - firmware 0000778]: xbox parameter sets AC97_SCAP_DETECT_BY_VENDOR wrongly
Date: Fri, 7 Jan 2005 18:27:31 +0100
Message-ID: <b82fe8e3587fd77734e2016ace8d9f7b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8D09C24F
	for <alsa-devel@alsa-project.org>; Fri,  7 Jan 2005 18:27:31 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=778> 
======================================================================
Reported By:                julian
Assigned To:                
======================================================================
Project:                    ALSA - firmware
Issue ID:                   778
Category:                   
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-02-2005 18:53 CET
Last Modified:              01-07-2005 18:27 CET
======================================================================
Summary:                    xbox parameter sets AC97_SCAP_DETECT_BY_VENDOR
wrongly
Description: 
the xbox parameter was designed to avoid failed detection of the AC97
codec.
according to the header file AC97_SCAP_DETECT_BY_VENDOR is a flag to ALLOW
detection. Therefore AC97_SCAP_DETECT_BY_VENDOR should be set in scaps if
the xbox 
parameter is false, not true.

The logic in ac97-codec is not consistent either.

To avoid bad AC97 probes, either AC97_SCAP_AUDIO or AC97_SCAP_SKIP_AUDIO
should be set if the xbox parameter is set.
======================================================================

----------------------------------------------------------------------
 julian - 01-03-05 17:36 
----------------------------------------------------------------------
OK - I'm starting to understand - xboxes HAVE readable vendor registers but
not readable other registers, so the sense of the original code was
correct.

To get the driver to load, I had to make this change to the original
intel8x0.c:

        if (chip->xbox)
                ac97.scaps |= AC97_SCAP_DETECT_BY_VENDOR|AC97_SCAP_AUDIO;

Otherwise snd_ac97_mixer in snd-ac97-codec.ko reports -EACCESS and
snd-intel8x0.ko fails with this error message:

Intel ICH: probe of 0000:00:06.0 failed with error -13

Now the xbox doesn't have a mixer, or audio inputs, but does have audio
outputs - can we decouple these three elements so we don't check for audio
by looking at input gains, ... ?

Julian



----------------------------------------------------------------------
 tiwai - 01-07-05 18:27 
----------------------------------------------------------------------
Could elaborate which elements should be ignored and should be there?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-02-05 18:53 julian         New Issue                                    
01-02-05 18:53 julian         File Added: x                                
01-02-05 18:56 julian         Issue Monitored: julian                      
01-02-05 20:21 julian         Note Added: 0003047                          
01-03-05 16:58 julian         Note Added: 0003069                          
01-03-05 17:31 julian         Note Deleted: 0003047                        
01-03-05 17:36 julian         Note Edited: 0003069                         
01-03-05 17:36 julian         Note Edited: 0003069                         
01-07-05 18:27 tiwai          Note Added: 0003111                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
