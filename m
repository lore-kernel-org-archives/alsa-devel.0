From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [RFC] ASoC: sgtl5000: Remove cache support
Date: Tue, 07 May 2013 17:57:50 -0700
Message-ID: <5189A30E.10208@boundarydevices.com>
References: <1367610549-25542-1-git-send-email-festevam@gmail.com>
 <20130503223613.GR4945@sirena.org.uk>
 <CAOMZO5B84e0YdcJLa27e4KZv459CGL=msU0fqe4LyFZfM-t1+A@mail.gmail.com>
 <CAOMZO5BG-3SKZF_ZrQ=C51nLvKYSNJEgy-KavzBXJcb=fCk=iA@mail.gmail.com>
 <20130505101515.GT4945@sirena.org.uk>
 <CAKGA1bmKdtAoUP7Yn0CJRVwsCNX5JkEWdWVJj1VJBaJn+9PA=A@mail.gmail.com>
 <20130506220650.GJ7478@sirena.org.uk>
 <CAKGA1b=+j5BpHzWOfkDv+xjLLcauHeD4jDj_Do+6ft6UPhYEtA@mail.gmail.com>
 <CAOMZO5D_EeUDPmDNUxgqU-8sLMcESAR=8b16KNk0Wz-WkX77hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f41.google.com (mail-pb0-f41.google.com
 [209.85.160.41])
 by alsa0.perex.cz (Postfix) with ESMTP id B6EC1261A1D
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2013 02:57:53 +0200 (CEST)
Received: by mail-pb0-f41.google.com with SMTP id mc17so810784pbc.0
 for <alsa-devel@alsa-project.org>; Tue, 07 May 2013 17:57:52 -0700 (PDT)
In-Reply-To: <CAOMZO5D_EeUDPmDNUxgqU-8sLMcESAR=8b16KNk0Wz-WkX77hQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Matt Sealey <matt@genesi-usa.com>, Eric Nelson <eric.nelson@boundarydevices.com>, Mark Brown <broonie@kernel.org>, "zengzm.kernel" <zengzm.kernel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 5/7/2013 4:26 PM, Fabio Estevam wrote:
> On Tue, May 7, 2013 at 5:06 PM, Matt Sealey <matt@genesi-usa.com> wrote:
>
>> Right, and in theory - I can't find an example of anyone implementing
>> VDDD as unconnected - if you float VDDD then the SGTL5000 will start
> Actually I can't find see anyone that implemented VDDD connected, except Efika.
>
> All these boards have sgtl5000 VDDD unconnected:
> mx51evk, mx28evk, mx53smd, mx35pdk, mx25pdk.
>
> mx6qsabrelite connects VDD to GND.
> .
>
Sabrelite connects VDD to a cap only.

Troy
