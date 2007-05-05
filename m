From: Jeff Rush <jeff@taupro.com>
Subject: Call for Explanation of ALSA Config Behavior
Date: Sat, 05 May 2007 02:24:32 -0500
Message-ID: <463C3130.1070105@taupro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rampart.timecastle.net (rampart.timecastle.net [192.67.63.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 276292439E
	for <alsa-devel@alsa-project.org>;
	Sat,  5 May 2007 09:18:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I'm trying to get ALSA to support all the little features of my laptop, which
is based on the Intel HDA chipset with the Realtek codec.  I'm also playing
with the softvol plug to add a volume controls over certain virtual devices.

A few questions I can't figure out:

1. Isn't it the standard convention that there be a control named "Master"
   that adjusts the overall volume of a device?  So why does the Intel HDA
   ALSA driver define one named "Headphone" that does the same thing instead
   of following that convention?  Is there some reason, or perhaps a
   difference in opinion within the ALSA community on the naming of controls?
   Shouldn't every ALSA driver define a "Master" control?

2. When I add a control using the softvol plugin, the mixer GUI shows it in
   both the playback and the capture set of controls.  Why and how can I
   tag a control to belong to only one set or the other?  Being a volume
   control it seems it should only be in the playback collection.

3. Once I add such a control, it -never- goes away.  What I mean is that if
   I rename it, or remove it, and restart ALSA or even restart the entire
   computer, the old name for the control always shows up in the mixer GUI.
   I've grepped *all* of /etc, looking in the /etc/asound.conf,
   /etc/asound.state and ~/.asoundrc files but the old name isn't anywhere
   --  where is it coming from?

Thanks very much for any help you can provide,  For years I've just tried to
"use" ALSA but now I'm trying to actually understand its subtle nuances.

-Jeff
