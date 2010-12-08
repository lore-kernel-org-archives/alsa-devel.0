From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: tlv320dac33: Move DACL/R power
 on to PGA widget
Date: Wed, 8 Dec 2010 13:41:31 +0000
Message-ID: <20101208134131.GK16418@rakim.wolfsonmicro.main>
References: <1291813977-17944-1-git-send-email-peter.ujfalusi@nokia.com>
	<1291813977-17944-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2864C244CA
	for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2010 14:41:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1291813977-17944-2-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 08, 2010 at 03:12:57PM +0200, Peter Ujfalusi wrote:

> +	SND_SOC_DAPM_PGA("Left DAC Power", DAC33_LDAC_PWR_CTRL, 2, 0, NULL, 0),
> +	SND_SOC_DAPM_PGA("Right DAC Power", DAC33_RDAC_PWR_CTRL, 2, 0, NULL, 0),

These feels like they should be supply widgets for the output amps?
Might be a bit clearer.
