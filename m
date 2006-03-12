From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Stereo or mono - how to tell, what to do?
Date: Sun, 12 Mar 2006 20:14:27 +0000
Message-ID: <1142194467.19034.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp2.homechoice.co.uk (sc-outsmtp2.homechoice.co.uk [81.1.65.36])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 40FC21E8
	for <alsa-devel@alsa-project.org>; Sun, 12 Mar 2006 21:14:32 +0100 (MET)
Received: from bossclass ([192.168.62.105])
	by localhost.localdomain (8.13.4/8.13.4/Debian-3) with ESMTP id k2CKET5e014500
	for <alsa-devel@alsa-project.org>; Sun, 12 Mar 2006 20:14:30 GMT
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

I want to add the capacity to play stereo samples to my Dreamcast sound
driver.

The hardware does not support interleaved samples and in the OSS driver
I simply separated out the input stream into two different buffers and
transferred them separately into the hardware's memory. Can I do the
same with ALSA or is there some middle layer magic I should be aware of?

And how can my driver tell if the incoming samples are stereo or not. In
OSS this was all done through the SNDCTL_DSP_STEREO and
SNDCTL_DSP_CHANNELS ioctls, how do I do it in ALSA (I need to inform the
hardware to expect two channels and not one).

Adrian




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
