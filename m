From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tlv320dac33: Control for line output
	gain
Date: Wed, 13 Oct 2010 09:14:03 +0100
Message-ID: <20101013081402.GB6424@rakim.wolfsonmicro.main>
References: <1286957298-28615-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DD7D924371
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Oct 2010 10:14:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1286957298-28615-1-git-send-email-peter.ujfalusi@nokia.com>
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

On Wed, Oct 13, 2010 at 11:08:18AM +0300, Peter Ujfalusi wrote:

> +/* L/R Line Output Gain */
> +static const char *lr_lineout_gain_texts[] = {
> +	"Line 0.25V/V DAC 1V/V", "Line 0.5V/V DAC 2V/V",
> +	"Line 1V/V DAC 4V/V", "Line 2V/V DAC 8V/V",
> +};

I'm having a hard time parsing what these actually mean so I'm guessing
users are going to have trouble also - is there anything that could be
done to make things clearer?
