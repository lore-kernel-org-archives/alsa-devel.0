From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v5 2/2] ASoC: sgtl5000: Fix driver probe
	after reset
Date: Fri, 10 May 2013 14:31:46 -0300
Message-ID: <CAOMZO5COocgHXsJdwO-qHcg2srg+sAPYfM0_9kds4hKCVFtqCw@mail.gmail.com>
References: <1368144947-23775-1-git-send-email-festevam@gmail.com>
 <1368144947-23775-2-git-send-email-festevam@gmail.com>
 <518C4A8E.6020501@boundarydevices.com>
 <CAOMZO5AoWqhSdH5WVu=TFgejis=8mWNGYyHneRc5idwCd8RZWA@mail.gmail.com>
 <CAKGA1bnhE3dZe8P+aJm+cps+Rp4abSGOMmPckGw_0fCnh9e6+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f173.google.com (mail-ve0-f173.google.com
 [209.85.128.173])
 by alsa0.perex.cz (Postfix) with ESMTP id B2BC8261684
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2013 19:31:47 +0200 (CEST)
Received: by mail-ve0-f173.google.com with SMTP id cy12so692632veb.32
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2013 10:31:46 -0700 (PDT)
In-Reply-To: <CAKGA1bnhE3dZe8P+aJm+cps+Rp4abSGOMmPckGw_0fCnh9e6+A@mail.gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Eric Nelson <eric.nelson@boundarydevices.com>, Troy Kisky <troy.kisky@boundarydevices.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Matt,

On Fri, May 10, 2013 at 2:14 PM, Matt Sealey <matt@genesi-usa.com> wrote:

> Hi Fabio!
>
> Is there any way to make that failure a little less of a "failure" or
> even a warning, since the message below;
>
>> sgtl5000 0-000a: Using internal LDO instead of VDDD
>
> Pretty much covers that VDDD was not supplied. I would consider that
> you would want to say "VDDD wasn't supplied" in the sense that it is
> optional and not give in pdata or dt, and then remark that the LDO was
> actually configured.. I don't like it when my kernels boot up and spit
> out high numbered errno's for the sake of a completely optional entry
> in the design vs. missing and still optional entry in the device tree.

Yes, I plan to clean the sgtl5000 log messages. I agree that it is
currently too noisy.

Will do it after Mark applies this series.

Regards,

Fabio Estevam
