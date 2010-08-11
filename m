From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: ASoC: Make ams-delta/cx20442 pair back working for
 multi-component
Date: Wed, 11 Aug 2010 14:42:31 +0100
Message-ID: <1281534151.3080.111.camel@odin>
References: <201008110129.34662.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E7CD103868
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Aug 2010 15:42:38 +0200 (CEST)
Received: by wyb42 with SMTP id 42so133815wyb.38
	for <alsa-devel@alsa-project.org>; Wed, 11 Aug 2010 06:42:37 -0700 (PDT)
In-Reply-To: <201008110129.34662.jkrzyszt@tis.icnet.pl>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-08-11 at 01:29 +0200, Janusz Krzysztofik wrote:
> 1.
> After a static codec pointer removal from the sound/soc/codecs/cx20442.c code, 
> both codec and card specific tty line discipline functions lost their access 
> to the codec structure data. Arrange for passing the pointer back to the codec 
> tty ldisc bits from the card initialization code.
> 
> 2.
> Update incosistent codec device naming in the card code.
> 
> 3.
> Since a new element, control_data, has been added to the cx20442_priv 
> structure, it looks like the old snd_soc_codec->control_data may be scheduled 
> for removal. To avoid problems in the near future, use the 
> cx20442_priv->control_data instead of the snd_soc_codec->control_data 
> throughout the cx20442 code. In the ams-delta card code, check for the 
> snd_soc_codec->hw_write not NULL instead of the snd_soc_codec->control_data.
> 
> Created and tested on Amstrad Delta against 
> git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git,
> commit a212dd5b2e1da045cbf423c70c87f48265531de4.
> 
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
