From: Kukjin Kim <kgene.kim@samsung.com>
Subject: Re: [PATCHv2] ASoC: Overhaul Samsung drivers
Date: Mon, 25 Oct 2010 11:31:16 +0900
Message-ID: <017701cb73ec$b531b180$1f951480$%kim@samsung.com>
References: <1287736238-11846-1-git-send-email-jassisinghbrar@gmail.com>
	<006f01cb71f2$a0136100$e03a2300$%kim@samsung.com>
	<AANLkTinkfDERN6GX7mF-Q6XyC1zxL5SPAX1id-u4zbMy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by alsa0.perex.cz (Postfix) with ESMTP id 7AA2B1037F8
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Oct 2010 04:31:40 +0200 (CEST)
Received: from epmmp1 (mailout2.samsung.com [203.254.224.25])
	by mailout2.samsung.com
	(Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12
	2010)) with ESMTP id <0LAT00AC5QZKNW80@mailout2.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 25 Oct 2010 11:30:56 +0900 (KST)
Received: from DOKGENEKIM02 ([12.23.103.104])
	by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0LAT00J36QZJO4@mmp1.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 25 Oct 2010 11:30:56 +0900 (KST)
In-reply-to: <AANLkTinkfDERN6GX7mF-Q6XyC1zxL5SPAX1id-u4zbMy@mail.gmail.com>
Content-language: ko
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Jassi Brar' <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, 'Jassi Brar' <jassi.brar@samsung.com>, broonie@opensource.wolfsonmicro.com, mcuelenaere@gmail.com, cw00.choi@samsung.com, ben-linux@fluff.org, june.bae@samsung.com, sw.youn@samsung.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Jassi Brar wrote:
> 
> On Fri, Oct 22, 2010 at 11:08 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> >> Patches 11 through 16 apply to Kgene's tree, rest apply to
> >> Mark Brown's.
> >>
> > Hmm...
> >
> > I faced with following build error after applying above 6 patches into my
> > tree.
> > It means can't make clean tree with only arch/arm patches?...
> > NO...just need to update arch/arm/plat-samsung/include/plat/audio.h of your
> > 10/24 patch.
> > Please separate 10/24...there is no reason that to change plat/audio.h
> > belong to 10/24(Add common I2S driver)
> 
> I had initially planned to send codes via relevant trees. So, the
> plat/audio.h
> update(along with arch/ audio ) was legit to be part of I2S ASoC drivers
> update.
> The change could be atomic if sent via ASoC tree.
> 
> I can segregate the changes, if you are going prepare a branch for
> Mark to exchange
> inter-dependent patches. Will do.
> 
Thanks.
I will make 'for-broonie' which includes ARCH_S5P64X0 and GPIO updates for your patches.

> The incorrect symbol name and missing semicolon is totally my mistake.
> I sent the
> last but one version of patches by mistake. Will update soon.
> 
No prob. ;-)

> Mark,
> I am hesitant to resend 24 patches to ALSA ML with only 1 patch
> divided into two,
> but perhaps I have no other option ?
> 
Mark,

As I said, will make 'for-broonie' and merge it into my tree for -next so that you can merge its merge commit.
Then...you will not meet any conflict in your tree due to Jassi's arch/arm stuff changes.

Maybe it will be done tomorrow morning(KST)...
If any concerns or opinions, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
