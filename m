From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [RESEND PATCH v4] Sound: PXA: Fix settings of
	PXAxxx DMA
Date: Thu, 29 Jan 2015 20:43:50 +0100
Message-ID: <87bnlhnzih.fsf@free.fr>
References: <54CA125D.7010908@tul.cz> <54CA2B7E.5010003@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp07.smtpout.orange.fr
 [80.12.242.129])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CCD7260561
 for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2015 20:43:52 +0100 (CET)
In-Reply-To: <54CA2B7E.5010003@tul.cz> (Petr Cvek's message of "Thu, 29 Jan
 2015 13:45:50 +0100")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Cvek <petr.cvek@tul.cz>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, haojian.zhuang@gmail.com, broonie@kernel.org, daniel@zonque.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Petr Cvek <petr.cvek@tul.cz> writes:

> Fix PXA DMA autoincrementation, so capture will not use playback settings
> (incrementation in register space instead in target buffer).
>
> Regression from:
>   'commit d65a14587a9be853a887a1407db133df1fb68e29 ("ASoC: pxa: use snd_dmaengine_dai_dma_data")'
>
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
> Acked-by: Daniel Mack <daniel@zonque.org>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

--
Robert
