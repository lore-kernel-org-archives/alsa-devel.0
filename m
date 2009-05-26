From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH V4 2/5] Main rewite of the mpc5200 audio
	DMA code
Date: Tue, 26 May 2009 10:56:03 -0600
Message-ID: <fa686aa40905260956i6fc138f8x87250ceeb8385f6f@mail.gmail.com>
References: <20090525221406.21370.30326.stgit@terra>
	<20090525221509.21370.70182.stgit@terra>
	<20090526110120.GA8969@sirena.org.uk>
	<fa686aa40905260951g5115007fo3ef5eb1fb90998f3@mail.gmail.com>
	<9e4733910905260953i6337f8a9xc3cd1ff490cd3540@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f158.google.com (mail-gx0-f158.google.com
	[209.85.217.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B6231038AA
	for <alsa-devel@alsa-project.org>;
	Tue, 26 May 2009 18:56:28 +0200 (CEST)
Received: by gxk2 with SMTP id 2so7566317gxk.8
	for <alsa-devel@alsa-project.org>; Tue, 26 May 2009 09:56:27 -0700 (PDT)
In-Reply-To: <9e4733910905260953i6337f8a9xc3cd1ff490cd3540@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, timur@freescale.com
List-Id: alsa-devel@alsa-project.org

On Tue, May 26, 2009 at 10:53 AM, Jon Smirl <jonsmirl@gmail.com> wrote:
> On Tue, May 26, 2009 at 12:51 PM, Grant Likely
> <grant.likely@secretlab.ca> wrote:
>> On Tue, May 26, 2009 at 5:01 AM, Mark Brown
>> <broonie@opensource.wolfsonmicro.com> wrote:
>>> On Mon, May 25, 2009 at 06:15:09PM -0400, Jon Smirl wrote:
>>>> Rewrite the mpc5200 audio DMA code to support both I2S and AC97.
>>>>
>>>> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
>>>
>>> Grant, I'm OK with that if you are?
>>
>> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>
> Put in the V5 version this one has this in the h file:
>
> -int psc_dma_trigger(struct snd_pcm_substream *substream, int cmd,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_soc_dai *=
dai);
> +/* whack this after Timur's patch is merged in to
> arch/powerpc/include/asm/delay.h */
> +#define spin_event_timeout(condition, timeout, delay, rc) =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 \
> +{ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 \
> + =A0 =A0 =A0 unsigned long __loops =3D tb_ticks_per_usec * timeout; =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 unsigned long __start =3D get_tbl(); =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 while ((rc =3D (condition)) && (tb_ticks_since(__start) <=
=3D __loops)) \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (delay) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(delay); =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax(); =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> +}
> +/* whack this after Timur's patch is merged in to
> arch/powerpc/include/asm/delay.h */

sure, no problem if it will grease the merge.

g.




-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
