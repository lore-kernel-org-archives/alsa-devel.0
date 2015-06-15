From: Timur Karaldin <karaldin@mcsplus.ru>
Subject: AIC3106 problem with driver (MIC BIAS)
Date: Mon, 15 Jun 2015 15:27:49 +0300
Message-ID: <557EC4C5.2040806@mcsplus.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp26.mail.ru (smtp26.mail.ru [94.100.181.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 643242614CA
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2015 14:28:45 +0200 (CEST)
Received: from [83.242.226.142] (port=29363 helo=[192.168.100.105])
 by smtp26.mail.ru with esmtpa (envelope-from <karaldin@mcsplus.ru>)
 id 1Z4TVM-0006tq-KX
 for alsa-devel@alsa-project.org; Mon, 15 Jun 2015 15:28:44 +0300
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello, I'm using linux 3.12 kernel for TI SITARA ARM (am335x) with TI 
AIC3106 codec ( tlv320aic3x.c driver).
There is a mic bias support through device tree option aic3x-micbias-vg. 
But in fact it's not working correctly. During kernel booting it's 
setting (after 2-3 seconds) but after finish booting it's cleared. Even 
if I change the default regs values in aic3x_reg, it's cleared after 
booting.
Could somebody point me to solution?
Another thing I need to do is to get mic/headset detection in mixer. 
There is some code in driver ("Detection" output) but actually I don't 
understand right way of using it.

Best regards,
Tim Karaldin
