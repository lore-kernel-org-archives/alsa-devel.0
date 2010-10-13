From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tlv320dac33: Control for line output
	gain
Date: Wed, 13 Oct 2010 01:43:43 -0700
Message-ID: <20101013084343.GA29239@opensource.wolfsonmicro.com>
References: <1286957298-28615-1-git-send-email-peter.ujfalusi@nokia.com>
	<20101013081402.GB6424@rakim.wolfsonmicro.main>
	<201010131140.26724.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 35CD91039FE
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Oct 2010 10:43:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201010131140.26724.peter.ujfalusi@nokia.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 13, 2010 at 11:40:26AM +0300, Peter Ujfalusi wrote:

> In the documentation these gains are described like that (0.25V.V / 1V/V), and I 
> wanted to use the same in the enum elements, but what about:

> /* L/R Line Output Gain */
> static const char *lr_lineout_gain_texts[] = {
>        "Line -12dB DAC 0dB", "Line -6dB DAC 6dB",
>        "Line 0dB DAC 12dB", "Line 6dB DAC 18dB",
> };

That's *much* clearer.
