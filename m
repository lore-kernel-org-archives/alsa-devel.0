From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: DMA interrupt not getting triggered
Date: Fri, 5 Feb 2010 17:35:06 +0900
Message-ID: <1b68c6791002050035g556ca9c1s4669b9b2532f8746@mail.gmail.com>
References: <25591311.716591265357837890.JavaMail.weblogic@epml09>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 12F8724339
	for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2010 09:35:06 +0100 (CET)
Received: by vws17 with SMTP id 17so1268755vws.38
	for <alsa-devel@alsa-project.org>; Fri, 05 Feb 2010 00:35:06 -0800 (PST)
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
To: anish.singh@samsung.com
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "JaroslavKyselaperex@perex.cz" <JaroslavKyselaperex@perex.cz>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 5, 2010 at 5:17 PM, ANISH KUMAR <anish.singh@samsung.com> wrote:
> I am facing problem related to DMA interrupt not getting triggered some times(out of 5 times one time it is happening) causing application to wait for the buffers(hw_ptr = 0) and no sound because of this.
> I am using samsung soc with DMA controller PL080.I tried increasing periods_min to 4 but still no result.
> I am using 2.6.29 kernel version.
As I already suggested you on direct online chat, your best bet is to
either switch to
newer kernel or backport latest dma driver(if ur customer demands 2.6.29).
Although it might just be ur test application/method.
