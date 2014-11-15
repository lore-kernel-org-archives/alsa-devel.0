From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] ASoC: pxa: prepare/unprepare clocks in
	pxa-ssp
Date: Sat, 15 Nov 2014 22:15:20 +0100
Message-ID: <874mu0f9nb.fsf@free.fr>
References: <1416081106-28324-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr
 [80.12.242.124])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BB292605FA
 for <alsa-devel@alsa-project.org>; Sat, 15 Nov 2014 22:15:23 +0100 (CET)
In-Reply-To: <1416081106-28324-1-git-send-email-dbaryshkov@gmail.com> (Dmitry
 Eremin-Solenikov's message of "Sat, 15 Nov 2014 22:51:46 +0300")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:

> Change clk_enable/disable() calls to clk_prepare_enable() and
> clk_disable_unrepapre().
  clk_disable_unprepare() (typo)

Otherwise, look good to me, ack.

Cheers.

--
Robert
