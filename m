From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH 05/25] ASoC: pxa: remove __dev* attributes
Date: Sun, 9 Dec 2012 00:20:43 +0800
Message-ID: <CAN1soZyzNaEfmtKPoPOuLw-9ZPe4O7og5r803qOtzSf=RD2jEA@mail.gmail.com>
References: <1354890397-28568-1-git-send-email-wfp5p@virginia.edu>
 <1354890397-28568-6-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 775B426163B
 for <alsa-devel@alsa-project.org>; Sat,  8 Dec 2012 17:20:44 +0100 (CET)
Received: by mail-ee0-f51.google.com with SMTP id d4so777510eek.38
 for <alsa-devel@alsa-project.org>; Sat, 08 Dec 2012 08:20:44 -0800 (PST)
In-Reply-To: <1354890397-28568-6-git-send-email-wfp5p@virginia.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Russell King <linux@arm.linux.org.uk>, Girdwood Liam <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 7, 2012 at 10:26 PM, Bill Pemberton <wfp5p@virginia.edu> wrote:
> CONFIG_HOTPLUG is going away as an option.  As result the __dev*
> markings will be going away.
>
> Remove use of __devinit, __devexit_p, __devinitdata, __devinitconst,
> and __devexit.
>
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  sound/soc/pxa/brownstone.c     | 6 +++---
>  sound/soc/pxa/corgi.c          | 6 +++---
>  sound/soc/pxa/e740_wm9705.c    | 6 +++---
>  sound/soc/pxa/e750_wm9705.c    | 6 +++---
>  sound/soc/pxa/e800_wm9712.c    | 6 +++---
>  sound/soc/pxa/imote2.c         | 6 +++---
>  sound/soc/pxa/mioa701_wm9713.c | 6 +++---
>  sound/soc/pxa/mmp-pcm.c        | 6 +++---
>  sound/soc/pxa/mmp-sspa.c       | 6 +++---
>  sound/soc/pxa/palm27x.c        | 4 ++--
>  sound/soc/pxa/poodle.c         | 6 +++---
>  sound/soc/pxa/pxa-ssp.c        | 6 +++---
>  sound/soc/pxa/pxa2xx-ac97.c    | 8 ++++----
>  sound/soc/pxa/pxa2xx-i2s.c     | 4 ++--
>  sound/soc/pxa/pxa2xx-pcm.c     | 6 +++---
>  sound/soc/pxa/tosa.c           | 6 +++---
>  sound/soc/pxa/ttc-dkb.c        | 6 +++---
>  17 files changed, 50 insertions(+), 50 deletions(-)
>

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
