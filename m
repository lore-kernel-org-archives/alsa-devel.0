From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Capture from 3+ cards connected to a USB hub -
	distorted samples
Date: Sat, 10 Dec 2011 00:23:35 +0100
Message-ID: <4EE29877.2050804@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
	[84.242.75.189])
	by alsa0.perex.cz (Postfix) with ESMTP id B6C87103915
	for <alsa-devel@alsa-project.org>; Sat, 10 Dec 2011 00:24:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by cable.insite.cz (Postfix) with ESMTP id 8CE11A1A40B1C
	for <alsa-devel@alsa-project.org>; Sat, 10 Dec 2011 00:24:11 +0100 (CET)
Received: from cable.insite.cz ([84.242.75.189])
	by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N80xRDz7hru2 for <alsa-devel@alsa-project.org>;
	Sat, 10 Dec 2011 00:23:56 +0100 (CET)
Received: from [192.168.105.102] (ip28.insite.cz [81.0.237.28])
	(Authenticated sender: pavel)
	by cable.insite.cz (Postfix) with ESMTPSA id 476B0A1A32346
	for <alsa-devel@alsa-project.org>; Sat, 10 Dec 2011 00:23:56 +0100 (CET)
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

Hi,

I have been informed about the following problem which I was able to 
reproduce afterwards:

* Latest git.alsa-project.org drivers

* USB 2.0 hub, 3 or more USB soundcards (inexpensive USB sticks, USB 
audio v.1 types, async capture, adaptive playback) hooked to the hub, 
identified A, B, C, D.

* NONE of these soundcards is playing back

Now:

* Card A begins microphone capturing (mono 48/16), result OK

* Card B begins capturing (mono 48/16), both results still OK

* As soon as the third card C begins capturing, the signal captured from 
  cards A and B gets distorted. Audacity shows some samples are 
incorrect, distorting the expected sine waveform of the testing signal. 
I can provide screenshots as well as recorded samples, if needed.

* The signal recorded from card C is OK.

BUT

* If any card hooked to the HUB is playing back (even a fourth one D), 
the distortion does not occur. It happens only when there is no playback 
stream going through the hub. Traffic on another USB port has no effect, 
in fact the test signal for the three cards was provided by a 
multichannel USB card hooked to another USB port.

It seems to me as if blocks of samples for each card in the USB frame 
sometimes overlap by a few bits, corrupting the neighbouring card 
samples, or are recovered incorrectly.

I understand I have provided no real data, I am ready to do so plus any 
tests you would consider useful.

Thanks a lot for suggestions of the next debugging steps I should do.

Regards,

Pavel.
