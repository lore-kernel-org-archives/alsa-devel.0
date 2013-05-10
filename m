From: Eric Nelson <eric.nelson@boundarydevices.com>
Subject: Re: [PATCH v5 1/2] ASoC: sgtl5000: Read
	SGTL5000_CHIP_ID in i2c_probe()
Date: Fri, 10 May 2013 09:37:58 -0700
Message-ID: <518D2266.4080705@boundarydevices.com>
References: <1368144947-23775-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-da0-f49.google.com (mail-da0-f49.google.com
 [209.85.210.49])
 by alsa0.perex.cz (Postfix) with ESMTP id C84E0261677
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2013 18:38:04 +0200 (CEST)
Received: by mail-da0-f49.google.com with SMTP id p5so2340336dak.36
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2013 09:38:03 -0700 (PDT)
In-Reply-To: <1368144947-23775-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, lars@metafoo.de, matt@genesi-usa.com, troy.kisky@boundarydevices.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 05/09/2013 05:15 PM, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> The usual place for reading chip ID is inside i2c_probe, so move it there and
> also convert it to regmap.
>
> sgtl5000_enable_regulators() needs to read the chip revision, so keep the
> revision check there.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v4:
> - Just introduced in this version.
>
>   sound/soc/codecs/sgtl5000.c |   39 ++++++++++++++++++++++++---------------
>   1 file changed, 24 insertions(+), 15 deletions(-)
>

Tested-by: Eric Nelson <eric.nelson@boundarydevices.com>
