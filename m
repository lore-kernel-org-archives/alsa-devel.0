From: Eric Nelson <eric.nelson@boundarydevices.com>
Subject: Re: [PATCH v5 2/2] ASoC: sgtl5000: Fix driver probe
	after reset
Date: Fri, 10 May 2013 09:38:01 -0700
Message-ID: <518D2269.3000208@boundarydevices.com>
References: <1368144947-23775-1-git-send-email-festevam@gmail.com>
 <1368144947-23775-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f174.google.com (mail-pd0-f174.google.com
 [209.85.192.174])
 by alsa0.perex.cz (Postfix) with ESMTP id AD73C261680
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2013 18:38:06 +0200 (CEST)
Received: by mail-pd0-f174.google.com with SMTP id u10so2918274pdi.19
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2013 09:38:05 -0700 (PDT)
In-Reply-To: <1368144947-23775-2-git-send-email-festevam@gmail.com>
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
> After a 'reboot' command in Linux or after pressing the system's reset button
> the sgtl5000 driver fails to probe:
>
> sgtl5000 0-000a: Device with ID register ffff is not a sgtl5000
> sgtl5000 0-000a: ASoC: failed to probe CODEC -19
> imx-sgtl5000 sound.12: ASoC: failed to instantiate card -19
> imx-sgtl5000 sound.12: snd_soc_register_card failed (-19)
>
> sgtl5000 codec does not have a reset line, nor a reset command in software, so
> after a system reset the codec does not contain the default register values
> from sgtl5000_reg_defaults[] anymore, as these are only valid after a
> power-on-reset cycle.
>
> Fix this issue by explicitly reading all the reset register values from
> sgtl5000_reg_defaults[] and writing them back into sgtl5000 to ensure a sane
> state.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v4:
> - Only call sgtl5000_fill_defaults if we know we have a sgtl5000
> Changes since v3:
> - Read sgtl5000_reg_defaults and write these values into sgtl5000
> Changes since v2:
> - Do not use reg_defaults_raw as it is not the correct purpose
> - Manually build sgtl5000_reg_default
> - Improve commitlog
> Changes since v1:
> - Remove sgtl5000_reg_defaults array
> - Do not use num_reg_defaults_raw
>   sound/soc/codecs/sgtl5000.c |   30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
>

Tested-by: Eric Nelson <eric.nelson@boundarydevices.com>
