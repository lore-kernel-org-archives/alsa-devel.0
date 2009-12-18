From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: alsa device drain power
Date: Fri, 18 Dec 2009 12:53:56 +0000
Message-ID: <20091218125356.GA29829@rakim.wolfsonmicro.main>
References: <4B29F03F.4020100@gandalf.sssup.it>
	<20091217110334.GB12245@sirena.org.uk>
	<4B2B536F.4060800@gandalf.sssup.it>
	<20091218113225.GD19544@sirena.org.uk>
	<4B2B73A3.1010702@gandalf.sssup.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 180A01038B8
	for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2009 13:53:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B2B73A3.1010702@gandalf.sssup.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 18, 2009 at 01:20:51PM +0100, Michael Trimarchi wrote:

> I don't send any sound to the device so it remains on, it's the
> correct behavior?

What do you mean by that - what exactly is "send any sound to the
device" in this context?  Do you mean that you aren't playing any audio
from the CPU?  If so note that the WM8753 in the OpenMoko phones
supports various bypass paths which allow audio to be passed through the
device with no intervention from the CPU.

> android start and open playback device, and the system has the lm
> on, so it drains more power
> that it needs. Of course when you do some call, it change again the
> status to OFF but return
> to ON again

This sounds like the driver is performing as expected but you've s

DAPM will explain its power decisions in the debugfs under the ASoC
directory.
