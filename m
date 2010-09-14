From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: tlv320aic3x: Complete the
 soc-cache conversion
Date: Tue, 14 Sep 2010 13:04:58 +0100
Message-ID: <20100914120458.GE27029@rakim.wolfsonmicro.main>
References: <1284465289-4865-1-git-send-email-jhnikula@gmail.com>
	<1284465289-4865-3-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F323610387C
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Sep 2010 14:04:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1284465289-4865-3-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 14, 2010 at 02:54:49PM +0300, Jarkko Nikula wrote:
> Complete the phasing out of aic3x_read_reg_cache, aic3x_write_reg_cache,
> aic3x_read and aic3x_write calls.
> 
> This patch replaces the aic3x_read with codec->hw_read that points to a
> function implemented by soc-cache. There is no need to cache the value from
> chip since the functions using aic3x_read are interested only read-only
> bits.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

It'd be a bit nicer to do this by using snd_soc_read() here also and
marking the registers as volatile.  This makes the process much less
error prone since users can just use snd_soc_read() and the register
cache code will work out if it needs to go to the chip or not.
