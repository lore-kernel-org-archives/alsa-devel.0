From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: ASoC: Failed to create component debugfs directory
Date: Mon, 19 Feb 2018 12:14:41 -0800
Message-ID: <20180219201440.GA10420@Asurada>
References: <CAOMZO5D071pPr4fL7eLwWgX6h8Mppwic2u4mUCGzUZiss-+3MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f180.google.com (mail-pf0-f180.google.com
 [209.85.192.180])
 by alsa0.perex.cz (Postfix) with ESMTP id A0F37266DFD
 for <alsa-devel@alsa-project.org>; Mon, 19 Feb 2018 21:14:48 +0100 (CET)
Received: by mail-pf0-f180.google.com with SMTP id j24so1608197pff.12
 for <alsa-devel@alsa-project.org>; Mon, 19 Feb 2018 12:14:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAOMZO5D071pPr4fL7eLwWgX6h8Mppwic2u4mUCGzUZiss-+3MQ@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 19, 2018 at 03:49:11PM -0300, Fabio Estevam wrote:
> Hi,
> 
> On linux-next I see the following errors on imx6 wandboard:
> 
> [    3.040897] fsl-ssi-dai 2028000.ssi: ASoC: Failed to create
> component debugfs directory
> [    3.065722] fsl-spdif-dai 2004000.spdif: ASoC: Failed to create
> component debugfs directory
> 
> I haven't started debugging this yet and not sure if this is something
> fsl driver specific.

I think it's because we recently changed all CPU dai drivers to
component drivers, so our drivers should probably add something
to create debugfs directories I guess...will take a look at it.
