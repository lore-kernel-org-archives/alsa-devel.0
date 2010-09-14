From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: tlv320aic3x: Use snd_soc_read
 and snd_soc_write
Date: Tue, 14 Sep 2010 12:59:25 +0100
Message-ID: <20100914115924.GC27029@rakim.wolfsonmicro.main>
References: <1284465289-4865-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A43A8103866
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Sep 2010 13:59:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1284465289-4865-1-git-send-email-jhnikula@gmail.com>
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

On Tue, Sep 14, 2010 at 02:54:47PM +0300, Jarkko Nikula wrote:
> Start phasing out aic3x_read_reg_cache, aic3x_write_reg_cache, aic3x_read and
> aic3x_write calls in order to switch to soc-cache helpers.
> 
> This patch replaces aic3x_read_reg_cache and aic3x_write with snd_soc_read
> and snd_soc_write. This is basically null-op since .read and .write in
> soc_codec_dev_aic3x points to aic3x_read_reg_cache and aic3x_write.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
