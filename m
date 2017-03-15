From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] ASoC: tas2552: Improve DT binding document
	example
Date: Wed, 15 Mar 2017 09:48:18 -0500
Message-ID: <CAL_JsqL3tP=x+ATn6thfEi38+zsAGCZ2mSPuyFmn3-qEsYa5kg@mail.gmail.com>
References: <1489434963-2843-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 89E7E266861
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 15:48:43 +0100 (CET)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id 30BAA20457
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 14:48:40 +0000 (UTC)
Received: from mail-ua0-f175.google.com (mail-ua0-f175.google.com
 [209.85.217.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3D4DA202E9
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 14:48:39 +0000 (UTC)
Received: by mail-ua0-f175.google.com with SMTP id u30so10593457uau.0
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 07:48:39 -0700 (PDT)
In-Reply-To: <1489434963-2843-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, dmurphy@ti.com
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 13, 2017 at 2:56 PM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
>
> Improve DT binding document example by providing the mandatory
> regulator properties.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/tas2552.txt | 3 +++
>  1 file changed, 3 insertions(+)

This needs to go to the DT list, but is trivial enough, so

Acked-by: Rob Herring <robh@kernel.org>
