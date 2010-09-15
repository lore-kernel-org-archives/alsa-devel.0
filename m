From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Remove needless codec->bias_level
 assignment to SND_SOC_BIAS_OFF
Date: Wed, 15 Sep 2010 12:28:49 +0100
Message-ID: <20100915112849.GC4254@rakim.wolfsonmicro.main>
References: <1284467078-6164-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9B69C24543
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Sep 2010 13:28:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1284467078-6164-1-git-send-email-jhnikula@gmail.com>
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

On Tue, Sep 14, 2010 at 03:24:38PM +0300, Jarkko Nikula wrote:
> This assignment is done by the snd_soc_register_codec so there is no need
> to redo it in probe function of a codec driver.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

Applied, thanks.
