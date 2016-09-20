From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 5/5] ASoC: fsl_ssi: Remove
 .num_reg_defaults_raw from regmap_config
Date: Tue, 20 Sep 2016 20:23:29 +0200
Message-ID: <e6a4bf12-e1d8-9588-f25d-0c141187f96e@denx.de>
References: <20160919193029.8119-1-marex@denx.de>
 <20160919193029.8119-5-marex@denx.de> <20160920175629.GB7994@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 by alsa0.perex.cz (Postfix) with ESMTP id AB226266D9C
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2016 20:23:33 +0200 (CEST)
In-Reply-To: <20160920175629.GB7994@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org

On 09/20/2016 07:56 PM, Mark Brown wrote:
> On Mon, Sep 19, 2016 at 09:30:29PM +0200, Marek Vasut wrote:
> 
>> Cc: Xiubo Li <Xiubo.Lee@gmail.com>
>> --
>> fsl-ssi-dai 202c000.ssi: No cache defaults, reading back from HW
> 
> This probably shouldn't have been part of the signoff chain and also
> please think hard before including complete backtraces in upstream
> reports, they are very large and contain almost no useful information
> relative to their size so often obscure the relevant content in your
> message. If part of the backtrace is usefully illustrative then it's
> usually better to pull out the relevant sections.
> 
My intent was to include the full backtrace, but not as a part of the
commit message. I can see some parts were not exactly useful, sorry.

-- 
Best regards,
Marek Vasut
