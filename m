From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 3.2
Date: Mon, 10 Oct 2011 13:46:12 +0100
Message-ID: <20111010124612.GB1098@sirena.org.uk>
References: <20111010114155.GC3607@opensource.wolfsonmicro.com>
	<s5hwrcdxbkq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C462244A9
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Oct 2011 14:46:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hwrcdxbkq.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 10, 2011 at 02:42:13PM +0200, Takashi Iwai wrote:

> Also, could you guys slowly make summaries for 3.2 merges?

- Substantial optimization of the DAPM algorithm, substantially reducing
  the CPU usage when power states change. This is especially beneficial
  with larger modern devices.
- Support for CODEC drivers using the regmap API.
- Some smaller API updates - support for larger register maps, support
  for specifying a source when setting a sysclk.
- New CPU for Alchemy and Freescale MXS.
- New CODEC drivers for Analog ADAU1373, Realtek RT5631 and Wolfson
  Microelectronics WM1811 and WM5100.
