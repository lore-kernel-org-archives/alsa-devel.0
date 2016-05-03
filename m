From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v4 6/6] ASoC: fsl_ssi: Fix channel slipping
 on capture (or playback) restart in full duplex.
Date: Tue, 3 May 2016 09:24:59 -0300
Message-ID: <CAOMZO5BkQvUA3EJJzgqWeiLRMm_=7=Q0xcqKnip0vGUrKLg5uw@mail.gmail.com>
References: <1462277640-20052-1-git-send-email-arnaud.mouiche@invoxia.com>
 <1462277640-20052-7-git-send-email-arnaud.mouiche@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f175.google.com (mail-io0-f175.google.com
 [209.85.223.175])
 by alsa0.perex.cz (Postfix) with ESMTP id F2C0B265A70
 for <alsa-devel@alsa-project.org>; Tue,  3 May 2016 14:24:59 +0200 (CEST)
Received: by mail-io0-f175.google.com with SMTP id d62so20214484iof.2
 for <alsa-devel@alsa-project.org>; Tue, 03 May 2016 05:24:59 -0700 (PDT)
In-Reply-To: <1462277640-20052-7-git-send-email-arnaud.mouiche@invoxia.com>
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

On Tue, May 3, 2016 at 9:14 AM, Arnaud Mouiche
<arnaud.mouiche@invoxia.com> wrote:
> Happened when the Playback (or Capture) is running continuously
> and Capture (or Playback) is restarted (xrun, manual stop/start...)
>
> Since the RX (or TX) FIFO are only reset when the whole SSI is disabled,
> pending samples from previous capture (or playback) session may still
> be present. They must be erased to not introduce channel slipping.
>
> FIFO Clear register fields are documented in IMX51, IMX35 reference manual.
> They are not documented in IMX50 or IMX6 RM, despite they are
> working as expected on IMX6SL and IMX6solo.
>
> Signed-off-by: Arnaud Mouiche <arnaud.mouiche@invoxia.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
