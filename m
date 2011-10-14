From: Peter Hsiang <Peter.Hsiang@maxim-ic.com>
Subject: Re: [PATCH] ASoC: max98095: Convert codec->hw_write to
	snd_soc_write
Date: Fri, 14 Oct 2011 10:40:58 -0700
Message-ID: <B2150E1E4418E1438554A300EA5040E40DDFD2E54E@ITSVLEX06.it.maxim-ic.internal>
References: <1318563798.9296.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from antispam02.maxim-ic.com (antispam02.maxim-ic.com
	[205.153.101.183])
	by alsa0.perex.cz (Postfix) with ESMTP id AAF53243C1
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Oct 2011 19:41:03 +0200 (CEST)
In-Reply-To: <1318563798.9296.1.camel@phoenix>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 14, 2011, Axel Lin wrote:
> codec->hw_write is broken now, convert codec->hw_write to
> snd_soc_write.
> 

The hardware has 2 banks of registers sharing a section in I2C register space.
The 1st bank is the primary one and is cached.  
The 2nd bank is for loading coefficients only and they do not need cache.
These coefficients registers are therefore direct writes.
Changing this to a cached write will overwrite the cache.

Peter
