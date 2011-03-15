From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.39
Date: Tue, 15 Mar 2011 19:31:06 +0000
Message-ID: <20110315193106.GA5302@opensource.wolfsonmicro.com>
References: <20110315131842.GA23533@opensource.wolfsonmicro.com>
	<s5hwrk0cp23.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3E28F245F2
	for <alsa-devel@Alsa-project.org>; Tue, 15 Mar 2011 20:31:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hwrk0cp23.wl%tiwai@suse.de>
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
Cc: alsa-devel@Alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 15, 2011 at 05:43:16PM +0100, Takashi Iwai wrote:

> BTW, Mark, Liam, could you guys slowly prepare for whats-new-in-2.6.39
> notes?

- Support for registering machine drivers as first class devices rather
  than using the soc-audio device. Support for the soc-audio device will
  be removed at some point in the future.
- Support for ordering widget power changes within widget types, helping
  with large CODECs and multi-stage amplifiers.
- Support for waiting for multiple slow events to complete during DAPM
  sequences, making it easier to handle things like DC offset correction
  on multiple outputs.
- CPU support for Intel Medfield and nVidia Tegra2.
- CODEC support for Cirrus CS4271, Freescale SGTL5000, Maxim MAX8950,
  National Semiconductors LM4857, TI SN95031 and Wolfson WM8991
- Machine support for Intel Medfield MID reference platforms, nVidia
  Harmony, and Visstrim M10.
