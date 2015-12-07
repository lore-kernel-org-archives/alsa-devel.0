From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2 1/6] ASoC: fsl_ssi: Real hardware
 channels max number is 32
Date: Mon, 7 Dec 2015 10:44:26 -0200
Message-ID: <CAOMZO5DvFFmoX84XEKdiV79ugqedMMrCm5HgXEfm1fzN+1yviw@mail.gmail.com>
References: <1448550341-11765-1-git-send-email-arnaud.mouiche@invoxia.com>
 <1448550341-11765-2-git-send-email-arnaud.mouiche@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f182.google.com (mail-ig0-f182.google.com
 [209.85.213.182])
 by alsa0.perex.cz (Postfix) with ESMTP id AFF812658F0
 for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2015 13:44:27 +0100 (CET)
Received: by igcph11 with SMTP id ph11so72834188igc.1
 for <alsa-devel@alsa-project.org>; Mon, 07 Dec 2015 04:44:26 -0800 (PST)
In-Reply-To: <1448550341-11765-2-git-send-email-arnaud.mouiche@invoxia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Mouiche <arnaud.mouiche@invoxia.com>, Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Caleb Crome <caleb@crome.org>, Markus Pargmann <mpa@pengutronix.de>, Mark Brown <broonie@kernel.org>, Roberto Fichera <kernel@tekno-soft.it>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi Arnaud,

On Thu, Nov 26, 2015 at 1:05 PM, Arnaud Mouiche
<arnaud.mouiche@invoxia.com> wrote:
> The max number of slots in TDM mode is 32:
> - Frame Rate Divider Control is a 5bit value
> - Time slot mask registers control 32 slots.
>
> Signed-off-by: Arnaud Mouiche <arnaud.mouiche@invoxia.com>

Thanks for your series. It seems you missed to Cc the SSI driver
maintainer: Nicolin Chen.
