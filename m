From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How can PCI resource allocation fail?
Date: Fri, 13 Mar 2009 08:44:26 +0100
Message-ID: <49BA0EDA.4080606@ladisch.de>
References: <49B9959F.1080705@digadd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 3AEDA1037F6
	for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2009 08:44:26 +0100 (CET)
In-Reply-To: <49B9959F.1080705@digadd.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Christian P. Schmidt" <schmidt@digadd.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Christian P. Schmidt wrote:
> I'm toying with the alsa-driver for the Creative Labs X-Fi. I'm working
> on the PCI Express version of this card,

... which isn't supported ...

> [46833.487588] cannot allocate the port
> [46833.487594] CA0106: probe of 0000:04:00.0 failed with error -16
> ...
> 	Region 0: Memory at f9ffc000 (32-bit, non-prefetchable) [size=16K]

... because this I/O range is memory-mapped; the driver knows only about
models with regular I/O ports.  (This has nothing to do with the PCI-E
bridge; the X-Fi chip itself is a different model.)


Best regards,
Clemens
