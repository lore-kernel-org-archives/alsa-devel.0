From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: CS4271 codec support
Date: Wed, 8 Dec 2010 14:58:01 +0000
Message-ID: <20101208145801.GM16418@rakim.wolfsonmicro.main>
References: <1291809772.31916.4.camel@r60e>
	<20101208130720.GB2716@pulham.picochip.com>
	<20101208133935.GI16418@rakim.wolfsonmicro.main>
	<20101208144757.GD2716@pulham.picochip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C9791103800
	for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2010 15:58:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20101208144757.GD2716@pulham.picochip.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jamie Iles <jamie@jamieiles.com>
Cc: alsa-devel@alsa-project.org, Alexander <subaparts@yandex.ru>, ryan@bluewatersys.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 08, 2010 at 02:47:57PM +0000, Jamie Iles wrote:

> Ahh, thanks for the explanation, I completely misunderstood the way that the 
> codecs were selected by the arch's in sound/soc/* and assumed that they were 
> user selectable options.

They're not user selectable as you have to write explicit code to glue
the machine together - that per machine code just selects the CODEC
drivers it needs.
