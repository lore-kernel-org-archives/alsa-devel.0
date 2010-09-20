From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2 1/4] ASoC: tlv320aic3x: Move
	regulator	management from i2c to soc domain
Date: Mon, 20 Sep 2010 10:26:38 +0100
Message-ID: <20100920092637.GA31167@sirena.org.uk>
References: <1284968354-12536-1-git-send-email-jhnikula@gmail.com>
	<1284968354-12536-2-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 44ED3103818
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Sep 2010 11:26:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1284968354-12536-2-git-send-email-jhnikula@gmail.com>
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

On Mon, Sep 20, 2010 at 10:39:11AM +0300, Jarkko Nikula wrote:
> It will be easier to keep regulator enable/disable calls in sync when dynamic
> regulator management is added if regulator management is moved from
> aic3x_i2c_probe/_remove to aic3x_probe/_remove.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
