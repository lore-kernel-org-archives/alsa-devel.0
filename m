From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH] of: add empty of_find_node_by_path() for
	!OF
Date: Wed, 16 Apr 2014 07:26:13 -0500
Message-ID: <CAL_Jsq+MtkQcKs06xggrZkQHncSCBx6ABCaiud8HokEgAX2NMA@mail.gmail.com>
References: <1397630960-26677-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f178.google.com (mail-vc0-f178.google.com
 [209.85.220.178])
 by alsa0.perex.cz (Postfix) with ESMTP id E130626525F
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 14:26:15 +0200 (CEST)
Received: by mail-vc0-f178.google.com with SMTP id im17so10566958vcb.37
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 05:26:14 -0700 (PDT)
In-Reply-To: <1397630960-26677-1-git-send-email-shc_work@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Timur Tabi <timur@tabi.org>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Grant Likely <grant.likely@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 16, 2014 at 1:49 AM, Alexander Shiyan <shc_work@mail.ru> wrote:
> Add an empty version of of_find_node_by_path().
> This fixes following build error for asoc tree:
> sound/soc/fsl/fsl_ssi.c: In function 'fsl_ssi_probe':
> sound/soc/fsl/fsl_ssi.c:1471:2: error: implicit declaration of function 'of_find_node_by_path' [-Werror=implicit-function-declaration]
>   sprop = of_get_property(of_find_node_by_path("/"), "compatible", NULL);
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied.

Rob
