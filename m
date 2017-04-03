From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl_ssi: Fix channel swap on
	playback start
Date: Mon, 3 Apr 2017 19:54:26 -0300
Message-ID: <CAOMZO5AZm5w69033PKd+PTQARZaujO9H_n7YtQ7hnGESefvd4A@mail.gmail.com>
References: <1491058131-31366-1-git-send-email-festevam@gmail.com>
 <20170403223614.GC21156@Asurada-Nvidia>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
 [209.85.218.65])
 by alsa0.perex.cz (Postfix) with ESMTP id BEC3C266972
 for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2017 00:54:28 +0200 (CEST)
Received: by mail-oi0-f65.google.com with SMTP id d2so14840234oig.2
 for <alsa-devel@alsa-project.org>; Mon, 03 Apr 2017 15:54:28 -0700 (PDT)
In-Reply-To: <20170403223614.GC21156@Asurada-Nvidia>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Arnaud Mouiche <arnaud.mouiche@invoxia.com>, Timur Tabi <timur@tabi.org>, Caleb Crome <caleb@crome.org>, Mark Brown <broonie@kernel.org>, Max Krummenacher <max.krummenacher@toradex.com>, Fabio Estevam <fabio.estevam@nxp.com>, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

Hi Nicolin,

On Mon, Apr 3, 2017 at 7:36 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:

> My extra concern for this change is that ENGcm06222 suggests to
> set TE and SSIEN together. However, we are still not setting the
> SSIEN and TE together -- SSIEN is set already before this line
> in the "ssi_private->use_dma && (vals->scr & CCSR_SSI_SCR_TE)".
>
> On the other hand, ENGcm06222 doesn't mention anything related
> to the RE bit. Although ENGcm06474 suggests to set TE and RE
> together, yet it's for another bug (when TE is set after RE, the
> TX channels might be swapped.)

The idea for this patch came from commit f8fdf5375e2005 ("ASoC:
fsl-ssi: add SSIEN errata work around").

In this commit SSIEN, TE and RE are written at the same time as a
workaround to ENGcm06222 and ENGcm06532
from the MX35 errata document. The workaround was only applied to AC97
context (not sure why?).

ENGcm06222 is about "SSI:Transmission does not take place in bit
length early frame sync configuration"

As we use bit length frame sync in I2S mode, I thought this could
impact us and when I try the patch  it does not swap anymore on this
simple usecase:
aplay swap_test.wav& sleep 1; killall aplay

Seems to cause other issues though as reported by Caleb and Arnaud, so
we need to find other way to solve this.

> Then, the test case: aplay swap_test.wav& sleep 1; killall aplay
>
> It doesn't involve RE at all. So I don't get why setting RE and
> TE together after setting SSIEN (three bits are not set together
> here.) could solve the channel swapping problem for a test case
> which has never involved RE at all. Am I missing something?

Your understanding is correct. In my usecase there is no audio capture
involved at all, just stereo audio playback.

The only explanation I can give is the same one from commit
f8fdf5375e2005 ("ASoC: fsl-ssi: add SSIEN errata work around").

Do you have access to any imx board with SSI?
