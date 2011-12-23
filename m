From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: au1x: Add .owner to struct
	snd_soc_card
Date: Fri, 23 Dec 2011 11:17:19 +0000
Message-ID: <20111223111718.GG2834@opensource.wolfsonmicro.com>
References: <1324605235.3108.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 03E42103FA3
	for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2011 12:17:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1324605235.3108.1.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Manuel Lauss <manuel.lauss@googlemail.com>, Ralf Baechle <ralf@linux-mips.org>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 23, 2011 at 09:53:55AM +0800, Axel Lin wrote:
> Add missing .owner of struct snd_soc_card. This prevents the module from being
> removed from underneath its users.

Applied, thanks.
