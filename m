From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001338]: sound mute by default with snd_intel8x0
Date: Fri, 26 Aug 2005 14:45:12 +0200
Message-ID: <ab9801534b827998c76c64a22a9b609b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 93BE31E4
	for <alsa-devel@alsa-project.org>; Fri, 26 Aug 2005 14:45:12 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1338> 
======================================================================
Reported By:                marius_andreiana
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   1338
Category:                   0_general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             08-15-2005 20:35 CEST
Last Modified:              08-26-2005 14:45 CEST
======================================================================
Summary:                    sound mute by default with snd_intel8x0
Description: 
My particular hardware:  Multimedia audio controller: Intel Corporation
82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller

Sound is mute until running alsamixer and moving up the volume for
"External Amplifier", which is 0 by default. 

Please set a resonable (90% ?) default value for that device as it
prevents any sounds to play or fix it to work with 0 value too.

Lots of details and other devices:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=144742
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=137637
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=140590

Thanks
======================================================================

----------------------------------------------------------------------
 rlrevell - 08-15-05 22:30 
----------------------------------------------------------------------
"Sound card mute by default" is not a bug, this is by design.  Besides this
is policy so must stay out of the kernel.  The distro is reponsible for
providing reasonable defaults for the mixer.

----------------------------------------------------------------------
 tiwai - 08-26-05 14:45 
----------------------------------------------------------------------
The external amplifer is ON as drivers default.
It must be something else (e.g. a mixer app) which changed the state off.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-15-05 20:35 marius_andreianaNew Issue                                    
08-15-05 22:30 rlrevell       Note Added: 0005822                          
08-26-05 14:45 tiwai          Status                   new => resolved     
08-26-05 14:45 tiwai          Resolution               open => unable to
duplicate
08-26-05 14:45 tiwai          Assigned To               => tiwai           
08-26-05 14:45 tiwai          Note Added: 0005948                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
