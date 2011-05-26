From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Add correct hw
 registers to Line1 cross connect muxes
Date: Thu, 26 May 2011 22:07:55 +0800
Message-ID: <20110526140754.GC15094@opensource.wolfsonmicro.com>
References: <1306399022-4490-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 724341038AD
	for <alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 16:08:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1306399022-4490-1-git-send-email-jhnikula@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 26, 2011 at 11:37:02AM +0300, Jarkko Nikula wrote:
> Commit af46800 ("ASoC: Implement mux control sharing") revealed that
> "Left Line1[L | R] Mux" and "Right Line1[L | R] Mux" widgets were pointing
> to the same kcontrols and codec registers and thus soc-core falsely detected
> them as shared controls. This is actually wrong since there are separate
> registers in hardware that configure Line1L to RADC and Line1R to LADC cross
> connects so these muxes should not be shared.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
