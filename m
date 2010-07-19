From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: DMA Physical Addr Issue.
Date: Mon, 19 Jul 2010 18:43:37 +0200
Message-ID: <4C4480B9.4060201@ladisch.de>
References: <AANLkTilhwORMM9UVYAm-ENDwcMjV8lHse6_Lu3k-gtAr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 88CF824536
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Jul 2010 18:43:48 +0200 (CEST)
In-Reply-To: <AANLkTilhwORMM9UVYAm-ENDwcMjV8lHse6_Lu3k-gtAr@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adish Kuvelker <adkuvi@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adish Kuvelker wrote:
> And, when I print the DMA region physical address in the "prepare"
> call out through "dma_addr" member of the runtime structure I get a
> weird decimal value of "-1036562432" as the physical address.

In hex, that value is 0xc2375000, which looks like a perfectly
cromulent address.


Regards,
Clemens
