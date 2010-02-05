From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: DMA interrupt not getting triggered
Date: Fri, 5 Feb 2010 08:27:38 +0000
Message-ID: <20100205082738.GJ10014@trinity.fluff.org>
References: <25591311.716591265357837890.JavaMail.weblogic@epml09>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from trinity.fluff.org (trinity.fluff.org [89.16.178.74])
	by alsa0.perex.cz (Postfix) with ESMTP id 4281F2432C
	for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2010 09:27:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <25591311.716591265357837890.JavaMail.weblogic@epml09>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ANISH KUMAR <anish.singh@samsung.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "JaroslavKyselaperex@perex.cz" <JaroslavKyselaperex@perex.cz>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 05, 2010 at 08:17:17AM +0000, ANISH KUMAR wrote:
> I am facing problem related to DMA interrupt not getting triggered some times(out of 5 times one time it is happening) causing application to wait for the buffers(hw_ptr = 0) and no sound because of this.
> I am using samsung soc with DMA controller PL080.I tried increasing periods_min to 4 but still no result.
> I am using 2.6.29 kernel version.

Which board are you trying this on?

There may be some improvements with the DMA code in newer kernels, it would
be worth trying 2.6.33 and seeing if that has the same problem. There was
a problem with the circular DMA code failing to be fully merged which caused
problems including a resource exhaustion.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
