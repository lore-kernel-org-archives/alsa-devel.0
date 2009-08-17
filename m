From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: UDA134X Codec: Fix mute/unmute
	code	mistake and add ADC/DAC power control support
Date: Mon, 17 Aug 2009 12:56:33 +0100
Message-ID: <20090817115633.GC4464@sirena.org.uk>
References: <1250498216.2764.1.camel@shinel>
	<20090817103248.GA4464@sirena.org.uk>
	<1250508154.1932.37.camel@shinel>
	<20090817112756.GA19898@rakim.wolfsonmicro.main>
	<1250509995.1932.44.camel@shinel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id AEF7224698
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Aug 2009 13:56:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1250509995.1932.44.camel@shinel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shine Liu <shinel@foxmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 17, 2009 at 07:53:15PM +0800, Shine Liu wrote:

> Should be "sys_power = codec->bias_level != SND_SOC_BIAS_STANDBY;" ?

Yes.
