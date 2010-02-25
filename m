From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC update for 2.6.34
Date: Thu, 25 Feb 2010 09:31:58 +0000
Message-ID: <20100225093157.GA10141@rakim.wolfsonmicro.main>
References: <20100224182309.GA26018@rakim.wolfsonmicro.main>
	<s5hzl2xyckc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 391EB10381F
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 10:31:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hzl2xyckc.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 25, 2010 at 08:55:15AM +0100, Takashi Iwai wrote:

> BTW, we need to prepare slowly the announce for 2.6.34 merge.
> Could you give the brief description of ASoC specific changes?

Here you go:

    * Support for turning CODEC biases off completely when idle,
      providing power savings for modern devices with ground referenced
      outputs where this can be done quickly at runtime without pops and
      clicks.

    * Support for disabling physical writes to the device in the generic
      cache control code, allowing devices to be completely powered off when
      idle while still providing their control to userspace through the
      standard register interfaces.

    * Support for tuning the time ASoC waits before powering things down
      after playback has finished (in order to involve issues between tracks
      or similar) at runtime or from the machine driver.

    * New drivers for DA7210, DB1200 I2S and AC97 controllers, i.MX3x
      SSI ports, OMAP4 McPDM ports, S3C64xx AC97 controller, SH SIU (Sound
      Interface Unit), WM2000, WM8904, WM8912, WM8955, WM8978 and WM8994
