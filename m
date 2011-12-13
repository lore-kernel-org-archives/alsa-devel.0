From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] sound/soc/lapis: add platform driver
Date: Tue, 13 Dec 2011 12:59:59 +0800
Message-ID: <20111213045958.GC4565@opensource.wolfsonmicro.com>
References: <1321848532-8784-1-git-send-email-tomoya.rohm@gmail.com>
	<1321848532-8784-3-git-send-email-tomoya.rohm@gmail.com>
	<20111121114524.GE3784@opensource.wolfsonmicro.com>
	<CANKRQnivyNXNZPnaUOHwpXpJz+kCz6gOwfqYNwkcOo5EpsSvZQ@mail.gmail.com>
	<20111212100513.GA5017@sirena.org.uk>
	<CANKRQng7AgKLYGSbBMbOiWifL6WNPHM=b7cB0FhfuXg74qi1Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 56F13103A7A
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 06:00:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CANKRQng7AgKLYGSbBMbOiWifL6WNPHM=b7cB0FhfuXg74qi1Fg@mail.gmail.com>
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

On Tue, Dec 13, 2011 at 01:38:25PM +0900, Tomoya MORINAGA wrote:
> 2011/12/12 Mark Brown <broonie@opensource.wolfsonmicro.com>:

> > The latter. =A0With things like this it would be *really* helpful if you
> > could take a step back and think about what the differences mean and why
> > they are different.

> Our driver needs ".pointer" method.
> However, "struct snd_soc_dai_ops" doesn't have the method.
> So, I think "struct snd_soc_dai_ops" cannot be applied to our driver.

What makes you claim this - *why* does your DAI driver need a pointer
method?

> Searching other drivers, "blackfin/bf5xx-i2s-pcm.c" uses "struct
> snd_soc_ops" not "struct snd_soc_dai_ops".
> Let me know your opinion.

Of course the DMA driver uses the ops for DMA drivers!  Alternatively if
your question above is about your DMA driver then why is your DMA driver
using DAI ops?

To repeat what I said above in a different way *please* put more effort
into understanding things and trying to solve problems for yourself, or
improving the way you ask questions.
