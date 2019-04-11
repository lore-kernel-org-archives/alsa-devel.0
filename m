From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH V4] ASoC: fsl_esai: Fix missing break in
 switch statement
Date: Thu, 11 Apr 2019 09:17:36 +0300
Message-ID: <CAEnQRZB4CQ=zkSRyfFeFgBSZiJVjL4K_ecrdHYMmuvc_YePmfA@mail.gmail.com>
References: <6b953e991b303a26791facbb680efe25d3cc33c3.1554951841.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E4132F89616
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2019 08:17:48 +0200 (CEST)
Received: by mail-ed1-x541.google.com with SMTP id k45so4125330edb.6
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2019 23:17:48 -0700 (PDT)
In-Reply-To: <6b953e991b303a26791facbb680efe25d3cc33c3.1554951841.git.shengjiu.wang@nxp.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "gustavo@embeddedor.com" <gustavo@embeddedor.com>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "festevam@gmail.com" <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Shengjiu,

On Thu, Apr 11, 2019 at 6:06 AM S.j. Wang <shengjiu.wang@nxp.com> wrote:
>
> case ESAI_HCKT_EXTAL and case ESAI_HCKR_EXTAL should be
> independent of each other, so replace fall-through with break.
>
> Fixes: 43d24e76b698 ("ASoC: fsl_esai: Add ESAI CPU DAI driver")
>
Since it is obvious that you will need to send v5 please remove the new line
between Fixes and Signed-off-by. This is a common practice and some tools
might depend on this to parse the Fixes tag.

> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
> Cc: <stable@vger.kernel.org>
