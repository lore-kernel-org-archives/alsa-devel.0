Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE8EC001DE
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Aug 2023 07:34:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E480D832;
	Wed,  2 Aug 2023 09:33:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E480D832
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690961638;
	bh=3NnkK3G4HM7rMbc+66KBMrzuPE2JfbxnUt+ATRDK3Oc=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=VDHCwbV25Ro49o4rAPzbIdinxcChEvoDKlRiyvfYqHq+wQGc1olyTTRLXMTF1RGMJ
	 78SCoxcGxI9G/mWcwuEXwVANpH2/sMvV6DLffkSN0zJSM6pQMlQgDR7RZ3x9MmcIWl
	 dFmbf5zITQwrOUBwf7pFUGr79nPlW6HwPe/5n3Us=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AD0A1F80520; Wed,  2 Aug 2023 09:33:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2FFF5F801D5;
	Wed,  2 Aug 2023 09:33:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 93586F8053B; Wed,  2 Aug 2023 09:32:54 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3054EF8025A
	for <alsa-devel@alsa-project.org>; Wed,  2 Aug 2023 09:32:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3054EF8025A
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id BB4D06183D;
	Wed,  2 Aug 2023 07:32:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D1AC433C7;
	Wed,  2 Aug 2023 07:32:38 +0000 (UTC)
Message-ID: <47d66c28-1eb2-07f5-d6f9-779d675aefe8@xs4all.nl>
Date: Wed, 2 Aug 2023 09:32:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH v2 0/7] Add audio support in v4l2 framework
Content-Language: en-US
To: Shengjiu Wang <shengjiu.wang@nxp.com>, sakari.ailus@iki.fi,
 tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org
References: <1690265540-25999-1-git-send-email-shengjiu.wang@nxp.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <1690265540-25999-1-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: MRKSGJOBT6OQ7DB6DS4B7ZZIQCAY33LF
X-Message-ID-Hash: MRKSGJOBT6OQ7DB6DS4B7ZZIQCAY33LF
X-MailFrom: SRS0=Vcmq=DT=xs4all.nl=hverkuil@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MRKSGJOBT6OQ7DB6DS4B7ZZIQCAY33LF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi all,

On 25/07/2023 08:12, Shengjiu Wang wrote:
> Audio signal processing has the requirement for memory to
> memory similar as Video.
> 
> This patch is to add this support in v4l2 framework, defined
> new buffer type V4L2_BUF_TYPE_AUDIO_CAPTURE and
> V4L2_BUF_TYPE_AUDIO_OUTPUT, defined new format v4l2_audio_format
> for audio case usage.
> 
> The created audio device is named "/dev/audioX".
> 
> And add memory to memory support for two kinds of i.MX ASRC
> module

Before I spend time on this: are the audio maintainers OK with doing
this in V4L2?

I do want to have a clear statement on this as it is not something I
can decide.

Regards,

	Hans

> 
> changes in v2:
> - decouple the implementation in v4l2 and ALSA
> - implement the memory to memory driver as a platfrom driver
>   and move it to driver/media
> - move fsl_asrc_common.h to include/sound folder
> 
> Shengjiu Wang (7):
>   ASoC: fsl_asrc: define functions for memory to memory usage
>   ASoC: fsl_easrc: define functions for memory to memory usage
>   ASoC: fsl_asrc: move fsl_asrc_common.h to include/sound
>   media: v4l2: Add audio capture and output support
>   media: imx: fsl_asrc: Add memory to memory driver
>   ASoC: fsl_asrc: register m2m platform device
>   ASoC: fsl_easrc: register m2m platform device
> 
>  .../media/common/videobuf2/videobuf2-v4l2.c   |   4 +
>  drivers/media/platform/nxp/Kconfig            |  12 +
>  drivers/media/platform/nxp/Makefile           |   1 +
>  drivers/media/platform/nxp/fsl_asrc_m2m.c     | 962 ++++++++++++++++++
>  drivers/media/v4l2-core/v4l2-dev.c            |  17 +
>  drivers/media/v4l2-core/v4l2-ioctl.c          |  52 +
>  include/media/v4l2-dev.h                      |   2 +
>  include/media/v4l2-ioctl.h                    |  34 +
>  .../fsl => include/sound}/fsl_asrc_common.h   |  48 +
>  include/uapi/linux/videodev2.h                |  19 +
>  sound/soc/fsl/fsl_asrc.c                      | 150 +++
>  sound/soc/fsl/fsl_asrc.h                      |   4 +-
>  sound/soc/fsl/fsl_asrc_dma.c                  |   2 +-
>  sound/soc/fsl/fsl_easrc.c                     | 227 +++++
>  sound/soc/fsl/fsl_easrc.h                     |   8 +-
>  15 files changed, 1539 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/media/platform/nxp/fsl_asrc_m2m.c
>  rename {sound/soc/fsl => include/sound}/fsl_asrc_common.h (63%)
> 

