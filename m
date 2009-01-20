From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2.6.29] ASoC: Allow Freescale MPC8610	audio
	drivers to be compiled as modules
Date: Tue, 20 Jan 2009 20:32:14 +0000
Message-ID: <20090120203201.GC6864@sirena.org.uk>
References: <1232387866-14365-1-git-send-email-timur@freescale.com>
	<s5hzlhmqy8m.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 03A2B10384A
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 21:32:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hzlhmqy8m.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 20, 2009 at 07:37:29AM +0100, Takashi Iwai wrote:

> >  config SND_SOC_MPC8610_HPCD
> > -	bool "ALSA SoC support for the Freescale MPC8610 HPCD board"
> > -	depends on SND_SOC_MPC8610
> > +	tristate "ALSA SoC support for the Freescale MPC8610 HPCD board"
> > +	depends on SND_SOC && MPC8610_HPCD

> The dependency on SND_SOC isn't needed here because this item is
> already inside "if SND_SOC".

Yup.  Applied with that mod, thanks!
