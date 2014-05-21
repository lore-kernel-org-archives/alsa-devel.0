From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: samsung: s3c24{xx,
 12}-i2s: port to use generic dmaengine API
Date: Wed, 21 May 2014 09:42:21 +0300
Message-ID: <CA+E=qVdAuZGYZ95AQDkF_P1rU-_vEs2=qL6UtvzPXepERFZFjw@mail.gmail.com>
References: <1400617569-7187-1-git-send-email-anarsoul@gmail.com>
 <20140520221918.GI12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f172.google.com (mail-ob0-f172.google.com
 [209.85.214.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A759262634
 for <alsa-devel@alsa-project.org>; Wed, 21 May 2014 08:42:43 +0200 (CEST)
Received: by mail-ob0-f172.google.com with SMTP id wp18so1690571obc.3
 for <alsa-devel@alsa-project.org>; Tue, 20 May 2014 23:42:42 -0700 (PDT)
In-Reply-To: <20140520221918.GI12304@sirena.org.uk>
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
Cc: Sangbeom Kim <sbkim73@samsung.com>, alsa-devel@alsa-project.org, Kukjin Kim <kgene.kim@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

On Wed, May 21, 2014 at 1:19 AM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, May 20, 2014 at 11:26:08PM +0300, Vasily Khoruzhick wrote:
>> Use dmaengine instead of legacy s3c24xx DMA API for s3c24xx and s3c2412
>
> Do these depend on any other code or can they just be applied
> immediately?

For compile time everything is present, for runtime they depend on
cyclic transfers support for s3c24xx-dmac (already submitted).
Also s3c24xx machines lack a platform device DMA (one-liner, not submitted yet).

Regards
Vasily
