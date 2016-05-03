From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v4 5/6] ASoC: fsl_ssi: Fix channel slipping
 in Playback at startup
Date: Tue, 3 May 2016 09:24:32 -0300
Message-ID: <CAOMZO5BbS6CJ_AsYjUSYouoZySdj39AR6kUQi=evHfjn7=wbvw@mail.gmail.com>
References: <1462277640-20052-1-git-send-email-arnaud.mouiche@invoxia.com>
 <1462277640-20052-6-git-send-email-arnaud.mouiche@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f180.google.com (mail-ig0-f180.google.com
 [209.85.213.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 53CF3265E38
 for <alsa-devel@alsa-project.org>; Tue,  3 May 2016 14:24:33 +0200 (CEST)
Received: by mail-ig0-f180.google.com with SMTP id u10so113393042igr.1
 for <alsa-devel@alsa-project.org>; Tue, 03 May 2016 05:24:33 -0700 (PDT)
In-Reply-To: <1462277640-20052-6-git-send-email-arnaud.mouiche@invoxia.com>
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
> Previously, SCR.SSIEN and SCR.TE were enabled at once if no capture
> stream was also running.
> This may not give a chance for the DMA to write the first sample in
> TX FIFO before the streaming starts on the PCM bus, inserting void
> samples first.
> Those void samples are then responsible for slipping the channels.
>
> Signed-off-by: Arnaud Mouiche <arnaud.mouiche@invoxia.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
