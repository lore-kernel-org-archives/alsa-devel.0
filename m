From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2 3/3] ASoC: tlv320aic3x: Complete the
 soc-cache conversion
Date: Tue, 14 Sep 2010 16:08:55 +0100
Message-ID: <20100914150855.GA25070@rakim.wolfsonmicro.main>
References: <20100914125510.GA21715@rakim.wolfsonmicro.main>
	<1284472787-9881-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B8FEE103801
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Sep 2010 17:08:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1284472787-9881-1-git-send-email-jhnikula@gmail.com>
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

On Tue, Sep 14, 2010 at 04:59:47PM +0300, Jarkko Nikula wrote:
> Complete the phasing out of aic3x_read_reg_cache, aic3x_write_reg_cache,
> aic3x_read and aic3x_write calls.
> 
> This patch uses in aic3x_read the codec->hw_read that points to a function
> implemented by soc-cache. Only use for aic3x_read is if wanting to read
> volatile bits from those registers that has both read-only and read/write
> bits. All other cases should use snd_soc_read.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
