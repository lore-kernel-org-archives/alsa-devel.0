From: Timur Tabi <timur@freescale.com>
Subject: Re: snd-soc-cs4270: Convert to a new-style i2c driver
 (work in progress)
Date: Wed, 03 Sep 2008 16:21:59 -0500
Message-ID: <48BEFFF7.80903@freescale.com>
References: <20080831161843.227b31f3@hyperion.delvare>	<ed82fe3e0808310928v18eed8bdh98faa6796a516142@mail.gmail.com>	<20080831190928.2931b0ed@hyperion.delvare>	<ed82fe3e0809031247t3085e409x3141f9712ad962a9@mail.gmail.com>	<ed82fe3e0809031330s5036e9d0g1c2b3e73096f2a6@mail.gmail.com>
	<20080903224402.4d794c95@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 506AC103823
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Sep 2008 23:22:04 +0200 (CEST)
In-Reply-To: <20080903224402.4d794c95@hyperion.delvare>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jean Delvare <khali@linux-fr.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jean Delvare wrote:

> By writing to the unbind file that the i2c driver in question exposes
> in /sys? I didn't try it but it should cause the driver to unbind from
> the device in question and thus ->remove would be called.

Can you give me specifics on how to use the unbind file?  I tried a few things,
but none of them worked, and google isn't helpful either.

-- 
Timur Tabi
Linux kernel developer at Freescale
