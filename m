From: Victor Rodriguez <vm.rod25@gmail.com>
Subject: Re: [PATCH v7 3/9] davinci: ASoC support for
	Omapl138-Hawkboard
Date: Fri, 12 Nov 2010 10:39:40 -0600
Message-ID: <AANLkTinDNTOyO3sRc8zYqEnrNY5G_Y_YLW7rX9-dB9+R@mail.gmail.com>
References: <1288808115-2661-1-git-send-email-vm.rod25@gmail.com>
	<1288808115-2661-3-git-send-email-vm.rod25@gmail.com>
	<87tyjmqznr.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 155EF103989
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 17:39:40 +0100 (CET)
Received: by gyg8 with SMTP id 8so2240960gyg.38
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 08:39:40 -0800 (PST)
In-Reply-To: <87tyjmqznr.fsf@deeprootsystems.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Victor Rodriguez <victor.rodriguez@sasken.com>, Miguel Aguilar <miguel.aguilar@ridgerun.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 12, 2010 at 10:23 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> <vm.rod25@gmail.com> writes:
>
>> From: Victor Rodriguez <victor.rodriguez@sasken.com>
>>
>> This patch adds ASoC support for the Hawkboard-L138 system
>>
>> Signed-off-by: Victor Rodriguez <victor.rodriguez@sasken.com>
>
> I believe Mark Brown ack'd and earlier version of this patch.
>
> When you repost the series, you should collect any acks, sign-offs,
> tested-by etc. tags that others have reported.
>
> Mark, I assume you're OK with me merging this ASoC change via the
> davinci tree?
>
> Kevin


Sorry for that Would you like that I resend the patches again with all
the acks , sign offs and tested by tags ?


Regards

Victor Rodriguez


>> ---
>> =A0sound/soc/davinci/Kconfig =A0 =A0 =A0 | =A0 =A05 +++--
>> =A0sound/soc/davinci/davinci-evm.c | =A0 =A06 ++++--
>> =A02 files changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
>> index 6bbf001..72c6752 100644
>> --- a/sound/soc/davinci/Kconfig
>> +++ b/sound/soc/davinci/Kconfig
>> @@ -76,8 +76,9 @@ config =A0SND_DA830_SOC_EVM
>> =A0 =A0 =A0 =A0 DA830/OMAP-L137 EVM
>>
>> =A0config =A0SND_DA850_SOC_EVM
>> - =A0 =A0 tristate "SoC Audio support for DA850/OMAP-L138 EVM"
>> - =A0 =A0 depends on SND_DAVINCI_SOC && MACH_DAVINCI_DA850_EVM
>> + =A0 =A0 tristate "SoC Audio support for DA850/OMAP-L138 EVM/Hawkboard"
>> + =A0 =A0 depends on SND_DAVINCI_SOC && (MACH_DAVINCI_DA850_EVM || \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MACH_OMAPL138_HAWKBOARD)
>> =A0 =A0 =A0 select SND_DAVINCI_SOC_MCASP
>> =A0 =A0 =A0 select SND_SOC_TLV320AIC3X
>> =A0 =A0 =A0 help
>> diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci=
-evm.c
>> index 97f74d6..73093eb 100644
>> --- a/sound/soc/davinci/davinci-evm.c
>> +++ b/sound/soc/davinci/davinci-evm.c
>> @@ -59,7 +59,8 @@ static int evm_hw_params(struct snd_pcm_substream *sub=
stream,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysclk =3D 12288000;
>>
>> =A0 =A0 =A0 else if (machine_is_davinci_da830_evm() ||
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 machine_is_dav=
inci_da850_evm())
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 machine_is_dav=
inci_da850_evm() ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 machine_is_oma=
pl138_hawkboard())
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysclk =3D 24576000;
>>
>> =A0 =A0 =A0 else
>> @@ -311,7 +312,8 @@ static int __init evm_init(void)
>> =A0 =A0 =A0 } else if (machine_is_davinci_da830_evm()) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 evm_snd_dev_data =3D &da830_evm_snd_devdata;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 index =3D 1;
>> - =A0 =A0 } else if (machine_is_davinci_da850_evm()) {
>> + =A0 =A0 } else if (machine_is_davinci_da850_evm() ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 machine_is_omapl138_hawkboard(=
)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 evm_snd_dev_data =3D &da850_evm_snd_devdata;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 index =3D 0;
>> =A0 =A0 =A0 } else
>
