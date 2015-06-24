From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH 2/2] ASoC: gtm601: Remove .owner field from
	platform driver
Date: Wed, 24 Jun 2015 19:46:49 +0800
Message-ID: <CAFRkauCFqyBVi2FqS2mqbM6kbyO91UULFDtx5UsCn+vai7o-eg@mail.gmail.com>
References: <1435114524.2082.1.camel@ingics.com>
 <1435114591.2082.2.camel@ingics.com>
 <20150624102354.GG14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f51.google.com (mail-la0-f51.google.com
 [209.85.215.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 07BDA260559
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2015 13:46:49 +0200 (CEST)
Received: by laka10 with SMTP id a10so24343769lak.0
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2015 04:46:49 -0700 (PDT)
In-Reply-To: <20150624102354.GG14071@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Marek Belisko <marek@goldelico.com>, Liam Girdwood <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2015-06-24 18:23 GMT+08:00 Mark Brown <broonie@kernel.org>:
> On Wed, Jun 24, 2015 at 10:56:31AM +0800, Axel Lin wrote:
>> Remove .owner field because the core will set it.
>> Also clean up the code a bit to fix indent and make soc_codec_dev_gtm601
>> const.
>
> This doesn't apply against current code, please check and resend.
It's fixed by kbuild test robot <fengguang.wu@intel.com> in topic/gtm601.
