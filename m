From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/2] Add initial support of Mitac
	mioa701	master volume.
Date: Thu, 8 Jan 2009 20:46:31 +0000
Message-ID: <20090108204630.GC29183@sirena.org.uk>
References: <1231440146-6669-1-git-send-email-robert.jarzmik@free.fr>
	<1231440146-6669-2-git-send-email-robert.jarzmik@free.fr>
	<1231440146-6669-3-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 80CC1243C2
	for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2009 21:46:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1231440146-6669-3-git-send-email-robert.jarzmik@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 08, 2009 at 07:42:26PM +0100, Robert Jarzmik wrote:

> Depending on the "Mio Mode" chosen, the master volume
> controls the widget volume/mute levels, providing userspace
> a unified vision of volume control (one control only).

I've not got time to review this properly tonight so I'll just say that
the comments about scenario stuff in my previous mail apply here - if we
want to do this in kernel it's worth lifting out the generic bits of
code so that other machine drivers don't end up implementing the same
stuff again.

> The master volume is adapted to smartphones because :

...

>  - it abstracts to userland audiopath within the chip

Yeah, applications should really be able to see such an abstraction -
it'd make them work a lot better with ASoC cards.

The main concern with doing it in drivers specifically is that this
means the driver needs to know about all the possible scenarios which
gets hard when the user can run their own programs and think up their
own use cases.  It also makes configuring scenarios a bit harder since
you can't tweak the paths with alsamixer so easily, though that's
solvable.

> +static struct snd_kcontrol *kctrl_byname(struct snd_soc_codec *codec, char *n)
> +{
> +	struct snd_ctl_elem_id rid;
> +
> +	memset(&rid, 0, sizeof(rid));
> +	rid.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
> +	strncpy(rid.name, n, sizeof(rid.name));
> +	return snd_ctl_find_id(codec->card, &rid);
> +}

I'm fairly sure you had the same thing in your machine driver -
definitely worth abstracting regardless of anything else (probably even
worth putting a version in ALSA core, I guess).
