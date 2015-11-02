From: Caleb Crome <caleb@crome.org>
Subject: ASoC: fsl_ssi: How do I gracefully restart after a
	channel slip is detected?
Date: Mon, 2 Nov 2015 07:53:42 -0800
Message-ID: <CAG5mAdyuxR-YiwjJ+OXAYEH3YU0=PWbJiickFJidxMcXPjTVHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
 by alsa0.perex.cz (Postfix) with ESMTP id D4D85261703
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2015 16:54:02 +0100 (CET)
Received: by wmeg8 with SMTP id g8so64424924wme.1
 for <alsa-devel@alsa-project.org>; Mon, 02 Nov 2015 07:54:02 -0800 (PST)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Markus Pargmann <mpa@pengutronix.de>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Roberto Fichera <kernel@tekno-soft.it>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi Again,
  I'm definitely making progress towards a fully working FSL SSI port
in TDM mode.  The TX seems to be fairly robust.  However, there is a
new problem now.  The Rx can overrun, and what happens, I get an Rx
channel slip.  The DMA consuming data from the fifo is out of sync.

I can detect this with the Rx overrun ISR.  The question is, how do I
restart everything gracefully?  I somehow need to tell the DMA to
restart on a frame boundary, and I need to restart the SSI, correct?

I don't see any similar method to do this in the ESAI driver.

Or perhaps I'm missing something and there is a better way to avoid
the slip in the first place?

Thanks again,
  -Caleb
