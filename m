From: Linus Walleij <linus.walleij@linaro.org>
Subject: DMA screams on MSP
Date: Tue, 4 Feb 2014 12:56:18 +0100
Message-ID: <CACRpkdYkvExwY_w+PkoJdmTSysmc_LbUHG52=Qr_56AMgSyFSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f53.google.com (mail-oa0-f53.google.com
 [209.85.219.53])
 by alsa0.perex.cz (Postfix) with ESMTP id C305126172B
 for <alsa-devel@alsa-project.org>; Tue,  4 Feb 2014 12:56:19 +0100 (CET)
Received: by mail-oa0-f53.google.com with SMTP id m1so9752227oag.12
 for <alsa-devel@alsa-project.org>; Tue, 04 Feb 2014 03:56:18 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Lee,

I get this in my bootlog nowadays (v3.14-rc1):

[    2.713897] dma dma0chan29: [d40_validate_conf] Invalid device type
(14) physical channel exeeds available physical channels
[    2.725158] dma dma0chan30: [d40_validate_conf] Invalid device type
(14) physical channel exeeds available physical channels
[    2.737457] dma dma0chan31: [d40_validate_conf] Invalid device type
(14) physical channel exeeds available physical channels
[    2.750793] dma dma0chan32: [d40_validate_conf] Invalid device type
(14) physical channel exeeds available physical channels
[    2.762145] dma dma0chan33: [d40_validate_conf] Invalid device type
(14) physical channel exeeds available physical channels
[    2.773376] dma dma0chan34: [d40_validate_conf] Invalid device type
(14) physical channel exeeds available physical channels
[    2.784606] dma dma0chan35: [d40_validate_conf] Invalid device type
(14) physical channel exeeds available physical channels
[    2.795837] dma dma0chan36: [d40_validate_conf] Invalid device type
(14) physical channel exeeds available physical channels
[    2.807067] dma dma0chan37: [d40_validate_conf] Invalid device type
(14) physical channel exeeds available physical channels
[    2.818298] dma dma0chan38: [d40_validate_conf] Invalid device type
(14) physical channel exeeds available physical channels
[    2.829528] dma dma0chan39: [d40_validate_conf] Invalid device type
(14) physical channel exeeds available physical channels
[    2.840728] dma dma0chan40: [d40_validate_conf] Invalid device type
(14) physical channel exeeds available physical channels
[    2.851959] dma dma0chan41: [d40_validate_conf] Invalid device type
(14) physical channel exeeds available physical channels
[    2.863189] dma dma0chan42: [d40_validate_conf] Invalid device type
(14) physical channel exeeds available physical channels
(...)
[    5.315887] dma dma0chan252: [d40_validate_conf] Invalid device
type (14) physical channel exeeds available physical channels
[    5.327209] dma dma0chan253: [d40_validate_conf] Invalid device
type (14) physical channel exeeds available physical channels
[    5.338531] dma dma0chan254: [d40_validate_conf] Invalid device
type (14) physical channel exeeds available physical channels
[    5.349853] dma dma0chan255: [d40_validate_conf] Invalid device
type (14) physical channel exeeds available physical channels

(I patched dma40 to state the exact cause instead of just
"invalid device type".)

Like something (I guess ALSA SoC?) is trying real hard to get physical
channel 14, but I can't seem to figure out what is going on.

I will try to see if this also appears on the Snowball but I guess
so?

Any hints appreciated...

Yours,
Linus Walleij
