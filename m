From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] sound: constify functions in ac97
Date: Wed, 12 Jan 2011 14:44:07 +0200
Message-ID: <AANLkTi=SJpxh5h774shB+MW=xM8cyfunyJYO0deU9mCT@mail.gmail.com>
References: <201101121203.55901.hanno@hboeck.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201101121203.55901.hanno@hboeck.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Hanno_B=F6ck?= <hanno@hboeck.de>
Cc: alsa-devel@alsa-project.org, perex@perex.cz, tiwai@suse.de, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 12, 2011 at 1:03 PM, Hanno B=F6ck <hanno@hboeck.de> wrote:
> =A0struct snd_ac97_build_ops {
> - =A0 =A0 =A0 int (*build_3d) (struct snd_ac97 *ac97);
> - =A0 =A0 =A0 int (*build_specific) (struct snd_ac97 *ac97);
> - =A0 =A0 =A0 int (*build_spdif) (struct snd_ac97 *ac97);
> - =A0 =A0 =A0 int (*build_post_spdif) (struct snd_ac97 *ac97);
> + =A0 =A0 =A0 int (* const build_3d) (struct snd_ac97 *ac97);
> + =A0 =A0 =A0 int (* const build_specific) (struct snd_ac97 *ac97);
> + =A0 =A0 =A0 int (* const build_spdif) (struct snd_ac97 *ac97);
> + =A0 =A0 =A0 int (* const build_post_spdif) (struct snd_ac97 *ac97);
> =A0#ifdef CONFIG_PM
> - =A0 =A0 =A0 void (*suspend) (struct snd_ac97 *ac97);
> - =A0 =A0 =A0 void (*resume) (struct snd_ac97 *ac97);
> + =A0 =A0 =A0 void (* const suspend) (struct snd_ac97 *ac97);
> + =A0 =A0 =A0 void (* const resume) (struct snd_ac97 *ac97);
> =A0#endif
> - =A0 =A0 =A0 void (*update_jacks) (struct snd_ac97 *ac97); =A0 /* fo=
r jack-sharing */
> + =A0 =A0 =A0 /* for jack-sharing */
> + =A0 =A0 =A0 void (* const update_jacks) (struct snd_ac97 *ac97);

Can we please not do this.

You made whole ops structure RO, this is enough.
