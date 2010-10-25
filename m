From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCHv2] ASoC: Overhaul Samsung drivers
Date: Mon, 25 Oct 2010 16:20:49 +0900
Message-ID: <AANLkTimopkERs2AJZyXBpZdmssQGFDvk5BJMf3W_3QGR@mail.gmail.com>
References: <1287736238-11846-1-git-send-email-jassisinghbrar@gmail.com>
	<006f01cb71f2$a0136100$e03a2300$%kim@samsung.com>
	<AANLkTinkfDERN6GX7mF-Q6XyC1zxL5SPAX1id-u4zbMy@mail.gmail.com>
	<017701cb73ec$b531b180$1f951480$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B63F103879
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Oct 2010 09:20:52 +0200 (CEST)
Received: by bwz9 with SMTP id 9so3052780bwz.38
	for <alsa-devel@alsa-project.org>; Mon, 25 Oct 2010 00:20:49 -0700 (PDT)
In-Reply-To: <017701cb73ec$b531b180$1f951480$%kim@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassi.brar@samsung.com>, broonie@opensource.wolfsonmicro.com, mcuelenaere@gmail.com, cw00.choi@samsung.com, ben-linux@fluff.org, june.bae@samsung.com, sw.youn@samsung.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 25, 2010 at 11:31 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:

>> I can segregate the changes, if you are going prepare a branch for
>> Mark to exchange
>> inter-dependent patches. Will do.
>>
> Thanks.
> I will make 'for-broonie' which includes ARCH_S5P64X0 and GPIO updates for your patches.

OK, I have prepared following patches for Kgene's tree. Upon which
patches for Mark's tree depend.


For Kgene:-
************
    S5PV310: DMA: Add platform devices for PL330 DMACs
    ARM: Samsung: Rename s3c64xx I2S platform device
    ARM: Samsung: Prepare audio header for new I2S driver
    ARM: S3C64XX: I2S: Upgrade platform device
    ARM: S5P64X0: I2S: Upgrade platform device
    ARM: S5P6442: I2S: Upgrade platform device
    ARM: S5PC100: I2S: Upgrade platform device
    ARM: S5PV210: I2S: Upgrade platform device
    ARM: S5PV310: Add audio platform devices


For Mark :-
***********
   ASoC: Samsung: Remove redundant AQUILA driver
    ASoC: Samsung: Rename DMA device
    ARM: Samsung: Define common audio-dma device
    ASoC: Samsung: Rename ASoC DMA driver
    ASoC: Samsung: Rename AC97 platform device
    ASoC: Samsung: Rename AC97 driver
    ASoC: Samsung: Rename PCM driver
    ASoC: Samsung: Generalize DMA driver namespace
    ASoC: Samsung: Rename s3c64xx I2S device
    ASoC: Samsung: Add common I2S driver
    ASoC: SMARTQ: Move to use new I2S driver
    ASoC: GONI: Move to use new I2S driver
    ASoC: SMDK64XX: Move to use new I2S driver
    ASoC: S3C64XX: Remove obsoleted I2S drivers
    ASoC: SMDK64XX: Rename for other platforms
    ASoC: SMDK_WM8580: Enable for SMDKC100
    ASoC: Samsung: Generalize Kconfig symbols
    ASoC: Samsung: Rename from s3c24xx to samsung

If anyone disagrees with the approach, please let me know before I flood the
mailing lists with these patches.
