From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: tpa6130a2: Revisit power-up sequence
Date: Mon, 8 Nov 2010 11:38:13 +0200
Message-ID: <201011081138.13288.peter.ujfalusi@nokia.com>
References: <1289206677-11886-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa01.nokia.com (smtp.nokia.com [147.243.1.47])
	by alsa0.perex.cz (Postfix) with ESMTP id 377FA2439F
	for <alsa-devel@alsa-project.org>; Mon,  8 Nov 2010 10:38:12 +0100 (CET)
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
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Monday 08 November 2010 10:57:57 ext Jarkko Nikula wrote:
> There are no known problems with current power-up sequence which first sets
> the /shutdown pin high and then enables the supply. However, swap the order
> so that the device is kept in shutdown/reset mode during the supply voltage
> transition since slowly rising voltages can usually cause problems if the
> device is not kept in reset.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Yes, it is safer to keep the amp in reset during voltage ramp.

Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
