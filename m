From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Allow the SAI driver to
	turn on SAI_MCLK
Date: Wed, 4 May 2016 10:55:02 -0700
Message-ID: <20160504175502.GA32593@Asurada-Nvidia>
References: <1462324173-10976-1-git-send-email-festevam@gmail.com>
 <20160504014432.GA30210@Asurada-Nvidia>
 <CAOMZO5AkctauuaR1DTKexBo4wL=aZL_JLi4nudeZXHTRRo0QMQ@mail.gmail.com>
 <20160504070700.GA12216@Asurada>
 <CAOMZO5CX5t4H5qVpB+e6tbEGgPR+nStArKuEtk+D0QapyzfOGA@mail.gmail.com>
 <20160504172946.GA32452@Asurada-Nvidia>
 <CAOMZO5Bc4Jz12sRPPWUB0p-m17SFaJWHZN6p2iW8uN=6Ddp=1A@mail.gmail.com>
 <CAOMZO5C-iaHzt1SUTydzQkUYcOnfx8bbXma1hcs4Z1LHLXfkwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f181.google.com (mail-pf0-f181.google.com
 [209.85.192.181])
 by alsa0.perex.cz (Postfix) with ESMTP id F266A26651C
 for <alsa-devel@alsa-project.org>; Wed,  4 May 2016 19:54:58 +0200 (CEST)
Received: by mail-pf0-f181.google.com with SMTP id 77so27661119pfv.2
 for <alsa-devel@alsa-project.org>; Wed, 04 May 2016 10:54:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOMZO5C-iaHzt1SUTydzQkUYcOnfx8bbXma1hcs4Z1LHLXfkwQ@mail.gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Petr Kulhavy <brain@jikos.cz>
List-Id: alsa-devel@alsa-project.org

On Wed, May 04, 2016 at 02:51:14PM -0300, Fabio Estevam wrote:
> On Wed, May 4, 2016 at 2:41 PM, Fabio Estevam <festevam@gmail.com> wrote:
> 
> > Would you be happy if I do a v2 that uses a property like:
> >
> > fsl,sai-mclk-direction = <1>;
> 
> As it is boolean, this could be simply "fsl,sai-mclk-direction-output".
> 
> What do you think?

Yea, that looks perfect to me. At this point, we only need to support
MCLK1 output feature. Whenever we want more than this, we can simply
update the description of the property.
