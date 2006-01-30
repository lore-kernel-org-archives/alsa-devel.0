From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001787]: Terratec Aureon Universe - No sound on first startup, sound after reboot
Date: Mon, 30 Jan 2006 19:38:45 +0100
Message-ID: <5ae19f33703128a1f982a6e8e8bd1106@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B7C0F1D3
	for <alsa-devel@alsa-project.org>; Mon, 30 Jan 2006 19:38:45 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1787> 
======================================================================
Reported By:                paskharen
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1787
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Ubuntu
Kernel Version:             2.6.12
======================================================================
Date Submitted:             01-27-2006 19:58 CET
Last Modified:              01-30-2006 19:38 CET
======================================================================
Summary:                    Terratec Aureon Universe - No sound on first
startup, sound after reboot
Description: 
When I first start the computer, you can hear no sound. If I turn all
volume to max and press my ear against the speaker I can hear the correct
sounds/music very faintly. After a reboot sound is fine.
======================================================================

----------------------------------------------------------------------
 ungod - 01-28-06 18:02 
----------------------------------------------------------------------
I too suspect the amplifier. When you have booted up the first time, can
you then hear a *click* from the amplifier when you toggle the External
Amplifier switch?

----------------------------------------------------------------------
 paskharen - 01-30-06 19:38 
----------------------------------------------------------------------
Funny, I just tried this after your comment, I never thought of trying...
The External Amplifier refuses to be toggled on first boot. It is shown as
"off" in alsamixer and can't be turned on. Other controls, like "DAC
Deempasis" can be toggled.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-27-06 19:58 paskharen      New Issue                                    
01-27-06 19:58 paskharen      Distribution              => Ubuntu          
01-27-06 19:58 paskharen      Kernel Version            => 2.6.12          
01-28-06 18:02 ungod          Note Added: 0007829                          
01-30-06 19:38 paskharen      Note Added: 0007841                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
