From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: add wm8960 support
Date: Wed, 12 Aug 2015 09:05:25 -0300
Message-ID: <CAOMZO5CimKfu1b77cMfRhRK4YyxURuBnC2nKdaHPfvUBo9aODw@mail.gmail.com>
References: <dc4e5a52a90982cea95445e27a30f2ad6cb73513.1439349623.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f181.google.com (mail-ob0-f181.google.com
 [209.85.214.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 40B4B26044E
 for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2015 14:05:27 +0200 (CEST)
Received: by obbhe7 with SMTP id he7so10808850obb.0
 for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2015 05:05:26 -0700 (PDT)
In-Reply-To: <dc4e5a52a90982cea95445e27a30f2ad6cb73513.1439349623.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, tiwai@suse.com, Timur Tabi <timur@tabi.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 12, 2015 at 12:22 AM, Zidan Wang <zidan.wang@freescale.com> wrote:

> --- a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
> @@ -59,6 +59,8 @@ Optional properties:
>    - audio-asrc         : The phandle of ASRC. It can be absent if there's no
>                           need to add ASRC support via DPCM.
>
> +  - gpr                        : The gpr handle

This deserves a better explanation.
