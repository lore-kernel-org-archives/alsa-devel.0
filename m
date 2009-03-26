From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] pxa2xx-ac97: fix displaying GSR after
	reset timeout
Date: Thu, 26 Mar 2009 14:27:51 +0000
Message-ID: <20090326142751.GF3771@sirena.org.uk>
References: <20090325103406.GA20936@sirena.org.uk>
	<1238069883-12445-1-git-send-email-l.fu@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B0889103874
	for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2009 15:27:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1238069883-12445-1-git-send-email-l.fu@pengutronix.de>
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
Cc: dbaryshkov@gmail.com, alsa-devel@alsa-project.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 26, 2009 at 01:18:03PM +0100, Luotao Fu wrote:
> the variable gsr_bit is set in isr. It is however set to 0 and interrupts are
> disabled prior to reset. Hence it doesn't make a lot of sense to show the
> content of gsr_bit in case of a reset timeout.

> Signed-off-by: Luotao Fu <l.fu@pengutronix.de>

Applied, thanks!
