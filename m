From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Re: [PATCH 3/3] sound/soc/lapis: add platform driver
Date: Tue, 13 Dec 2011 13:38:25 +0900
Message-ID: <CANKRQng7AgKLYGSbBMbOiWifL6WNPHM=b7cB0FhfuXg74qi1Fg@mail.gmail.com>
References: <1321848532-8784-1-git-send-email-tomoya.rohm@gmail.com>
	<1321848532-8784-3-git-send-email-tomoya.rohm@gmail.com>
	<20111121114524.GE3784@opensource.wolfsonmicro.com>
	<CANKRQnivyNXNZPnaUOHwpXpJz+kCz6gOwfqYNwkcOo5EpsSvZQ@mail.gmail.com>
	<20111212100513.GA5017@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 66FD0103A7A
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 05:38:27 +0100 (CET)
Received: by dajy12 with SMTP id y12so6009190daj.38
	for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2011 20:38:26 -0800 (PST)
In-Reply-To: <20111212100513.GA5017@sirena.org.uk>
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>, qi.wang@intel.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, yong.y.wang@intel.com, kok.howg.ewe@intel.com, Daniel Mack <zonque@gmail.com>, Liam Girdwood <lrg@ti.com>, joel.clark@intel.com
List-Id: alsa-devel@alsa-project.org

2011/12/12 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Mon, Dec 12, 2011 at 05:28:13PM +0900, Tomoya MORINAGA wrote:
>
>> struct snd_soc_ops {
>> ...
>> };
>
>> On the other hand, tegra_i2s.c describes like below.
>
>> static const struct snd_soc_dai_ops tegra_i2s_dai_ops =3D {
>> ...
>> };
>
>> Which is true as modern driver ? or case by case ?
>
> The latter. =A0With things like this it would be *really* helpful if you
> could take a step back and think about what the differences mean and why
> they are different.

Our driver needs ".pointer" method.
However, "struct snd_soc_dai_ops" doesn't have the method.
So, I think "struct snd_soc_dai_ops" cannot be applied to our driver.
Searching other drivers, "blackfin/bf5xx-i2s-pcm.c" uses "struct
snd_soc_ops" not "struct snd_soc_dai_ops".
Let me know your opinion.

Thanks,

tomoya
