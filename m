From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 01/10] irqchip: irq-mips-gic: export
	gic_send_ipi
Date: Mon, 24 Aug 2015 14:49:13 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1508241447100.3873@nanos>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
 <1440419959-14315-2-git-send-email-qais.yousef@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from Galois.linutronix.de (www.linutronix.de [62.245.132.108])
 by alsa0.perex.cz (Postfix) with ESMTP id B56402606E8
 for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2015 14:49:41 +0200 (CEST)
In-Reply-To: <1440419959-14315-2-git-send-email-qais.yousef@imgtec.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qais Yousef <qais.yousef@imgtec.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, linux-mips@linux-mips.org, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 24 Aug 2015, Qais Yousef wrote:

> Some drivers might require to send ipi to other cores. So export it.

Which IPIs do you need to send from a driver which are not exposed by
the SMP functions already?

> This will be used later by AXD driver.

That smells fishy and it wants a proper explanation WHY and not just a
sloppy statement that it will be used later. I can figure that out
myself as exporting a function without using it does not make any sense.

Thanks,

	tglx
