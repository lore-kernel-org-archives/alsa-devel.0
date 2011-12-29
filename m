From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 02/14] ASoC: Convert cs4270 to
	devm_kzalloc()
Date: Thu, 29 Dec 2011 18:17:32 +0000
Message-ID: <20111229181731.GI2909@opensource.wolfsonmicro.com>
References: <1325130983.19977.2.camel@phoenix>
	<1325131102.19977.4.camel@phoenix> <4EFC8CB3.8050507@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 06637103A2D
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2011 19:17:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4EFC8CB3.8050507@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: Axel Lin <axel.lin@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 29, 2011 at 03:52:30PM +0000, Tabi Timur-B04825 wrote:
> Axel Lin wrote:
> > Signed-off-by: Axel Lin<axel.lin@gmail.com>

> I won't be able to test this for at least another week, so I can't give 
> it an official ACK yet.

It's OK to ack things based purely off code review (epecially for simple
transformations like this).
