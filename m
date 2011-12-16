From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Remove unused variables in wm9090.c
Date: Fri, 16 Dec 2011 13:54:07 +0100
Message-ID: <20111216125406.GB2710@opensource.wolfsonmicro.com>
References: <1324021750.15709.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B37F71038FC
	for <alsa-devel@alsa-project.org>; Fri, 16 Dec 2011 13:54:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1324021750.15709.2.camel@phoenix>
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

On Fri, Dec 16, 2011 at 03:49:10PM +0800, Axel Lin wrote:
> Fix below build warnings:
>   CC      sound/soc/codecs/wm9090.o
> sound/soc/codecs/wm9090.c: In function 'wm9090_set_bias_level':
> sound/soc/codecs/wm9090.c:496: warning: unused variable 'ret'
> sound/soc/codecs/wm9090.c:496: warning: unused variable 'i'
> sound/soc/codecs/wm9090.c:495: warning: unused variable 'reg_cache'
> sound/soc/codecs/wm9090.c: In function 'wm9090_i2c_remove':
> sound/soc/codecs/wm9090.c:658: warning: unused variable 'wm9090'

Future changes that need a bit more testing deal with all these.
