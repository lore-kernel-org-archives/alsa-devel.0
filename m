From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000759]: reloading opl4 driver isn't allowed - it segfaults
Date: Sun, 16 Jan 2005 17:33:21 +0100
Message-ID: <e3e1543bbf44180d14266e2edc8171f2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A55742A2
	for <alsa-devel@alsa-project.org>; Sun, 16 Jan 2005 17:33:21 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=759> 
======================================================================
Reported By:                martin
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   759
Category:                   GENERIC - opl4
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             12-30-2004 00:05 CET
Last Modified:              01-16-2005 17:33 CET
======================================================================
Summary:                    reloading opl4 driver isn't allowed - it segfaults
Description: 
I'm writing a driver for the miroSOUND PCM12. But I have some trouble with
the OPL4 part and I'm afraid it's not related to my hardware/software. The
first modprobe works ok and OPL4 behaves correct. Then rmmod'ing the
driver and modprobe'ing it again shows a segfault.

The reason for the segfault is snd_opl4_create() which calls
snd_opl3_create() where snd_opl3_new() is the reason for the segfault. 

I don't see, that a correct unload of opl4 will ever run snd_device_free()
for the opl3 part? Any comments? Any OPL4 user out there for
cross-checking this with a working OPL4 environment? 
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 01-10-05 17:09 
----------------------------------------------------------------------
The OPL3/4 structures are registered with snd_device_new(), so ALSA will
automatically free them when the sound card is destroyed.

Reloading works fine on my system (with the snd-opti92x-ad1848 driver).

After unloading, is there anything remaining in /proc/asound/cards or
/proc/ioports?
Does the OPL4 initialization in your driver differ from the OPTi driver?

----------------------------------------------------------------------
 martin - 01-16-05 17:33 
----------------------------------------------------------------------
Thanks for the answer, but actually I've some bigger problems with my OPL4
-- it doesn't respond at all. I hope it's not completely destroyed and I
can reanimate it by a Windows installation or so...

The miroSOUND has also an OPTi chip and I've used the same init parts like
the snd-opti92x-ad1848 driver. Thanks for confirming opl4 driver
correctness. So I have to look for a bug on my side. I was afraid about
it. Thanks, Clemens.

I guess we can close the report now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-30-04 00:05 martin         New Issue                                    
01-10-05 17:09 Clemens LadischNote Added: 0003137                          
01-16-05 17:33 martin         Note Added: 0003220                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
