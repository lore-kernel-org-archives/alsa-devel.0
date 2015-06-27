From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: fix AC'97 mode
Date: Sat, 27 Jun 2015 20:06:47 -0300
Message-ID: <CAOMZO5Cpgwg=7xvRm8cz8Dm6bbrLxo5Apm7y+3=Y+5Aga4e2fQ@mail.gmail.com>
References: <558F28E1.7040204@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f47.google.com (mail-la0-f47.google.com
 [209.85.215.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 90C45261A8B
 for <alsa-devel@alsa-project.org>; Sun, 28 Jun 2015 01:06:48 +0200 (CEST)
Received: by lagh6 with SMTP id h6so18258517lag.2
 for <alsa-devel@alsa-project.org>; Sat, 27 Jun 2015 16:06:48 -0700 (PDT)
In-Reply-To: <558F28E1.7040204@maciej.szmigiero.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

Hi Maciej,

On Sat, Jun 27, 2015 at 7:51 PM, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
> Currently the AC'97 mode in fsl_ssi driver isn't functional.

Thanks for the fix. I look forward to test it on my udoo board.

> This patch implements the following changes to make it work
> properly:
> * IPG clock have to be enabled during AC'97 CODEC
> register access,
> * AC'97 DAI driver struct need the same probe method as
> I2S one to setup DMA params,
> * AC'97 bus can support asymmetric playback/capture rates,
> * Check whether setting AC'97 ops succeeded and
> clean them on removal so the driver can be reloaded,
> * AC'97 CODEC will be instantiated in AC'97 mode,
> * Set DAI format function small fixes in AC'97 mode.

It seems like a lot of changes in a single patch.

Care to split it into smaller pieces?

Thanks
