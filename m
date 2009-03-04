From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: wm8510 pll settings
Date: Wed, 4 Mar 2009 14:50:40 +0000
Message-ID: <20090304145039.GE433@sirena.org.uk>
References: <49AE2CAA.8010005@microbit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E99851037EA
	for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2009 15:50:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <49AE2CAA.8010005@microbit.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jonas Andersson <jonas@microbit.se>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 04, 2009 at 08:24:26AM +0100, Jonas Andersson wrote:
> When setting WM8510_MCLKDIV the pll was turned off.
>
> When setting pll frequency you got twice the expected freq, because
> the  code calculated  with postscaler of 8,  but  the hardware divide by 4.
>
> Signed-off-by: Jonas Andersson <jonas@microbit.se>
>
Applied, thanks.
