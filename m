From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 4/4] ARM: mx28evk: add missed clkmux select
 for saif
Date: Sat, 28 Jul 2012 16:25:48 +0800
Message-ID: <20120728082543.GB2128@S2101-09.ap.freescale.net>
References: <1342776027-31758-1-git-send-email-b29396@freescale.com>
 <1342776027-31758-5-git-send-email-b29396@freescale.com>
 <20120721074002.GC923@S2101-09.ap.freescale.net>
 <20120723023632.GA9427@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 by alsa0.perex.cz (Postfix) with ESMTP id DA457264EEF
 for <alsa-devel@alsa-project.org>; Sat, 28 Jul 2012 10:26:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120723023632.GA9427@shlinux2.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <b29396@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, Guo Shawn-R65073 <r65073@freescale.com>, "lrg@ti.com" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 23, 2012 at 10:36:33AM +0800, Dong Aisheng wrote:
> This patch series was made based on Mark's sound-2.6 tree.
> Do you want this one go through mxs tree and other three go through Mark's tree?

Yes.  That's the way to save conflict.

> I'm thinking maybe it would be better go through one tree(Mark's or Yours) since
> without this one the saif record still can not work.

The recording has been broken.  There is no point to force the whole
series to go via one tree.  When sound and arm-soc get merged on
linux-next (for testing) and mainline, the recording gets back to work.

-- 
Regards,
Shawn
