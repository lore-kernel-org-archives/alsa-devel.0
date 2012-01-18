From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v5] ASoC: Apply msbits constraint for
 sample size bigger than the msbits
Date: Wed, 18 Jan 2012 16:35:35 +0100
Message-ID: <4F16E6C7.5070502@ladisch.de>
References: <1326899114-26979-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 8254B2459E
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 16:33:32 +0100 (CET)
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id DDDBD20CC0
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 10:33:31 -0500 (EST)
In-Reply-To: <1326899114-26979-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Peter Ujfalusi wrote:
> We run the loop as long as the sample size is bigger than the requested
> msbits.

> +	while (sample_sizes[i] > bits && i < ARRAY_SIZE(sample_sizes)) {

This will overrun sample_sizes[] if bits < 8.


Regards,
Clemens
