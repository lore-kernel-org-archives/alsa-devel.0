From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000796]: Behavior of LED on mute button
Date: Mon, 10 Jan 2005 14:59:25 +0100
Message-ID: <a5a38bf9bcf8c2dadc38f1ecc9d20ce2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4190B164
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2005 14:59:25 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=796> 
======================================================================
Reported By:                kempokaraterulz
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   796
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-09-2005 02:26 CET
Last Modified:              01-10-2005 14:59 CET
======================================================================
Summary:                    Behavior of LED on mute button
Description: 
On my laptop, there is this little blue LED on the mute button, muting  /
unmuting the sound doesnt have any effect on this LED currently, if i
unload the sound module the LED turns on, and if i reload the sound module
it turns back off. Since the sound driver turns the light on when being
unloaded, my (possibly incorrect) guess is that this would be a fairly
easy thing to implement properly, or at least allow control of the light
through the proc interface or something. 
======================================================================

----------------------------------------------------------------------
 tiwai - 01-10-05 14:59 
----------------------------------------------------------------------
First, try ALSA 1.0.8rc2.

Is the mute LED turned on/off when you change "External Amplifier" mixer
switch?
If so, use ac97_quirk=mute_led option.  If this fixes the problem, let me
know the output of lspci -nv and the name of your mobo/machine to enable
the quirk as default.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-09-05 02:26 kempokaraterulzNew Issue                                    
01-10-05 14:59 tiwai          Note Added: 0003135                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
