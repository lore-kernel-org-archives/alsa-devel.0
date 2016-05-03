From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v4 4/6] ASoC: fsl_ssi: Fix samples being
 dropped at Playback startup
Date: Tue, 3 May 2016 09:24:13 -0300
Message-ID: <CAOMZO5DSX5fDmwov-sQSvD721mQ9Xf0qjtg6nK3XPLtchGh=aw@mail.gmail.com>
References: <1462277640-20052-1-git-send-email-arnaud.mouiche@invoxia.com>
 <1462277640-20052-5-git-send-email-arnaud.mouiche@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f177.google.com (mail-io0-f177.google.com
 [209.85.223.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 22CD9265CC8
 for <alsa-devel@alsa-project.org>; Tue,  3 May 2016 14:24:14 +0200 (CEST)
Received: by mail-io0-f177.google.com with SMTP id f89so20283692ioi.0
 for <alsa-devel@alsa-project.org>; Tue, 03 May 2016 05:24:14 -0700 (PDT)
In-Reply-To: <1462277640-20052-5-git-send-email-arnaud.mouiche@invoxia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Caleb Crome <caleb@crome.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, May 3, 2016 at 9:13 AM, Arnaud Mouiche
<arnaud.mouiche@invoxia.com> wrote:
> If the capture is already running while playback is started, it is highly
> probable (>80% in a 8 channels scenario) that samples are lost between
> the DMA and TX fifo.
>
> The reason is that SIER.TDMAE is set before STCR.TFEN0, leaving a time
> window where the FIFO doesn't receive the samples written by the DMA.
>
> This particular case happened only if capture is already enabled as
> SCR.SSIEN is already set at the playback startup instant.
>
> Signed-off-by: Arnaud Mouiche <arnaud.mouiche@invoxia.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
