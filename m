From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: Build error if CONFIG_I2C=m &&
 CONFIG_SND_SOC=y
Date: Tue, 6 Dec 2011 14:09:41 +0000
Message-ID: <20111206140940.GG17194@sirena.org.uk>
References: <1323175404.30623.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 07B451039B7
	for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2011 15:09:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1323175404.30623.1.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 06, 2011 at 08:43:24PM +0800, Axel Lin wrote:

> I got below build error if CONFIG_I2C=m && CONFIG_SND_SOC=y.

>   LD      vmlinux
> sound/built-in.o: In function `snd_soc_codec_set_cache_io':
> last.c:(.text+0x2a0a8): undefined reference to `regmap_init_i2c'
> make: *** [vmlinux] Error 1

> ( I test the build on linux-next 20111206 )

If someone wants to do the Kconfig or whatever to handle that they're
welcome to but it's frankly unrealistic so...
