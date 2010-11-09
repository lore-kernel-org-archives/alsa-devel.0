From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: tpa6130a2: Revisit power-up sequence
Date: Tue, 09 Nov 2010 21:39:54 +0000
Message-ID: <1289338794.3290.43.camel@odin>
References: <1289206677-11886-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 15C59103849
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2010 22:40:04 +0100 (CET)
Received: by wyb33 with SMTP id 33so5356809wyb.38
	for <alsa-devel@alsa-project.org>; Tue, 09 Nov 2010 13:40:03 -0800 (PST)
In-Reply-To: <1289206677-11886-1-git-send-email-jhnikula@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-11-08 at 10:57 +0200, Jarkko Nikula wrote:
> There are no known problems with current power-up sequence which first sets
> the /shutdown pin high and then enables the supply. However, swap the order
> so that the device is kept in shutdown/reset mode during the supply voltage
> transition since slowly rising voltages can usually cause problems if the
> device is not kept in reset.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---
>  sound/soc/codecs/tpa6130a2.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
> 

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
