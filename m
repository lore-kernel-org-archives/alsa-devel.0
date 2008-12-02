From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ASoC: TWL4030 codec: Multiple DAC nameing
Date: Tue, 2 Dec 2008 10:36:29 +0000
Message-ID: <20081202103628.GB7940@sirena.org.uk>
References: <200812021233.08255.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C0406245A5
	for <alsa-devel@alsa-project.org>; Tue,  2 Dec 2008 11:36:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200812021233.08255.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 02, 2008 at 12:33:07PM +0200, Peter Ujfalusi wrote:

> /* DACs */
> SND_SOC_DAPM_DAC("DACR1", "Right Front Playback",
> 		TWL4030_REG_AVDAC_CTL, 0, 0),
> SND_SOC_DAPM_DAC("DACL1", "Left Front Playback",
> 		TWL4030_REG_AVDAC_CTL, 1, 0),
> SND_SOC_DAPM_DAC("DACR2", "Right Rear Playback",
> 		TWL4030_REG_AVDAC_CTL, 2, 0),
> SND_SOC_DAPM_DAC("DACL2", "Left Rear Playback",
> 		TWL4030_REG_AVDAC_CTL, 3, 0),

> Are these are OK, or should I just use "Right Playback" for both DACR1 and 
> DACR2?

Your current naming is good - if you use only "Right Playback" DAPM
won't be able to distinguish the two audio streams from each other.
