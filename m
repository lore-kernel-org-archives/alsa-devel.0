From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH V1 09/13] Main rewite of the mpc5200 audio
	DMA code
Date: Thu, 14 May 2009 10:50:42 -0400
Message-ID: <9e4733910905140750g210616f6re53b731b51bf51e8@mail.gmail.com>
References: <20090514015729.28145.30483.stgit@terra>
	<20090514015918.28145.19103.stgit@terra>
	<20090514105131.GG28291@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 91CA21039AB
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 16:50:44 +0200 (CEST)
Received: by qyk1 with SMTP id 1so2383301qyk.16
	for <alsa-devel@alsa-project.org>; Thu, 14 May 2009 07:50:42 -0700 (PDT)
In-Reply-To: <20090514105131.GG28291@sirena.org.uk>
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

On Thu, May 14, 2009 at 6:51 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, May 13, 2009 at 09:59:18PM -0400, Jon Smirl wrote:
>
>> -static const struct snd_pcm_hardware psc_dma_pcm_hardware =3D {
>> +static const struct snd_pcm_hardware psc_dma_hardware =3D {
>> =A0 =A0 =A0 .info =3D SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_=
BLOCK_TRANSFER |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 SNDRV_PCM_INFO_BATCH,
>> - =A0 =A0 .formats =3D SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_BE |
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SNDRV_PCM_FMTBIT_S24_BE | SNDRV_PCM_FMT=
BIT_S32_BE,
>> + =A0 =A0 .formats =3D SNDRV_PCM_FMTBIT_S32_BE,
>
> This seems like a major and very surprising reduction in functionality.
> Why is this required?

I think I did this backwards. The AC97 DAI should be
SNDRV_PCM_FMTBIT_S32_BE only and the DMA engine allow all four.

-- =

Jon Smirl
jonsmirl@gmail.com
