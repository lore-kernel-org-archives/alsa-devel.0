From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH 3/3] Revert "ASoC: wm8996: Pass the
	IRQF_ONESHOT flag"
Date: Thu, 9 Jul 2015 09:52:23 +0800
Message-ID: <CAFRkauBW5UySoHCt10S9uN8SLqzp_CE4BqtsdNS-W8yUKDRQ5g@mail.gmail.com>
References: <1435843604.17967.1.camel@ingics.com>
 <1435843741.17967.3.camel@ingics.com>
 <20150708183422.GY11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f53.google.com (mail-la0-f53.google.com
 [209.85.215.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 873FC265B54
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2015 03:52:24 +0200 (CEST)
Received: by lagx9 with SMTP id x9so236756114lag.1
 for <alsa-devel@alsa-project.org>; Wed, 08 Jul 2015 18:52:24 -0700 (PDT)
In-Reply-To: <20150708183422.GY11162@sirena.org.uk>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Michal Marek <mmarek@suse.cz>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Fengguang Wu <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

2015-07-09 2:34 GMT+08:00 Mark Brown <broonie@kernel.org>:
> On Thu, Jul 02, 2015 at 09:29:01PM +0800, Axel Lin wrote:
>> This reverts ed043aebe6ec ("ASoC: wm8996: Pass the IRQF_ONESHOT flag").
>
> Please use subject lines reflecting the style for the subsystem, even
> for reverts.

I don't get it.
I thought if a patch is actually a revert, it should look like a revert.
So I generate the patch by "git revert". Is that wrong?
