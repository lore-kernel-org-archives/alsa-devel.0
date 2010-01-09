From: Josh Lehan <alsa@krellan.com>
Subject: Newbie question: Sending untimed MIDI data to ALSA seq
Date: Sat, 09 Jan 2010 15:13:23 -0800
Message-ID: <4B490D93.1050506@krellan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server3.hostdango.com (server3.hostdango.com [67.222.146.219])
	by alsa0.perex.cz (Postfix) with ESMTP id 787FD1037F2
	for <alsa-devel@alsa-project.org>; Sun, 10 Jan 2010 00:13:27 +0100 (CET)
Received: from c-24-4-183-246.hsd1.ca.comcast.net ([24.4.183.246]
	helo=[10.6.9.2])
	by server3.hostdango.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69) (envelope-from <alsa@krellan.com>) id 1NTkUm-00064O-33
	for alsa-devel@alsa-project.org; Sat, 09 Jan 2010 15:13:24 -0800
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

Hello.

Newbie question: I'm wondering about sending untimed MIDI data to the
ALSA sequencer subsystem.

The application would be for a "beep"-like program, from the command
line, that instead of making beeps, would play MIDI instruments to make
better-sounding beeps.

I have TiMidity hooked up into ALSA, as a softsynth, and it works just
fine for playing MIDI data sent to it by ALSA.

The "aplaymidi" command works for .MID files, and the "vkeybd" program
works for simulating a keyboard and sending in untimed MIDI data.  The
"aseqview" program also works great for watching the notes being played,
as they go by.  So, my MIDI software stack appears to be in order.  I
don't have a hardware synthesizer hooked up at the moment (my Kawai K1
is showing its age, and a few keys are broken).

I also looked at "amidi", which features a -S option to send in untimed
MIDI bytes, but unfortunately, that addresses an entirely different
namespace.  Evidently, it only speaks to "RawMIDI" devices, of which
TiMidity is not.

So, I can't generate untimed MIDI data on my own.  I was thinking of
writing a small "midibeep" program that would do this, similar to what
vkeybd does, but without requiring any user interaction.

Does such a program already exist?

Thanks!

Josh
