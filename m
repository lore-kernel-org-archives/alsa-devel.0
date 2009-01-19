From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [Patch] WM9705 tweak
Date: Mon, 19 Jan 2009 13:36:58 +0000
Message-ID: <20090119133656.GB22473@sirena.org.uk>
References: <49747F0E.6080600@mnementh.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0600C1037F5
	for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2009 14:36:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <49747F0E.6080600@mnementh.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ian Molton <ian@mnementh.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 19, 2009 at 01:24:30PM +0000, Ian Molton wrote:

> From 47fa5f6a17ff9a7e546c7fae84b0a9c0b97bc74d Mon Sep 17 00:00:00 2001
> From: Ian Molton <ian@mnementh.co.uk>
> Date: Mon, 19 Jan 2009 12:46:54 +0000
> Subject: [PATCH] ASoC: codec: WM9705 Fix capture switch name

> This patch fixes the acpture switch name so that it shows up in alsamixer.

Are you absolutely sure that it doesn't get displayed at all?  Note that
the default display for alsamixer only shows controls it thinks are
playback controls, you need to use tab to change the view to show other
controls.

> -	SOC_DOUBLE("PCM Capture Volume", AC97_REC_GAIN, 8, 0, 15, 0),
> -	SOC_SINGLE("PCM Capture Switch", AC97_REC_GAIN, 15, 1, 1),
> +	SOC_DOUBLE("Capture Volume", AC97_REC_GAIN, 8, 0, 15, 0),
> +	SOC_SINGLE("Capture ADC Switch", AC97_REC_GAIN, 15, 1, 1),

I'd expect the two control names to still match up...
