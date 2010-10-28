From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: tpa6130a2: Fix unbalanced regulator
	disables
Date: Thu, 28 Oct 2010 15:43:28 +0300
Message-ID: <201010281543.29130.peter.ujfalusi@nokia.com>
References: <1288263940-4602-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa01.nokia.com (smtp.nokia.com [147.243.1.47])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B6452446F
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Oct 2010 14:43:29 +0200 (CEST)
In-Reply-To: <1288263940-4602-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thursday 28 October 2010 14:05:40 ext Jarkko Nikula wrote:
> This driver has unbalanced regulator_disable when doing module loading and
> unloading. This is because tpa6130a2_probe followed by tpa6130a2_remove
> calls twice tpa6130a2_power(0). Fix this by implementing a state checking
> in tpa6130a2_power.

Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
