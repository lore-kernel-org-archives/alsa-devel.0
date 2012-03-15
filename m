From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 1/2] ASoC: core: Fix obscure leak of
	runtime array
Date: Thu, 15 Mar 2012 09:31:12 +0000
Message-ID: <1331803872.4381.0.camel@odin>
References: <1331760044-16857-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
	[74.125.149.240])
	by alsa0.perex.cz (Postfix) with ESMTP id C1EE310B8CF
	for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2012 10:31:17 +0100 (CET)
Received: by werc1 with SMTP id c1so3479182wer.35
	for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2012 02:31:14 -0700 (PDT)
In-Reply-To: <1331760044-16857-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Grant Likely <grant@secretlab.ca>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-03-14 at 21:20 +0000, Mark Brown wrote:
> We're currently not freeing card->rtd in cases where the card is
> unregistered before being registered - convert it to devm_kzalloc() to
> make sure that happens.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Both

Acked-by: Liam Girdwood <lrg@ti.com>
