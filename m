From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC - Output widgets
Date: Mon, 25 Feb 2008 13:34:33 +0000
Message-ID: <20080225133430.GB9038@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E3F510383F
	for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2008 14:34:34 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexandre BOUIN <a.bouin@kerlink.fr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 25, 2008 at 10:39:15AM +0100, Alexandre BOUIN wrote:

>  - 1 SND_SOC_DAPM_MIXER is connected to 2 SND_SOC_DAPM_PGA with power
> control.
>  - each PGA is connected to an SND_SOC_DAPM_OUTPUT
>  - according to tosa example : 
>     - first OUTPUT is connected to a SND_SOC_DAPM_HP defined as endpoint
>     - second OUTPUT is connected to a SND_SOC_DAPM_SPK defined as endpoint
> this SPK is set disconnected in my tosa_ac97_init -like function

Could you please post dmesg output with DAPM_DEBUG turned on which shows
this happening?
