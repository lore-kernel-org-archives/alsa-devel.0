From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCHv2] ASoC: Overhaul Samsung drivers
Date: Mon, 25 Oct 2010 11:17:02 +0900
Message-ID: <AANLkTinkfDERN6GX7mF-Q6XyC1zxL5SPAX1id-u4zbMy@mail.gmail.com>
References: <1287736238-11846-1-git-send-email-jassisinghbrar@gmail.com>
	<006f01cb71f2$a0136100$e03a2300$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F5141037F7
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Oct 2010 04:17:03 +0200 (CEST)
Received: by bwz9 with SMTP id 9so2933101bwz.38
	for <alsa-devel@alsa-project.org>; Sun, 24 Oct 2010 19:17:02 -0700 (PDT)
In-Reply-To: <006f01cb71f2$a0136100$e03a2300$%kim@samsung.com>
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

On Fri, Oct 22, 2010 at 11:08 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>> Patches 11 through 16 apply to Kgene's tree, rest apply to
>> Mark Brown's.
>>
> Hmm...
>
> I faced with following build error after applying above 6 patches into my
> tree.
> It means can't make clean tree with only arch/arm patches?...
> NO...just need to update arch/arm/plat-samsung/include/plat/audio.h of your
> 10/24 patch.
> Please separate 10/24...there is no reason that to change plat/audio.h
> belong to 10/24(Add common I2S driver)

I had initially planned to send codes via relevant trees. So, the plat/audio.h
update(along with arch/ audio ) was legit to be part of I2S ASoC drivers update.
The change could be atomic if sent via ASoC tree.

I can segregate the changes, if you are going prepare a branch for
Mark to exchange
inter-dependent patches. Will do.

The incorrect symbol name and missing semicolon is totally my mistake.
I sent the
last but one version of patches by mistake. Will update soon.

Mark,
I am hesitant to resend 24 patches to ALSA ML with only 1 patch
divided into two,
but perhaps I have no other option ?

Thanks.
