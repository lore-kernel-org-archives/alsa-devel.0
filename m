From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v4] ASoC: sgtl5000: Fix the cache handling
Date: Mon, 26 May 2014 10:28:22 -0300
Message-ID: <CAOMZO5Aa-=SmQAJG5=9Pu7YCOo5u5bqFYMmTxbxYHEOcRb5HGQ@mail.gmail.com>
References: <1400958960-18775-1-git-send-email-festevam@gmail.com>
 <5382ECA9.1090808@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f180.google.com (mail-vc0-f180.google.com
 [209.85.220.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B01C26518B
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 15:28:23 +0200 (CEST)
Received: by mail-vc0-f180.google.com with SMTP id hy4so9122168vcb.39
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 06:28:22 -0700 (PDT)
In-Reply-To: <5382ECA9.1090808@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Shawn Guo <shawn.guo@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Mon, May 26, 2014 at 4:26 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:

> I think the issue with this chip is that it wants a special sequence in
> which the registers are written when syncing the cache to the hardware. The
> first thing to check is probably if that is actually necessary. If not just
> drop the whole restore_regs thing. If it is necessary its probably worth

Good point. After adding the missing entries into the
sgtl5000_reg_defaults[] array we can simply remove
sgtl5000_restore_regs() and suspend/resume works fine.

Thanks for the suggestion.
