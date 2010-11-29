From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC][PATCH 4/5] ASoC: Fix missing
	spin_unlock_irqrestore
Date: Mon, 29 Nov 2010 11:47:00 +0000
Message-ID: <20101129114700.GP30360@rakim.wolfsonmicro.main>
References: <1291023491.22911.1.camel@mola>
 <1291023767.22911.9.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E34C110382C
	for <alsa-devel@alsa-project.org>; Mon, 29 Nov 2010 12:47:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1291023767.22911.9.camel@mola>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel <linux-kernel@vger.kernel.org>, Wan ZongShun <mcuos.com@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 29, 2010 at 05:42:47PM +0800, Axel Lin wrote:

> I don't have this hardware handy, could you help to test this patch
> if you think this patch is ok.

I've applied everything except this one - Wan, can you let us know how
the testing goes please?
