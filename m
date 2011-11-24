From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] ASoC: samsung: drop unknown Kconfig symbol
Date: Thu, 24 Nov 2011 20:09:14 +0100
Message-ID: <1322161754.25125.72.camel@x61.thuisdomein>
References: <1322155037.25125.61.camel@x61.thuisdomein>
	 <20111124172216.GR8470@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111124172216.GR8470@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-11-24 at 17:22 +0000, Mark Brown wrote:
> On Thu, Nov 24, 2011 at 06:17:17PM +0100, Paul Bolle wrote:
> There's people somewhat actively working on the OpenMoko devices out of
> tree (and I personally have a GTA01) and I'd rather not do anything that
> causes any more hassle for them.

I don't own a GTA01. Neither do I like to cause hassle for the people
working on OpenMoko.

But the history of the code my patch drops, seems to start with
(mainline) commits 74930bb6db ("[ALSA] ASoC S3C24xx machine drivers -
Openmoko Neo1973") and 80ab1c0e9e ("[ALSA] ASoC S3C24xx machine drivers
- Kconfig"), both dated May 14, 2007. So I'm touching code here that has
been unbuildable (in the mainline tree) for over four years. Isn't that
in itself sufficient to drop this code (and the incomplete kbuild stuff
supporting it)?

> I'd suggest discussing this with the OpenMoko guys if you want to do it.

Who would that be?


Paul Bolle
