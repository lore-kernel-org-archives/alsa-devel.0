From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] sound/soc/lapis: add platform driver
Date: Mon, 12 Dec 2011 10:05:14 +0000
Message-ID: <20111212100513.GA5017@sirena.org.uk>
References: <1321848532-8784-1-git-send-email-tomoya.rohm@gmail.com>
	<1321848532-8784-3-git-send-email-tomoya.rohm@gmail.com>
	<20111121114524.GE3784@opensource.wolfsonmicro.com>
	<CANKRQnivyNXNZPnaUOHwpXpJz+kCz6gOwfqYNwkcOo5EpsSvZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 14BF910399F
	for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2011 11:05:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CANKRQnivyNXNZPnaUOHwpXpJz+kCz6gOwfqYNwkcOo5EpsSvZQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>, qi.wang@intel.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, yong.y.wang@intel.com, kok.howg.ewe@intel.com, Daniel Mack <zonque@gmail.com>, Liam Girdwood <lrg@ti.com>, joel.clark@intel.com
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 12, 2011 at 05:28:13PM +0900, Tomoya MORINAGA wrote:

> struct snd_soc_ops {
> ...
> };

> On the other hand, tegra_i2s.c describes like below.

> static const struct snd_soc_dai_ops tegra_i2s_dai_ops = {
> ...
> };

> Which is true as modern driver ? or case by case ?

The latter.  With things like this it would be *really* helpful if you
could take a step back and think about what the differences mean and why
they are different.

> 
> >> +#define      I2S_CH0_MCLK            (12288000) /* Master Clock Frequency[Hz] */
> > This looks like it should be board specific?
> Should our platform driver use "clk_get()" ?
> If no, how should our driver get the value ?

Again, with things like this it would be really helpful if you could
attempt to answer questions for yourself.  Have you looked at how other
platforms configure clock rates from machine drivers?
