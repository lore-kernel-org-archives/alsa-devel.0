From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC] ASoC: sgtl5000: Remove cache support
Date: Tue, 7 May 2013 20:26:57 -0300
Message-ID: <CAOMZO5D_EeUDPmDNUxgqU-8sLMcESAR=8b16KNk0Wz-WkX77hQ@mail.gmail.com>
References: <1367610549-25542-1-git-send-email-festevam@gmail.com>
 <20130503223613.GR4945@sirena.org.uk>
 <CAOMZO5B84e0YdcJLa27e4KZv459CGL=msU0fqe4LyFZfM-t1+A@mail.gmail.com>
 <CAOMZO5BG-3SKZF_ZrQ=C51nLvKYSNJEgy-KavzBXJcb=fCk=iA@mail.gmail.com>
 <20130505101515.GT4945@sirena.org.uk>
 <CAKGA1bmKdtAoUP7Yn0CJRVwsCNX5JkEWdWVJj1VJBaJn+9PA=A@mail.gmail.com>
 <20130506220650.GJ7478@sirena.org.uk>
 <CAKGA1b=+j5BpHzWOfkDv+xjLLcauHeD4jDj_Do+6ft6UPhYEtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f172.google.com (mail-vc0-f172.google.com
 [209.85.220.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 00CF226510C
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2013 01:26:57 +0200 (CEST)
Received: by mail-vc0-f172.google.com with SMTP id m17so1121392vca.31
 for <alsa-devel@alsa-project.org>; Tue, 07 May 2013 16:26:57 -0700 (PDT)
In-Reply-To: <CAKGA1b=+j5BpHzWOfkDv+xjLLcauHeD4jDj_Do+6ft6UPhYEtA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Sealey <matt@genesi-usa.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Eric Nelson <eric.nelson@boundarydevices.com>, "troy.kisky" <troy.kisky@boundarydevices.com>, Mark Brown <broonie@kernel.org>, "zengzm.kernel" <zengzm.kernel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, May 7, 2013 at 5:06 PM, Matt Sealey <matt@genesi-usa.com> wrote:

> Right, and in theory - I can't find an example of anyone implementing
> VDDD as unconnected - if you float VDDD then the SGTL5000 will start

Actually I can't find see anyone that implemented VDDD connected, except Efika.

All these boards have sgtl5000 VDDD unconnected:
mx51evk, mx28evk, mx53smd, mx35pdk, mx25pdk.

mx6qsabrelite connects VDD to GND.
