From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: OMAP: Kconfig string cleanup
Date: Tue, 13 Dec 2011 11:52:48 +0200
Message-ID: <4EE72070.2050806@ti.com>
References: <1323765017-31943-1-git-send-email-peter.ujfalusi@ti.com>
	<20111213083119.GJ7148@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog108.obsmtp.com (na3sys009aog108.obsmtp.com
	[74.125.149.199])
	by alsa0.perex.cz (Postfix) with ESMTP id BDBA22454C
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 10:52:34 +0100 (CET)
Received: by mail-lpp01m010-f51.google.com with SMTP id o2so575631lag.38
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 01:52:21 -0800 (PST)
In-Reply-To: <20111213083119.GJ7148@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 12/13/2011 10:31 AM, Mark Brown wrote:
> On Tue, Dec 13, 2011 at 10:30:17AM +0200, Peter Ujfalusi wrote:
> =

>> -	tristate "SoC Audio for the Texas Instruments OMAP chips"
>> +	tristate "SoC Audio for Texas Instruments OMAP based boards"
>>  	depends on ARCH_OMAP
> =

>> -	tristate "SoC Audio support for Nokia N810"
>> +	tristate "Audio support for Nokia N810"
> =

> You should probably make your mind up if it's SoC audio or just plain
> audio.  I don't mind which, I just noticed the variation.

Initially I dropped the "Soc Audio" from the ASoC machine driver support
selection leaving only "Support for...".
Then I looked at for example Samsung's Kconfig. The most recent machine
config entries were using "Audio support for..." (9b8dc66f, 22cb839b,
abda5dfd, 0a590b1d) instead of the previously used "SoC PCM, I2S, S/PDIF
Audio Support for..."

Just ignore this patch. It is only cosmetic.

-- =

P=E9ter
