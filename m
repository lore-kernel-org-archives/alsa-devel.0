From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: intel8x0 has stopped working.
Date: Mon, 02 Feb 2004 17:41:02 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <401E8BAE.6010802@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-34.mail.demon.net (anchor-post-34.mail.demon.net [194.217.242.92])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA19042
	for <alsa-devel@alsa-project.org>; Mon, 2 Feb 2004 18:35:08 +0100
Received: from superbug.demon.co.uk ([80.176.146.252])
	by anchor-post-34.mail.demon.net with esmtp (Exim 3.35 #1)
	id 1AnhyU-0008rj-0Y
	for alsa-devel@alsa-project.org; Mon, 02 Feb 2004 17:35:06 +0000
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

In alsa 0.9.8, the snd-intel8x0 worked find with my MB. An ICH5 with ALC650.
With alsa 1.0.2, I get: -
device: front -> no-sound output
device: surround40: -> Only sound on rear left, and rear right.
device: surround51: -> Only sound on rear left, and rear right, center, lfe

So, in all cases there is never sound on the front speakers.

The same problem has happened to a person with an ICH2, which only has 
front speakers, so they get no sound at all.

I am investigating, and I suspect that the mixer has just lost the 
mixer/mute for the front speakers.

Is there a tool where I can adjust ac97 registers directly through a 
IOCTL or something, for test purposes?

Cheers
James



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
