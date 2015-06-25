From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH 2/2] ASoC: gtm601: Remove .owner field from
	platform driver
Date: Thu, 25 Jun 2015 16:42:42 +0800
Message-ID: <CAFRkauDNEDFNVJQg+=Z=0RSKRSwEfG7QaLkA4-nd3L=6fmA5ig@mail.gmail.com>
References: <1435114524.2082.1.camel@ingics.com>
 <1435114591.2082.2.camel@ingics.com>
 <20150624102354.GG14071@sirena.org.uk>
 <CAFRkauCFqyBVi2FqS2mqbM6kbyO91UULFDtx5UsCn+vai7o-eg@mail.gmail.com>
 <20150624115048.GJ14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f169.google.com (mail-lb0-f169.google.com
 [209.85.217.169])
 by alsa0.perex.cz (Postfix) with ESMTP id B1637260464
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2015 10:42:43 +0200 (CEST)
Received: by lbbpo10 with SMTP id po10so41042705lbb.3
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2015 01:42:43 -0700 (PDT)
In-Reply-To: <20150624115048.GJ14071@sirena.org.uk>
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

2015-06-24 19:50 GMT+08:00 Mark Brown <broonie@kernel.org>:
> On Wed, Jun 24, 2015 at 07:46:49PM +0800, Axel Lin wrote:
>> 2015-06-24 18:23 GMT+08:00 Mark Brown <broonie@kernel.org>:
>
>> > This doesn't apply against current code, please check and resend.
>
>> It's fixed by kbuild test robot <fengguang.wu@intel.com> in topic/gtm601.
>
> The main bit is but it looked like you had some other changes which are
> probably still worthwhile?

The sound/soc/codecs/gtm601.c does not exist in today's linux-next tree.
I'll check the code again once it appears on linux-next.
