From: Felix Homann <linuxaudio@showlabor.de>
Subject: Need expert's advice - Fast Track Ultra (8R) dropping
	samples
Date: Sat, 25 Sep 2010 11:57:53 +0200
Message-ID: <4C9DC7A1.8050001@showlabor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vwp5738.webpack.hosteurope.de (vwp5738.webpack.hosteurope.de
	[83.169.30.203]) by alsa0.perex.cz (Postfix) with ESMTP id E0C9124465
	for <alsa-devel@alsa-project.org>;
	Sat, 25 Sep 2010 11:57:56 +0200 (CEST)
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
Cc: tiwai@suse.de, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Hi,

in that past months I've been trying get the Fast Track Ultra devices 
working properly in Alsa. We've had lots of progress, most of the code 
has moved to Alsa git and today I've even posted a patch for getting 
mixer support for these devices.

Now, I need to get some expert's advice: The devices seem to drop 
samples or frames. Here's a report I've got today on the M-Audio forum:

"I've got a subtle problem to report: I think audio playback is dropping
sample frames. To hear the problem, open Audacity at 48 kHz and play
a 10-kHz. sine wave. When I do that I hear a regular clicking sound, about
four clicks a second. I've tried recording the output and if I'm seeing 
correctly,
exactly one sample frame in every 13312 (13x1024) is being dropped on 
output.
I don't see anything similar on input. When either jack or Pd has both 
the input and
the output open, the delay from input to output gradually decreases 
until it forces
occasional sync errors. (I haven't tried this with audacity though.)"

(see 
http://forums.m-audio.com/showthread.php?714-Not-a-problem.-FastTrack-on-linux&p=98101#post98101)

I could reproduce it on my machines, even at 44.1 kHz. The clicking 
sound is very subtle, it goes unnoticed when not listening to pure sines 
without attention to clicks.

How can this be sorted out. Any ideas?

Kind regards,

Felix
