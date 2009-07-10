From: "Sean M. Pappalardo" <pegasus@renegadetech.com>
Subject: Bug report: Random MIDI output data
	drop-outs/corruption
Date: Fri, 10 Jul 2009 10:03:30 -0400
Message-ID: <4A574A32.1010506@renegadetech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smartmail.smartertechnology.net
	(smartmail.smartertechnology.net [72.245.160.207])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E98224696
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jul 2009 16:04:16 +0200 (CEST)
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

Hello there.

I just wanted to call your attention to a bug report I recently filed,
because I'm not sure I put it in the right place:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4606

In a nutshell, ALSA seems to be dropping or corrupting output MIDI
messages (both "short" and SysEx) at random as evidenced by the devices
not lighting some LEDs or changing modes (sysex) on occasion. The
problem is positively affected, but not completely mitigated, by the use
of a real-time kernel. aseqdump -d shows everything correctly even when
the device response is incorrect.

All details are in that bug report including links to alsa-info output
in the notes.

Thanks for your time. Let me know if I can provide any further information.

Sincerely,
Sean M. Pappalardo
"D.J. Pegasus"

<<--------------------------------------------------------------------------------->>
This E-Mail message has been scanned for viruses
and cleared by >>SmartMail<< from Smarter Technology, Inc.
<<--------------------------------------------------------------------------------->>
