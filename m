From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: samsung: s3c24{xx,
 12}-i2s: port to use generic dmaengine API
Date: Wed, 21 May 2014 13:53:44 +0300
Message-ID: <CA+E=qVftftP7eBDGph+RkrE7aVAh28OvQr1Tp_8rjmcLYUkmVQ@mail.gmail.com>
References: <1400617569-7187-1-git-send-email-anarsoul@gmail.com>
 <20140520221918.GI12304@sirena.org.uk>
 <CA+E=qVdAuZGYZ95AQDkF_P1rU-_vEs2=qL6UtvzPXepERFZFjw@mail.gmail.com>
 <20140521104901.GO12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 26623261A3D
 for <alsa-devel@alsa-project.org>; Wed, 21 May 2014 12:54:06 +0200 (CEST)
Received: by mail-ob0-f179.google.com with SMTP id vb8so1959246obc.10
 for <alsa-devel@alsa-project.org>; Wed, 21 May 2014 03:54:05 -0700 (PDT)
In-Reply-To: <20140521104901.GO12304@sirena.org.uk>
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

On Wed, May 21, 2014 at 1:49 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, May 21, 2014 at 09:42:21AM +0300, Vasily Khoruzhick wrote:
>> On Wed, May 21, 2014 at 1:19 AM, Mark Brown <broonie@kernel.org> wrote:
>> > On Tue, May 20, 2014 at 11:26:08PM +0300, Vasily Khoruzhick wrote:
>> >> Use dmaengine instead of legacy s3c24xx DMA API for s3c24xx and s3c2412
>
>> > Do these depend on any other code or can they just be applied
>> > immediately?
>
>> For compile time everything is present, for runtime they depend on
>> cyclic transfers support for s3c24xx-dmac (already submitted).
>> Also s3c24xx machines lack a platform device DMA (one-liner, not submitted yet).
>
> OK, in that case I think it might be better to hold off until either the
> DMA patches are merged or after the merge window (should be very soon)
> so that the driver still works in v3.16 - does that seem sensible?  The
> changes look OK, just a question of getting them merged safely.

Mark, legacy dma does not work for me as for 3.14, tried on h1940
(s3c2410) and on rx1950 (s3c2442).
So merging them won't break anything, it's already broken.

Regards
Vasily
