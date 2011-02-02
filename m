From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 2.6.38] ASoC: fill in
 snd_soc_pcm_runtime.card before calling snd_soc_dai_link.init()
Date: Wed, 02 Feb 2011 20:48:45 +0000
Message-ID: <1296679725.3333.23.camel@odin>
References: <201102022111.42196.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 157F724374
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2011 21:48:49 +0100 (CET)
Received: by wwe15 with SMTP id 15so399654wwe.20
	for <alsa-devel@alsa-project.org>; Wed, 02 Feb 2011 12:48:48 -0800 (PST)
In-Reply-To: <201102022111.42196.jkrzyszt@tis.icnet.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-02-02 at 21:11 +0100, Janusz Krzysztofik wrote:
> The .card member of the snd_soc_pcm_runtime structure pointed to by the 
> snd_soc_dai_link.init() argument used to be initialized before the 
> function being called. This has changed, probably unintentionally, 
> after recent refactorings. Since the function implementations are free 
> to make use of this pointer, move its assignment back before the 
> function is called to avoid NULL pointer dereferences.
> 
> Created and tested on Amstrad Delta againts linux-2.6.38-rc2
> 
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
