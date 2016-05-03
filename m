From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v4 1/6] ASoC: fsl_ssi: Real hardware
 channels max number is 32
Date: Tue, 3 May 2016 09:23:01 -0300
Message-ID: <CAOMZO5DMRuohkYVJ+wuN1sKhw3pM_L8LmKx67pa4ZhT0T9rg+g@mail.gmail.com>
References: <1462277640-20052-1-git-send-email-arnaud.mouiche@invoxia.com>
 <1462277640-20052-2-git-send-email-arnaud.mouiche@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f180.google.com (mail-io0-f180.google.com
 [209.85.223.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 04172265E0D
 for <alsa-devel@alsa-project.org>; Tue,  3 May 2016 14:23:03 +0200 (CEST)
Received: by mail-io0-f180.google.com with SMTP id d62so20164106iof.2
 for <alsa-devel@alsa-project.org>; Tue, 03 May 2016 05:23:02 -0700 (PDT)
In-Reply-To: <1462277640-20052-2-git-send-email-arnaud.mouiche@invoxia.com>
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
> The max number of slots in TDM mode is 32:
> - Frame Rate Divider Control is a 5bit value
> - Time slot mask registers control 32 slots.
>
> Signed-off-by: Arnaud Mouiche <arnaud.mouiche@invoxia.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
