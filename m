From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: Re: [PATCH] ASoC: Add GPIO support for jack
	reporting	interface
Date: Tue, 3 Mar 2009 12:54:31 -0600
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705ECD6DBB1@dlee07.ent.ti.com>
References: <2C7D3DF36ADFFC479B44490D912B616705ECD6D7C1@dlee07.ent.ti.com>
	<s5h63irp0qb.wl%tiwai@suse.de>
	<2C7D3DF36ADFFC479B44490D912B616705ECD6DB74@dlee07.ent.ti.com>
	<20090303184257.GJ27155@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B747103823
	for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2009 19:54:48 +0100 (CET)
In-Reply-To: <20090303184257.GJ27155@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


> > > This error path doesn't look good.  It seems leaking / 
> > > keeping some resources.

> > Changed to:
> > int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
> >                         struct snd_soc_jack_gpio *gpios)
> > {
> > 	int i, ret;
> > 
> > 	for (i = 0; i < count; i++) {
> > 		if (!gpio_is_valid(gpios[i].gpio)) {
> > 			printk(KERN_ERR "Invalid gpio %d\n",
> > 					gpios[i].gpio);
> > 			return -EINVAL;
> > 		}

> This still leaks GPIOs and interrupts if one of these tests fails on a
> GPIO after the first.

I was thinking more in that machine drivers could handle the returned
error, for example, calling snd_soc_jack_free_gpios.

ret = snd_soc_jack_add_gpios(jack, ARRAY_SIZE(my_array), my_array);
if (ret) {
	snd_soc_jack_free_gpios(jack, ARRAY_SIZE(my_array), my_array);
	return ret;
}

But if snd_soc_jack_add_gpios() has to take care of it, then I'll
add that.
