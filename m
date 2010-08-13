From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5] ASoC: Remove -dai suffix from Samsung
 DAI devices
Date: Fri, 13 Aug 2010 13:29:15 +0100
Message-ID: <20100813122915.GC21528@rakim.wolfsonmicro.main>
References: <1281607342-13127-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<AANLkTinKaUygGxZc+pBg_LdOpvWcEErcf8yCvqfid5CU@mail.gmail.com>
	<4C64E2DB.5020602@samsung.com>
	<CC690F15-7FCE-4BA3-B161-DA7B1216BCC9@opensource.wolfsonmicro.com>
	<AANLkTimKpO311uc5zFyGVtUoXVetkk=f3GODyczFmkT4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 365F82454E
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Aug 2010 14:29:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTimKpO311uc5zFyGVtUoXVetkk=f3GODyczFmkT4@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seungwhan Youn <claude.youn@gmail.com>
Cc: alsa-devel@alsa-project.org, Joonyoung Shim <jy0922.shim@samsung.com>, Jassi Brar <jassisinghbrar@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, Seungwhan Youn <sw.youn@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 13, 2010 at 08:20:22PM +0900, Seungwhan Youn wrote:
> On Fri, Aug 13, 2010 at 5:59 PM, Mark Brown

> > There's no change between -i2s and -iis introduced by this patch,
> > all this patch did was strip the -dai suffix from the names. It looks
> > like this is an error in the Aquilla driver which should be corrected.

> I see. I just think that this patch modify to fix naming of i2s
> platform driver with setting corresponding arm/arch like your
> modification of 'smdk64xx_wm8580.c' in this patch. I think that aquila
> board was wrong example, but I'm afraid that other boards which was
> modified cpu_dai_name from Liam's multi-comp patches, also look
> not-correct. Because I don't know they are using platform driver on
> arch/arm, but I think that they(other machine code, like
> jive_wm8750.c) use I2S driver named 's3c24xx-iis', 's3c2412-iis' and
> 's3c64xx-iis'.

Like I say this is an orthogonal issue to this patch.

> Of course, that things can be handled another patch with another guy
> who can verify its work. But, I think that fix on this patch will be
> more nice to me.

No, one patch for one change.  With this sort of fairly wide patch it is
much easier to review if each line of the patch only does one thing so
that each change can be quickly compared against the single repetitive
change which is expected.  If multiple changes are done in the same
commit then each line needs to be thought about more to determine if the
correct set of changes are being applied in that change.
