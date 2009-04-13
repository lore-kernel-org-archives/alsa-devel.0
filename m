From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: pxa-ssp.c fix clock/frame invert
Date: Mon, 13 Apr 2009 13:22:21 +0100
Message-ID: <20090413122221.GD11220@sirena.org.uk>
References: <1239198684.20192.8.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 057FB1037FA
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Apr 2009 14:22:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1239198684.20192.8.camel@brutus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Ribeiro <drwyrm@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, openezx-devel <openezx-devel@lists.openezx.org>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 08, 2009 at 10:51:24AM -0300, Daniel Ribeiro wrote:
> >From the pxa27x developers manual, Table 8-8 SSPSP Bit Definitions:
> 
> SCMODE(0): Data Driven (Falling), Data Sampled (Rising), Idle State (Low)
> SCMODE(1): Data Driven (Rising), Data Sampled (Falling), Idle State (Low)
> SCMODE(2): Data Driven (Rising), Data Sampled (Falling), Idle State (High)
> SCMODE(3): Data Driven (Falling), Data Sampled (Rising), Idle State (High)
> 

Applied, thanks.
