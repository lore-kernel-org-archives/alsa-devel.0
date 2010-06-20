From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Problem on wm8974 alsa driver
Date: Sun, 20 Jun 2010 14:27:44 +0100
Message-ID: <20100620132744.GC2405@opensource.wolfsonmicro.com>
References: <MPTMAFLHXLTAAHZYLDISCAXRPPTF.jjinfo@nudt.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 810D724153
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Jun 2010 15:27:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <MPTMAFLHXLTAAHZYLDISCAXRPPTF.jjinfo@nudt.edu.cn>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "jjinfo@nudt.edu.cn" <jjinfo@nudt.edu.cn>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Jun 20, 2010 at 01:48:03AM +0800, jjinfo@nudt.edu.cn wrote:

> By now, we can confirm that the digital signal has arrived the wm8974
> DAI interface.  As per wm8974 manual, it is required to set some 8974
> registers(such as enabling DAC, MONOOUT,etc) so as to get analogue
> signal.

> However, the codec driver (wm8974.c) does not provide any routine to
> set those necessary registers. My question is, where and how are these

What makes you say that the driver has no support for these things?  The
driver provides automatic power management and application control for
audio routing and gains.  This control should be fairly complete.  For
example, the DAC power is controlled by line 221:

	SND_SOC_DAPM_DAC("DAC", "HiFi Playback", WM8974_POWER3, 0, 0),

This will be enabled when a playback is active and the DAC is connected
to an output.

> outpu-related registers of audio codec chip  got correctly set up? Are
> they set up by aplay via calling alsa library APIs?  Must we provide
> additional help functions to do such initialization?

aplay only deals with streaming PCM data to the CODEC.  You should use
an application such as alsamixer or amixer to configure the CODEC into
the desired state at runtime.  
