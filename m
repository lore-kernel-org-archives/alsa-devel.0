From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RESEND] [PATCH] pxa2xx-ac97: fix displaying GSR
	after reset	timeout
Date: Tue, 24 Mar 2009 22:18:41 +0000
Message-ID: <20090324221841.GC15455@n2100.arm.linux.org.uk>
References: <gq8unj$6og$1@ger.gmane.org>
	<1237911929-29895-1-git-send-email-l.fu@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id DD26B243E3
	for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2009 23:18:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1237911929-29895-1-git-send-email-l.fu@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Luotao Fu <l.fu@pengutronix.de>
Cc: dbaryshkov@gmail.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 24, 2009 at 05:25:28PM +0100, Luotao Fu wrote:
> the variable gsr_bit is set in isr. It is however set to 0 and interrupts are
> disabled prior to reset on pxa27x and pxa3xx. Hence it doesn't make a lot of
> sense to show the content of gsr_bit in case of a reset timeout.

It would make more sense to put "GSR | gsr_bits" into a temporary variable
for testing, and then printing so that the value printed is the exact
value which was tested, not somehting that may have changed.

Also, you've resent your patch but omitted the ALSA mailing list.
