From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 6/6] ASoC: Beagle: Add support for
	4	channel mode
Date: Mon, 6 Apr 2009 13:50:29 +0100
Message-ID: <20090406125028.GB14169@sirena.org.uk>
References: <1239020372-8457-1-git-send-email-peter.ujfalusi@nokia.com>
	<1239020372-8457-2-git-send-email-peter.ujfalusi@nokia.com>
	<1239020372-8457-3-git-send-email-peter.ujfalusi@nokia.com>
	<1239020372-8457-4-git-send-email-peter.ujfalusi@nokia.com>
	<1239020372-8457-5-git-send-email-peter.ujfalusi@nokia.com>
	<1239020372-8457-6-git-send-email-peter.ujfalusi@nokia.com>
	<1239020372-8457-7-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 588AA2438F
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Apr 2009 14:50:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1239020372-8457-7-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, alsa-devel@alsa-project.org, jarkko.nikula@nokia.com
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 06, 2009 at 03:19:32PM +0300, Peter Ujfalusi wrote:

> +	switch (params_channels(params)) {
> +	case 2: /* Stereo I2S mode */
> +		fmt =	SND_SOC_DAIFMT_I2S |
> +			SND_SOC_DAIFMT_NB_NF |
> +			SND_SOC_DAIFMT_CBM_CFM;
> +		break;
> +	case 4: /* Four channel TDM mode */
> +		fmt =	SND_SOC_DAIFMT_DSP_A |


Might it not be easier to just run in DSP mode all the time?
