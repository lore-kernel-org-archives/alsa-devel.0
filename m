From: Dong Aisheng <dong.aisheng@linaro.org>
Subject: Re: [PATCH v2 1/2] ASoC: mxs-saif: Fix channel swap
	for 24-bit format
Date: Fri, 2 Nov 2012 05:59:05 +0800
Message-ID: <CAP1dx+x7VpTnePoE+37KbKWHM_LgsUf1pZz_5=d+fi4dU32H2A@mail.gmail.com>
References: <1351792632-30649-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ia0-f179.google.com (mail-ia0-f179.google.com
 [209.85.210.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F5CD264F13
 for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2012 22:59:06 +0100 (CET)
Received: by mail-ia0-f179.google.com with SMTP id k25so2150336iah.38
 for <alsa-devel@alsa-project.org>; Thu, 01 Nov 2012 14:59:05 -0700 (PDT)
In-Reply-To: <1351792632-30649-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, DWinner@tc-helicon.com, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org

On 2 November 2012 01:57, Fabio Estevam <fabio.estevam@freescale.com> wrote:
> Playing 24-bit format file leads to channel swap on mx28 and the reason is that
> the current driver performs one write/read to/from the SAIF_DATA register to
> trigger the transfer.
>
> This approach works fine for S16_LE case because SAIF_DATA is a 32-bit register
> and thus is capable of storing the 16-bit left and right channels, but for the
> S24_LE case it can only store one channel, so in order to not lose the FIFO sync
> an extra read/write is needed.
>
> Reported-by: Dan Winner <DWinner@tc-helicon.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> Tested-by: Dan Winner <DWinner@tc-helicon.com>

Acked-by: Dong Aisheng <dong.aisheng@linaro.org>

Regards
Dong Aisheng
