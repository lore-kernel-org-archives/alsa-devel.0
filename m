From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v4 0/6] ASoC: fsl_ssi: Fixing various
 channel slips and bad samples insertions
Date: Sat, 7 May 2016 19:56:41 -0300
Message-ID: <CAOMZO5A7bD7kAc1vz2eZqgqcV1WAEV+-D=UFw3ptQf43C7kROw@mail.gmail.com>
References: <1462277640-20052-1-git-send-email-arnaud.mouiche@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f176.google.com (mail-ig0-f176.google.com
 [209.85.213.176])
 by alsa0.perex.cz (Postfix) with ESMTP id BF91C260438
 for <alsa-devel@alsa-project.org>; Sun,  8 May 2016 00:56:41 +0200 (CEST)
Received: by mail-ig0-f176.google.com with SMTP id m9so67278856ige.1
 for <alsa-devel@alsa-project.org>; Sat, 07 May 2016 15:56:41 -0700 (PDT)
In-Reply-To: <1462277640-20052-1-git-send-email-arnaud.mouiche@invoxia.com>
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

Hi Nicolin,

On Tue, May 3, 2016 at 9:13 AM, Arnaud Mouiche
<arnaud.mouiche@invoxia.com> wrote:

> Arnaud Mouiche (6):
>   ASoC: fsl_ssi: Real hardware channels max number is 32
>   ASoC: fsl_ssi: The IPG/5 limitation concerns the bitclk, not the
>     sysclk.
>   ASoC: fsl_ssi: Save a dev reference for dev_err() purpose.
>   ASoC: fsl_ssi: Fix samples being dropped at Playback startup
>   ASoC: fsl_ssi: Fix channel slipping in Playback at startup
>   ASoC: fsl_ssi: Fix channel slipping on capture (or playback) restart
>     in full duplex.

Are you happy with this version?
