From: Seungwhan Youn <claude.youn@gmail.com>
Subject: Re: [PATCH] ASoC: SAMSUNG: Cleanup dependency of
	ASOC_SAMSUNG
Date: Fri, 24 Dec 2010 12:58:54 +0900
Message-ID: <AANLkTimUk7FHDfWjv2dx0SW7BPJHimOp_4EObgdHwCNU@mail.gmail.com>
References: <1293092426-31648-1-git-send-email-kgene.kim@samsung.com>
	<AANLkTikBVFTn6+qnwDEpXGMwDZPTuOt6fh1FaMmHjm+8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 22D182469C
	for <alsa-devel@alsa-project.org>; Fri, 24 Dec 2010 04:59:32 +0100 (CET)
Received: by wwe15 with SMTP id 15so6516171wwe.20
	for <alsa-devel@alsa-project.org>; Thu, 23 Dec 2010 19:59:31 -0800 (PST)
In-Reply-To: <AANLkTikBVFTn6+qnwDEpXGMwDZPTuOt6fh1FaMmHjm+8@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, Kukjin Kim <kgene.kim@samsung.com>, lrg@slimlogic.co.uk, Jassi Brar <jassi.brar@samsung.com>, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hi,

> How about having arch side Board Kconfig file define (if ASOC_SAMSUNG
> is defined)
> something like SMDK_HAS_WM8580_I2S/AC97 and these ASoC machine drivers
> depend upon them? I know Claude already has such patch ready.
> That way we could simply drop the ASOC_SAMSUNG check ?

Yes, I'm making patches that make ASoC Samsung configurations more
independent from platforms. I think that I can submit these patches
until today.
