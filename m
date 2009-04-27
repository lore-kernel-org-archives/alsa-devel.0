From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH v2 4/4] Rename exports in mpc5200_dma.c
Date: Mon, 27 Apr 2009 16:05:10 -0400
Message-ID: <9e4733910904271305h171f5e9dybdd560ae2c22c9bf@mail.gmail.com>
References: <20090427164108.18211.44680.stgit@terra>
	<20090427164447.18211.42851.stgit@terra>
	<20090427193534.GA23567@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F8441037EE
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Apr 2009 22:05:12 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so102771qwk.56
	for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2009 13:05:10 -0700 (PDT)
In-Reply-To: <20090427193534.GA23567@rakim.wolfsonmicro.main>
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
Cc: grant.likely@secretlab.ca, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 27, 2009 at 3:35 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Apr 27, 2009 at 12:44:47PM -0400, Jon Smirl wrote:
>> Rename the public DMA exports into the global name space so that the DMA=
 code can be built as a module.
>
>> +EXPORT_SYMBOL_GPL(mpc5200_audio_dma_startup);
>> +EXPORT_SYMBOL_GPL(mpc5200_audio_dma_hw_free);
>> +EXPORT_SYMBOL_GPL(mpc5200_audio_dma_trigger);
>> +EXPORT_SYMBOL_GPL(mpc5200_audio_dma_shutdown);
>
> Why are you exporting these? =A0They should all be accessed via...

This is part of what is broken in the driver. I have later patches
that fix it but those patches are more complex.

This series is meant to be a simple mechanical transform of the driver
'as is' to make it easier to layer the successive patches on top. I
currently have twelve more patches layer on top of these four. I want
to get these code movement patches in so that we can focus on the
patches that actually fix the problems.


>
>> -struct snd_soc_platform psc_dma_pcm_soc_platform =3D {
>> +struct snd_soc_platform mpc5200_audio_dma_platform =3D {
>> =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "mpc5200-psc-audio",
>> =A0 =A0 =A0 .pcm_ops =A0 =A0 =A0 =A0=3D &psc_dma_pcm_ops,
>> =A0 =A0 =A0 .pcm_new =A0 =A0 =A0 =A0=3D &psc_dma_pcm_new,
>> =A0 =A0 =A0 .pcm_free =A0 =A0 =A0 =3D &psc_dma_pcm_free,
>> =A0};
>> -
>> +EXPORT_SYMBOL_GPL(mpc5200_audio_dma_platform);
>
> ...this unless there's a reason not to do so.
>
>> -int psc_dma_startup(struct snd_pcm_substream *substream,
>> +int mpc5200_audio_dma_startup(struct snd_pcm_substream *substream,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_soc_dai *d=
ai);
>
> These should go.
>



-- =

Jon Smirl
jonsmirl@gmail.com
