From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.33
Date: Thu, 3 Dec 2009 10:35:12 +0000
Message-ID: <20091203103511.GA24206@sirena.org.uk>
References: <20091130155032.GC18944@rakim.wolfsonmicro.main>
	<s5hws17vr7d.wl%tiwai@suse.de>
	<20091203101316.GA24033@sirena.org.uk>
	<s5hocmgwe3k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DB35910387F
	for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2009 11:35:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hocmgwe3k.wl%tiwai@suse.de>
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

On Thu, Dec 03, 2009 at 11:23:27AM +0100, Takashi Iwai wrote:

> BTW, I'm preparing "what's in sound git tree" for 2.6.33 now.
> Since 2.6.32 is out, I'm going to post it on Friday.

> Could you make it up for ASoC bits?  It'd be really helpful.

Sure:

This has been another fairly quiet release for ASoC.  Aside from the
addition of virtual mux support to DAPM and some further preparatory
work for multi-CODEC cards the majority of changes have been driver
updates, including:

  - New drivers for ADS117x, AK4671, TLV320DAC33, TPA6130A2, WM8711 and
    WM8727.
  - Substantial improvements to DMA performance and reliability on
    MPC5200 and DaVinci.
  - Capture support for the FSI port on SH.

Due to cross tree merge issues some updates to the TWL4030 MFD code are
also included, enabling sharing of the CODEC hardware by support for the
VIBRA interface of the devices.
