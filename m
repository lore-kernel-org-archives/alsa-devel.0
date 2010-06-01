From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ALSA/NUC900: Fix some codes according
 to Liam for nuc900 alsa driver.
Date: Tue, 1 Jun 2010 11:20:05 +0100
Message-ID: <20100601102005.GA863@rakim.wolfsonmicro.main>
References: <4C0474F3.3050503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 44E441039F1
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Jun 2010 12:20:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C0474F3.3050503@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 01, 2010 at 10:48:19AM +0800, Wan ZongShun wrote:
> Dear Liam & Mark,
> 
> This patch is to fix some codes according to
> Liam for nuc900 alsa driver.

So, these changes look like they're fine but since you've not provided a
changelog it's hard to tell for sure.  It also looks like you've got two
different changes in here, some of the code is adjusting the delays used
between register writes in reset while other bits change the code over
to using the standard method for checking for substream type.

As I said to you yesterday please do read and follow the instructions in
Documentation/SubmittingPatches - in particular, you need to include a
proper changelog in your mail and you shouldn't have any "Dear X" or
similar.

> Signed-off-by: Wan ZongShun<mcuos.com@gmail.com>

You're missing a space between your name and the e-mail address too.
