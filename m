From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH] ASoC: fsl: Disable SSI in trigger() if
 RE/TE are both cleared
Date: Thu, 11 Jul 2013 23:13:32 -0500
Message-ID: <51DF826C.40208@tabi.org>
References: <1373453034-21618-1-git-send-email-b42378@freescale.com>
 <20130711165401.GU24508@sirena.org.uk> <51DEE810.3090304@tabi.org>
 <20130712035732.GA27823@MrMyself> <51DF7F4F.90707@tabi.org>
 <20130712040930.GB27823@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay01.pair.com (relay01.pair.com [209.68.5.15])
 by alsa0.perex.cz (Postfix) with SMTP id D084926596E
 for <alsa-devel@alsa-project.org>; Fri, 12 Jul 2013 06:13:38 +0200 (CEST)
In-Reply-To: <20130712040930.GB27823@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org

Nicolin Chen wrote:
> Oh, I see. Actually we've been using this patch for quite a while,
> it should be okay.

Have you tested it on PowerPC?

-- 
Timur Tabi
