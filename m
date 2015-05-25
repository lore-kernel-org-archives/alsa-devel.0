From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: Don't try to round-up for
 clock divisor calculation
Date: Mon, 25 May 2015 12:13:45 -0300
Message-ID: <CAOMZO5B+GQdXZDfKV6Hz3wXmJCUcXBeWWQxR_jY0n28OnA_gJg@mail.gmail.com>
References: <1432455161-4924-1-git-send-email-nicoleotsuka@gmail.com>
 <20150525115812.GG21391@sirena.org.uk>
 <20150525151127.GA8184@Asurada>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f169.google.com (mail-lb0-f169.google.com
 [209.85.217.169])
 by alsa0.perex.cz (Postfix) with ESMTP id E5A2D2610A3
 for <alsa-devel@alsa-project.org>; Mon, 25 May 2015 17:13:45 +0200 (CEST)
Received: by lbcmx3 with SMTP id mx3so53428880lbc.1
 for <alsa-devel@alsa-project.org>; Mon, 25 May 2015 08:13:45 -0700 (PDT)
In-Reply-To: <20150525151127.GA8184@Asurada>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Zidan Wang <zidan.wang@freescale.com>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

Hi Nicolin,

On Mon, May 25, 2015 at 12:11 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:

> Hi Mark,
>
> Is that possible for you to provisionally revert this patch?
> I wanted to wait for the test result from Fabio or Zidan in
> the Cc list because I don't have a test environment for SPDIF
> even though this change seems to make sense.

I currently don't have access to a SPDIF receiver to test it.

Regards,

Fabio Estevam
