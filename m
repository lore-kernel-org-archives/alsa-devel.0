From: Jesse Chappell <jesse@essej.net>
Subject: Re: Alsa handling of spdif bits (was Re: Questions to HDSP users)
Date: Thu, 05 Feb 2004 14:08:15 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <f87b1d8ca44251034e552d245dd4da21@essej.net>
References: <s5hd68ta93u.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from test.essej.net (pilabs.com [4.21.76.131])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA05731
	for <alsa-devel@alsa-project.org>; Thu, 5 Feb 2004 20:08:50 +0100
In-Reply-To: <s5hd68ta93u.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>, Thomas Charbonnel <thomas@undata.org>
List-Id: alsa-devel@alsa-project.org


 > regarding Jesse's problem:
 > it looks like RME*.conf are broken.
 > does the attached patch work?

Sorry, I had already created a new H-DSP.conf and figured out
it needed the 'interface PCM'.   I was able to use ac3dec -C to
open the device, and attempted to stream through it, but nothing
streamed.  

Standard PCM streaming and mixing works fine over the spdif. 
I have a feeling there is some strange interaction with the mixer's
normal operation and the special spdif modes.

An aside: this is also complicated because to open the device, the
channels item in the slave.pcm section must match the iobox in
use (multiface or digiface) which have differing channel counts.
So when we do get this working, it will be a problem to handle
both cases in a conf file.

jlc


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
