From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Reforming s3c2443 ac97 driver
Date: Thu, 21 Jan 2010 10:03:48 +0000
Message-ID: <20100121100348.GA18797@rakim.wolfsonmicro.main>
References: <29946650.33531262928531169.JavaMail.weblogic@epml17>
	<9A9547C8-08FD-4310-A69C-44CA8A3E01C2@opensource.wolfsonmicro.com>
	<1b68c6791001202258p7ef0ebcdt444a3be2eeaaff36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6FE3F10384D
	for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2010 11:03:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b68c6791001202258p7ef0ebcdt444a3be2eeaaff36@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, SeungHyun Choi <sh428.choi@samsung.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "graeme.gregory@wolfsonmicro.com" <graeme.gregory@wolfsonmicro.com>, "jassi.brar@samsung.com" <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 21, 2010 at 03:58:46PM +0900, jassi brar wrote:

> Both parts(platform_device interface and ALSA AC97 interface)
> of s3c2443-ac97.c needed so much reforming that I found rewriting the
> driver again a better option.
> The new driver is called 's3c-ac97.c' ... hoping the AC97 controller
> doesn't change in SoCs released after you read this mail :)

That sounds fine, though it will requier slightly more cross tree
coordination with there being changes in both arch/arm and sound/soc.
Please go ahead.
