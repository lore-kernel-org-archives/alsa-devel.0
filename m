From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Allow passing platform_data to
	devices	attached to AC97 bus
Date: Tue, 21 Jul 2009 19:30:56 +0100
Message-ID: <20090721183056.GB28955@sirena.org.uk>
References: <200907211633.14388.marek.vasut@gmail.com>
	<20090721145323.GA8991@rakim.wolfsonmicro.main>
	<s5hd47u2hjc.wl%tiwai@suse.de>
	<200907211740.01287.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 936A5103869
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jul 2009 20:30:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200907211740.01287.marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 21, 2009 at 05:40:01PM +0200, Marek Vasut wrote:
> Dne ??t 21. ??ervence 2009 17:16:07 Takashi Iwai napsal(a):

> +/* AC97 platform_data adding function */
> +inline void snd_ac97_dev_add_pdata(struct snd_ac97 *ac97, void *data);
> +

I think Takashi asked for this to be done as an inline?  I tend to agree
with him.
