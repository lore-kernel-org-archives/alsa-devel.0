From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000763]: I can't make the emulation of /dev/dsp work;  the driver "executes" but reports errors;  there is no sound output.
Date: Mon, 3 Jan 2005 12:05:00 +0100
Message-ID: <a1a61d24f359430fe4604fc62486c6b8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 338012CD
	for <alsa-devel@alsa-project.org>; Mon,  3 Jan 2005 12:05:01 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=763> 
======================================================================
Reported By:                lovett
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   763
Category:                   CORE OSS - pcm
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             12-30-2004 22:48 CET
Last Modified:              01-03-2005 12:05 CET
======================================================================
Summary:                    I can't make the emulation of /dev/dsp work;  the
driver "executes" but reports errors;  there is no sound output.
Description: 
I have a "Sound Blaster" card.  /proc/asound/cards says:
0 [Live           ]: EMU10K1 - Sound Blaster Live!
                     Sound Blaster Live! (rev.8, serial:0x80641102) at
0x8c00, irq 23
======================================================================

----------------------------------------------------------------------
 tiwai - 01-03-05 12:05 
----------------------------------------------------------------------
Does ALSA native app work?  What is exactly a problem?

If you mean "no sound output" as the silence, check the mixer
configuration at first.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-30-04 22:48 lovett         New Issue                                    
01-03-05 12:05 tiwai          Note Added: 0003052                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
