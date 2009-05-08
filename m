From: Karl Beldan <karl.beldan@gmail.com>
Subject: Re: [PATCH 3/4] pxa2xx-i2s: Cleaner use of the FIFOs
Date: Fri, 8 May 2009 22:07:12 +0200
Message-ID: <ea2442770905081307n7ad5419hf206febab83c7931@mail.gmail.com>
References: <4A037493.5080008@gmail.com> <20090508105709.GE5654@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.172])
	by alsa0.perex.cz (Postfix) with ESMTP id 7FA87243FE
	for <alsa-devel@alsa-project.org>;
	Fri,  8 May 2009 22:07:13 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 24so1352496wfg.23
	for <alsa-devel@alsa-project.org>; Fri, 08 May 2009 13:07:12 -0700 (PDT)
In-Reply-To: <20090508105709.GE5654@sirena.org.uk>
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
Cc: Russell King <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Eric Miao <eric.miao@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Matthieu Dumont <matthieu.dumont@mobile-devices.fr>
List-Id: alsa-devel@alsa-project.org

On Fri, May 8, 2009 at 12:57 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Fri, May 08, 2009 at 01:53:55AM +0200, Karl Beldan wrote:
>
>> The FIFO logic and the registers are reset at stream startup with
>> SACR0_RST =3D> the sibling function might suffer and the FIFOs might
>> unpleasantly fill up whence the calls to pxa_i2s_wait all over the place.
>> This gets rid of it.
>
> The change to stream startup makes sense but...
>
>> @@ -256,7 +242,6 @@ static void pxa2xx_i2s_shutdown(struct snd_pcm_subst=
ream *substream,
>>
>> =A0 =A0 =A0 if ((SACR1 & (SACR1_DREC | SACR1_DRPL)) =3D=3D (SACR1_DREC |=
 SACR1_DRPL)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 SACR0 &=3D ~SACR0_ENB;
>> - =A0 =A0 =A0 =A0 =A0 =A0 pxa_i2s_wait();
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(clk_i2s);
>> =A0 =A0 =A0 }
>> =A0}
>> @@ -275,7 +260,6 @@ static int pxa2xx_i2s_suspend(struct snd_soc_dai *da=
i)
>>
>> =A0 =A0 =A0 /* deactivate link */
>> =A0 =A0 =A0 SACR0 &=3D ~SACR0_ENB;
>> - =A0 =A0 pxa_i2s_wait();
>> =A0 =A0 =A0 return 0;
>> =A0}
>
> ...there's also changes to the suspend and resume paths here which seem
> like they'd be as well not to do simply for robustness. =A0Is there any
> great reason for doing this or are you just doing it for neatness, the
> changelog isn't entirely clear?
>

The logic was crippled by this reset and the activation of both
functions each time .. at the time
I may have over overlooked that the fifo still might still need
flushing when cleaning that mess up.
One such situation I can think of right now might be when calling
snd_pcm_release_substream: it
does 'hw_free' before 'close' so pcm  won't flush cpu_dai fifo and we
end up with 'garbage' in the fifo and
one spurious irq.
Anyways being unsure of the sequence of events it might well be uncary
to get rid of these, will get back to you.
I will be able to test this monday or so.

BTW, thx for the review.


-- =

Karl
