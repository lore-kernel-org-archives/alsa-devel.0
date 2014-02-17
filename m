From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: uda134x: Use core for applying
	symmetry constraitns
Date: Mon, 17 Feb 2014 10:10:45 +0100
Message-ID: <5301D215.3010605@metafoo.de>
References: <1392586537-8198-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-011.synserver.de (smtp-out-221.synserver.de
 [212.40.185.221])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E241261AFC
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2014 10:10:34 +0100 (CET)
In-Reply-To: <1392586537-8198-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

 > [...]
> -	if (substream == uda134x->slave_substream) {
> +	if (dai->active) {

Meh, this is obviously broken since dai->active gets incremented when the 
device is opened, so this condition is always true. The best is probably to 
check if dai->rate != 0.
