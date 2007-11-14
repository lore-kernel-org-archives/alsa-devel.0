From: Timur Tabi <timur@freescale.com>
Subject: params_buffer_size() and params_period_bytes() are
 returning the same value
Date: Wed, 14 Nov 2007 15:53:33 -0600
Message-ID: <473B6E5D.3040303@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 2AE5524822
	for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2007 22:53:38 +0100 (CET)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	lAELrYxJ000651
	for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2007 14:53:34 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lAELrXpc029191
	for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2007 15:53:33 -0600 (CST)
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

I have an ASOC v1 driver that I'm wrapping up.  I've noticed something weird in 
my hw_params() function.  I have this code:

size_t buffer_size = params_buffer_size(hw_params);
size_t period_size = params_period_bytes(hw_params);

printk(KERN_INFO "%s: buffer_size=%x period_size=%x\n", __FUNCTION__, 
buffer_size, period_size);
printk(KERN_INFO "%s: params_periods=%u\n", __FUNCTION__, 
params_periods(hw_params));

And it produces this output:

fsl_dma_hw_params: buffer_size=5dc0 period_size=5dc0
fsl_dma_hw_params: params_periods=4

Why am I getting the same value for buffer_size and period_size?  buffer_size 
should be four times period_size.

-- 
Timur Tabi
Linux kernel developer at Freescale
