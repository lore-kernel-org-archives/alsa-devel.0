From: Zidan Wang <zidan.wang@freescale.com>
Subject: wm8960 sleep time is too long when system suspend
Date: Mon, 2 Nov 2015 16:44:04 +0800
Message-ID: <20151102084402.GA7603@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0110.outbound.protection.outlook.com [157.56.110.110])
 by alsa0.perex.cz (Postfix) with ESMTP id B3CC326061B
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2015 09:45:57 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

In wm8960 codec driver, suspend_bias_off has been enabled. So when system suspend, the wm8960 codec will go to bias off,
it will disable VMID and VREF, then sleep 600ms. It seems that 600ms is too long for system suspend.

Because the wm8960 datasheet don't mentioned the sleep time, so i want to check with you if we can shorten the sleep time.



Best Regards,
Zidan Wang
