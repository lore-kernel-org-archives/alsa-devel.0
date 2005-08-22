From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001199]: oops with pdaudiocf after data stream abort
Date: Mon, 22 Aug 2005 13:09:52 +0200
Message-ID: <cefe4c79f60f0f3c13d03b473a13831e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8DB3220D
	for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2005 13:09:52 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1199> 
======================================================================
Reported By:                zwelch
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1199
Category:                   PCMCIA - pdaudiocf
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo
Kernel Version:             2.6.11.12
Resolution:                 won't fix
Fixed in Version:           
======================================================================
Date Submitted:             06-17-2005 02:50 CEST
Last Modified:              08-22-2005 13:09 CEST
======================================================================
Summary:                    oops with pdaudiocf after data stream abort
Description: 
The following oops report was generated while using `arecord | aplay` from
the 1.0.9 alsa-utils release.  It was triggered by unplugging the pre-amp
while recording, thus causing the optical signal to disappear
unexpectedly.

As it is, I need both the pdaudiocf and powermac drivers working, or I
would be using the out-of-kernel alsa-driver package.  The powermac driver
in 1.0.9a can't find the symbol 'macio_find', which I have reported
separately (bug #1198).  Once that bug is fixed, I can retest this issue
with the most current release, but I hope patches might be applied to
2.6.11.12 to fix this problem.

I can provide additional information about the kernel configuration,
installed package versions, run further tests, or try possible patches.

======================================================================

----------------------------------------------------------------------
 perex - 06-20-05 11:52 
----------------------------------------------------------------------
The culprit of this oops is not obvious. Could you try to remove
snd_pcm_stop() line from i2c/other/ak4114.c file?

----------------------------------------------------------------------
 perex - 08-22-05 13:09 
----------------------------------------------------------------------
No response.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-17-05 02:50 zwelch         New Issue                                    
06-17-05 02:50 zwelch         Distribution              => Gentoo          
06-17-05 02:50 zwelch         Kernel Version            => 2.6.11.12       
06-19-05 09:58 zwelch         Note Added: 0005086                          
06-20-05 11:52 perex          Note Added: 0005096                          
08-22-05 13:09 perex          Status                   assigned => resolved
08-22-05 13:09 perex          Resolution               open => won't fix   
08-22-05 13:09 perex          Note Added: 0005895                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
