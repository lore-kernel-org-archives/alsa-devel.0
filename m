From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH] Convert bitfields in ASOC into full int
	width
Date: Wed, 23 Jul 2008 11:49:50 -0400
Message-ID: <9e4733910807230849y4d9273bfk11ccf5b783a8e2d@mail.gmail.com>
References: <20080723030135.21577.69012.stgit@terra>
	<20080723103024.GA8377@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 496BE1038CB
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jul 2008 17:49:51 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so1090564ywk.2
	for <alsa-devel@alsa-project.org>; Wed, 23 Jul 2008 08:49:50 -0700 (PDT)
In-Reply-To: <20080723103024.GA8377@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 7/23/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

I found the brace problem.

>  > @@ -104,10 +104,12 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
>  >       case snd_soc_dapm_switch:
>  >       case snd_soc_dapm_mixer: {
>  >               int val;
>  > -             int reg = w->kcontrols[i].private_value & 0xff;
>  > -             int shift = (w->kcontrols[i].private_value >> 8) & 0x0f;
>  > -             int mask = (w->kcontrols[i].private_value >> 16) & 0xff;
>  > -             int invert = (w->kcontrols[i].private_value >> 24) & 0x01;
>  > +             struct mixer_control *mc = (struct mixer_control *)w->kcontrols[i].private_value;
>  > +             uint reg = mc->reg;
>  > +             uint shift = mc->shift;
>  > +             int max = mc->max;
>  > +             uint mask = (1 << fls(max)) - 1;
>  > +             uint invert = mc->invert;
>
>
> What the original code is doing here is checking to see if the control
>  is on at all.
>

Mask is usually the same as mask, but hasn't this been written to
allow a max smaller than the max? If so these two areas look wrong.

	if (widget->num_kcontrols && k) {
		struct soc_mixer_control *mc = (struct soc_mixer_control *)k->private_value;
		uint reg = mc->reg;
		uint shift = mc->shift;
		int max = mc->max;
		uint mask = (1 << fls(max)) - 1;
		uint invert = mc->invert;

		if (power) {
			int i;
			/* power up has happended, increase volume to last level */
			if (invert) {
// shouldn't this be
//				for (i = max; i > widget->saved_value; i--)
				for (i = mask; i > widget->saved_value; i--)
// and this mask is right
					snd_soc_update_bits(widget->codec, reg, mask, i);
			} else {
				for (i = 0; i < widget->saved_value; i++)
					snd_soc_update_bits(widget->codec, reg, mask, i);
			}

And this one should have used mask instead of max:

	case snd_soc_dapm_mixer: {
		int val;
		struct soc_mixer_control *mc = (struct soc_mixer_control
*)w->kcontrols[i].private_value;
		uint reg = mc->reg;
		uint shift = mc->shift;
		int max = mc->max;
		uint mask = (1 << fls(max)) - 1;
		uint invert = mc->invert;

		val = snd_soc_read(w->codec, reg);
		val = (val >> shift) & mask;

		if ((invert && !val) || (!invert && val))
			p->connect = 1;
		else
			p->connect = 0;


-- 
Jon Smirl
jonsmirl@gmail.com
