From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: ASoC: Failed to create DAPM debugfs
Date: Wed, 08 Apr 2015 21:33:06 +0200
Message-ID: <55258272.2010205@metafoo.de>
References: <CAOMZO5DP4fahmC9W6eBFdjxR1DqPMgyhgwxwSZP_TcqxLSy=7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-026.synserver.de (smtp-out-026.synserver.de
 [212.40.185.26])
 by alsa0.perex.cz (Postfix) with ESMTP id 673892606D6
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 21:33:07 +0200 (CEST)
In-Reply-To: <CAOMZO5DP4fahmC9W6eBFdjxR1DqPMgyhgwxwSZP_TcqxLSy=7A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Russell King <linux@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

On 04/08/2015 08:31 PM, Fabio Estevam wrote:
> Hi,
>
> On a imx6q-hummingboard the following warning is seen when running
> linux-next 20150408:
>
> [    2.270006] imx-spdif sound-spdif: ASoC: Failed to create DAPM
> debugfs directory
>
> Looking at sound/soc/fsl/imx-spdif.c and sound/soc/fsl/fsl_spdif.c I
> am not sure how to avoid such warning.
>
> Any ideas?

Does the card name contain a '/' like in 'S/PDIF'?

- Lars
