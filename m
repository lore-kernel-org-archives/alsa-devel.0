From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH v3 09/18] ASoC: fsl-ssi: Only enable
	baudclk when used
Date: Thu, 17 Apr 2014 08:46:01 -0500
Message-ID: <534FDB19.7060100@tabi.org>
References: <1397482548-28463-1-git-send-email-mpa@pengutronix.de>
 <1397482548-28463-10-git-send-email-mpa@pengutronix.de>
 <20140414152850.GB7197@MrMyself> <20140416072738.GC6159@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id ACC842652C5
 for <alsa-devel@alsa-project.org>; Thu, 17 Apr 2014 15:46:05 +0200 (CEST)
In-Reply-To: <20140416072738.GC6159@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>, Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Alexander Shiyan <shc_work@mail.ru>, Mark Brown <broonie@kernel.org>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Markus Pargmann wrote:
> Is there always exactly one hw_free call for one hw_params call?

I don't think so.  It's been a while since I've worked on this code, but 
I do remember noticing that hw_params could be called multiple times, 
whereas hw_free was called only once.  This made a big impact on my 
design of the code.
