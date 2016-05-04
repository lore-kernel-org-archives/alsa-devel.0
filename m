From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Allow the SAI driver to
	turn on SAI_MCLK
Date: Wed, 4 May 2016 14:41:26 -0300
Message-ID: <CAOMZO5Bc4Jz12sRPPWUB0p-m17SFaJWHZN6p2iW8uN=6Ddp=1A@mail.gmail.com>
References: <1462324173-10976-1-git-send-email-festevam@gmail.com>
 <20160504014432.GA30210@Asurada-Nvidia>
 <CAOMZO5AkctauuaR1DTKexBo4wL=aZL_JLi4nudeZXHTRRo0QMQ@mail.gmail.com>
 <20160504070700.GA12216@Asurada>
 <CAOMZO5CX5t4H5qVpB+e6tbEGgPR+nStArKuEtk+D0QapyzfOGA@mail.gmail.com>
 <20160504172946.GA32452@Asurada-Nvidia>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f181.google.com (mail-io0-f181.google.com
 [209.85.223.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 50F8F2664B3
 for <alsa-devel@alsa-project.org>; Wed,  4 May 2016 19:41:27 +0200 (CEST)
Received: by mail-io0-f181.google.com with SMTP id 190so61663271iow.1
 for <alsa-devel@alsa-project.org>; Wed, 04 May 2016 10:41:27 -0700 (PDT)
In-Reply-To: <20160504172946.GA32452@Asurada-Nvidia>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Petr Kulhavy <brain@jikos.cz>
List-Id: alsa-devel@alsa-project.org

Hi Nicolin,

On Wed, May 4, 2016 at 2:29 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:

> I have already described the difference between set and clear is
> not this simple. Honestly, without reading Zidan's mail above,
> I would suggest to set all three bits for SAIs in mach-imx6ul.c

I think Shawn was against this idea.

> I understand you want to get this in as soon as possible, that's why
> I said I can ignore the place of implementation as long as the name
> of the DT property won't create confusion for input clock feature.
> So why not just use the name as itself -- direction?

Would you be happy if I do a v2 that uses a property like:

fsl,sai-mclk-direction = <1>;

Thanks
