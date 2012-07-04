From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: How to handle parameter variation across different
 boards but same platform
Date: Wed, 4 Jul 2012 12:45:03 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA3532A@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id B2C6324581
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2012 14:45:13 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Nori, Sekhar" <nsekhar@ti.com>, "'sudhakar.raj@ti.com" <'sudhakar.raj@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Girdwood, Liam" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

hi,

Currently on Davinci platform, codec system clock & snd_soc_card parameter is decided
using machine_is_xxxx() api.

	sound/soc/Davinci/davinci-evm.c, inside evm_hw_params() & evm_init(),

We have an upcoming board based on TI AM335x soc which has both codec system clock 
And the codec name (because of i2c bus difference) different from previous am335x 
based boards. 

Using machine_is_xxx() is not sufficient because there are 2 other boards on same 
Platform/machine but with different values.

So, how to specify these parameters for the new board?

Regards
Gururaja
