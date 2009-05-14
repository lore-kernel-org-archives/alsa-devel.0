From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4 v3] pxa2xx-i2s: Proper hw	initialization
Date: Thu, 14 May 2009 20:49:59 +0100
Message-ID: <20090514194958.GP28291@sirena.org.uk>
References: <4A0BD586.8010406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D4FD310393B
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 21:50:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A0BD586.8010406@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Karl Beldan <karl.beldan@gmail.com>
Cc: Eric Miao <eric.miao@marvell.com>, alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Matthieu Dumont <matthieu.dumont@mobile-devices.fr>
List-Id: alsa-devel@alsa-project.org

On Thu, May 14, 2009 at 10:25:42AM +0200, Karl Beldan wrote:

> @@ -106,10 +106,8 @@ static int pxa2xx_i2s_startup(struct snd_pcm_substream
> *substream,

Unfortunately your MUA is mangling the patches by word wrapping.  I've
resolved the problems by hand this once but you might want to take a
look at Documentation/email-clients.txt for tips on setting things up.

Anyway, they're all applied now and pass smoke testing here - thanks a
lot!
