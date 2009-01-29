From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: Can DMA address, periods, buffer size,
 etc change after hw_params is called?
Date: Thu, 29 Jan 2009 08:18:25 +0100
Message-ID: <20090129081825.241be9e4@hcegtvedt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (relay.atmel.no [80.232.32.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 9626F103851
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 08:18:27 +0100 (CET)
Received: from hcegtvedt (dhcp-252-160.norway.atmel.com [10.191.252.160])
	by relay.atmel.no (8.13.4/8.13.4) with ESMTP id n0T7HDEk024815
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 08:17:14 +0100 (CET)
	(envelope-from hans-christian.egtvedt@atmel.com)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I wonder if I must take care handling changes in DMA address, number of
periods and period size in the prepare callback?

Or are these locked after the first time prepare is called?

The reason I ask is because I'm developing a new ALSA driver and I
prepare a cyclic DMA transfer in the first prepare callback. Additional
calls to prepare will not do anything DMA stuff.

The cyclic DMA transfer is then released in the close callback.

Should I after the open and hw_params calls be ready to handle any
change at all regarding DMA buffer address, periods and/or number of
periods?

I hope I made sense in this email (-:

-- 
Best regards,
Hans-Christian Egtvedt
