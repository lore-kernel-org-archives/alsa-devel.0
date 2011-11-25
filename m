From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 8/8] ASoC: SigmaDSP: Add regmap support
Date: Fri, 25 Nov 2011 10:00:04 +0100
Message-ID: <4ECF5914.2030602@metafoo.de>
References: <1322138908-32127-1-git-send-email-lars@metafoo.de>
	<1322138908-32127-8-git-send-email-lars@metafoo.de>
	<201111241230.41331.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-169.synserver.de (smtp-out-169.synserver.de
	[212.40.185.169])
	by alsa0.perex.cz (Postfix) with SMTP id 971C5103E9F
	for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2011 09:59:07 +0100 (CET)
In-Reply-To: <201111241230.41331.vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: drivers@analog.com, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 11/24/2011 06:30 PM, Mike Frysinger wrote:
> On Thursday 24 November 2011 07:48:27 Lars-Peter Clausen wrote:
>> Add support for loading the SigmaDSP firmware using regmap. This allows us
>> to transparently use SPI or I2C as the transport protocol on devices which
>> support them.
> 
> Acked-by: Mike Frysinger <vapier@gentoo.org>
> 
>> For now we keep the old I2C support since we have one user of this which is
>> not straight forward to convert to regmap, due to variable length
>> registers.
> 
> add a Kconfig knob so it's disabled by default except for the old codec ?
> -mike

I don't think it's worth it. The I2C specific code is maybe 15 lines.
