From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH] ASoC: Fix reg_cache_size for stac9766
Date: Mon, 5 Dec 2011 22:12:51 +0800
Message-ID: <CAF+7xWnNKSAS764jeZJGc9enXhSA2snX2b0pbWAaVOB=QXKN8g@mail.gmail.com>
References: <1323050764.6086.1.camel@phoenix>
	<20111205133128.GN11150@opensource.wolfsonmicro.com>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 5AC25103A6F
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 15:13:14 +0100 (CET)
Received: by lahe6 with SMTP id e6so1736601lah.38
	for <alsa-devel@alsa-project.org>; Mon, 05 Dec 2011 06:13:12 -0800 (PST)
In-Reply-To: <20111205133128.GN11150@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

2011/12/5 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Mon, Dec 05, 2011 at 10:06:04AM +0800, Axel Lin wrote:
>> reg_cache_size is supposed to be the number of elements in the register cache,
>> not the size in bytes.
>
> Applied, though note that in this case as the register values are 8 bits
> the two numbers are exactly the same so this is a coding style fix only
> (but still useful!).

Actually, the register values are 16 bits.
static const u16 stac9766_reg[] = {

Axel
