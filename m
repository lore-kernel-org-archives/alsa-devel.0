From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] pxa2xx-ac97: switch AC unit to
	correct	state before probing
Date: Mon, 5 Jan 2009 10:58:05 +0000
Message-ID: <20090105105805.GA22459@rakim.wolfsonmicro.main>
References: <1231149486-32377-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8F7A21037EE
	for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2009 11:58:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1231149486-32377-1-git-send-email-dbaryshkov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 05, 2009 at 12:58:06PM +0300, Dmitry Eremin-Solenikov wrote:
> From: Dmitry Baryshkov <dbaryshkov@gmail.com>

> If AC97 unit is in partially enabled state, early request_irq can trigger
> IRQ storm or even full hang up. Workaround this by forcibly switching ACLINK off
> at the start of the probe.

> Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>

Applied, thanks.  I guess some of your scripts need updating for your
name change after your wedding, though?
