From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: sgtl5000: Let the codec acquire
	its clock
Date: Mon, 10 Jun 2013 13:07:18 -0300
Message-ID: <CAOMZO5B9fsC9UMsdbXMMSJzG_r=-U8o9nr=j9r_GxkeVMoa8og@mail.gmail.com>
References: <1370826467-30399-1-git-send-email-festevam@gmail.com>
 <20130610154126.GF6381@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f181.google.com (mail-vc0-f181.google.com
 [209.85.220.181])
 by alsa0.perex.cz (Postfix) with ESMTP id D381E2616C9
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 18:07:19 +0200 (CEST)
Received: by mail-vc0-f181.google.com with SMTP id lf11so3758070vcb.40
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 09:07:19 -0700 (PDT)
In-Reply-To: <20130610154126.GF6381@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@kernel.org, lars@metafoo.de, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 10, 2013 at 12:41 PM, Shawn Guo <shawn.guo@linaro.org> wrote:

>> -clk_fail:
>> -     clk_put(data->codec_clk);
>
> Why can this clk_put() be removed now?

Good point. Will send a patch to convert it to devm_clk_get, so that
we do not need to call these clk_put.
