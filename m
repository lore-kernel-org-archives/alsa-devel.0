From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: Add GPIO support for jack
	reporting	interface
Date: Tue, 3 Mar 2009 18:42:57 +0000
Message-ID: <20090303184257.GJ27155@sirena.org.uk>
References: <2C7D3DF36ADFFC479B44490D912B616705ECD6D7C1@dlee07.ent.ti.com>
	<s5h63irp0qb.wl%tiwai@suse.de>
	<2C7D3DF36ADFFC479B44490D912B616705ECD6DB74@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 99960103823
	for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2009 19:42:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705ECD6DB74@dlee07.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 03, 2009 at 12:39:17PM -0600, Lopez Cruz, Misael wrote:

> > I prefer GPIO stuff built in conditionally.
> > The jack layer is used also for non-ASoC codes, and GPIO 
> > isn't always present.

> Is it ok if I enclose all gpio functionality with #ifdef CONFIG_GPIOLIB?

Yes, that's fine.

> > This error path doesn't look good.  It seems leaking / 
> > keeping some resources.

> Changed to:

> int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
>                         struct snd_soc_jack_gpio *gpios)
> {
> 	int i, ret;
> 
> 	for (i = 0; i < count; i++) {
> 		if (!gpio_is_valid(gpios[i].gpio)) {
> 			printk(KERN_ERR "Invalid gpio %d\n",
> 					gpios[i].gpio);
> 			return -EINVAL;
> 		}

This still leaks GPIOs and interrupts if one of these tests fails on a
GPIO after the first.
