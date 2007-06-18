From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: Writing an AT91SAM9260-EK Dumb Codec Driver
Date: Mon, 18 Jun 2007 18:15:58 +0100
Message-ID: <1182186958.26658.118.camel@localhost.localdomain>
References: <61c0054e0706151146i26514503hb0bfc99ad8399791@mail.gmail.com>
	<1181934519.26658.94.camel@localhost.localdomain>
	<61c0054e0706151406o2cc8b4c2x502e7fdb38a39a3e@mail.gmail.com>
	<61c0054e0706180851y49fc8c1cs7a27c4f84d10904f@mail.gmail.com>
	<61c0054e0706181007g6d7b9de0te1c27ffefebc2225@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id E612F243CE
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Jun 2007 19:15:59 +0200 (CEST)
In-Reply-To: <61c0054e0706181007g6d7b9de0te1c27ffefebc2225@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Kavan <pkavan@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2007-06-18 at 12:07 -0500, Paul Kavan wrote:
> I now have the linux-2.6.22-rc1 kernel booting correctly without the
> aSoC driver activated in .config. However, when I rebuild with the
> aSoC and then boot, I get the following crash:
> 
> .snip.
> Advanced Linux Sound Architecture Driver Version 1.0.14rc4 (Wed May 09
> 09:51:39 2007 UTC).
> ASoC version 0.13.0 
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000001
> pgd = c0004000
> [00000001] *pgd=00000000
> Internal error: Oops: 801 [#1]
> Modules linked in:
> CPU: 0
> PC is at grh_ek_w6811_init+0x4c/0x11c
> LR is at __arm_ioremap_pfn+0x2cc/0x2ec

You have a NULL pointer dereference in grh_ek_w6811_init(), most likely
to be ssc as the dai private data wont be set yet. i.e.

struct at91_ssc_periph *ssc = grh_ek_w6811_dai.cpu_dai->private_data;

Liam
