From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/3] Revert "ASoC: wm0010: Add missing
	IRQF_ONESHOT"
Date: Tue, 7 Jul 2015 10:50:12 -0300
Message-ID: <CAOMZO5Ag9N-PsxReH7Z_0bsr-H2QRL+MYJ+z8N7tC2Pc_4z1QQ@mail.gmail.com>
References: <1435843604.17967.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f47.google.com (mail-la0-f47.google.com
 [209.85.215.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 63212265497
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 15:50:13 +0200 (CEST)
Received: by labgy5 with SMTP id gy5so43680646lab.2
 for <alsa-devel@alsa-project.org>; Tue, 07 Jul 2015 06:50:13 -0700 (PDT)
In-Reply-To: <1435843604.17967.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Michal Marek <mmarek@suse.cz>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Fengguang Wu <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 2, 2015 at 10:26 AM, Axel Lin <axel.lin@ingics.com> wrote:
> This reverts 58d468328646 ("ASoC: wm0010: Add missing IRQF_ONESHOT").
>
> The coccinelle warnings is false positive because the original code does
> set IRQF_ONESHOT by "trigger |= IRQF_ONESHOT;".
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Ops, sorry about that:

Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>
