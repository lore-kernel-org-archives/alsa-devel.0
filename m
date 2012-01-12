From: Julia Lawall <julia.lawall@lip6.fr>
Subject: duplicated test in sound/soc/codecs/sgtl5000.c
Date: Thu, 12 Jan 2012 22:13:24 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1201122210520.25187@pl-59034.rocq.inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1-relais-roc.national.inria.fr
	(mail1-relais-roc.national.inria.fr [192.134.164.82])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B8F02417D
	for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2012 22:13:26 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lrg@ti.com, broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

There is a duplicated test in the function sgtl5000_restore_regs in the 
file sound/soc/codecs/sgtl5000.c:

                /* this regs depends on the others */
                 if (reg == SGTL5000_CHIP_ANA_POWER ||
                         reg == SGTL5000_CHIP_CLK_CTRL ||
                         reg == SGTL5000_CHIP_LINREG_CTRL ||
                         reg == SGTL5000_CHIP_LINE_OUT_CTRL ||
                         reg == SGTL5000_CHIP_CLK_CTRL)
                         continue;

I don't know if some constant other than SGTL5000_CHIP_CLK_CTRL should be 
tested, or if the second test should just be deleted.

julia
