From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Is snd_pcm_hw_params_set_period_time_near the same
 as sampling period?
Date: Fri, 24 Jul 2009 10:50:48 +0200
Message-ID: <4A6975E8.2030208@ladisch.de>
References: <4A6880B0.3000903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id C6FE6103A51
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jul 2009 10:50:41 +0200 (CEST)
In-Reply-To: <4A6880B0.3000903@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guilherme Longo <grlongo.ireland@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Guilherme Longo wrote:
> I am trying to understand a piece of a code  I am  studing .
> What does exactly the functions snd_pcm_hw_params_set_period_time_near  
> sets?

The period time.

> In my understand period time should be the time between 2 consecutive 
> samples,

In ALSA, a period is the interval between consecutive interrupts from
the sound card; this is the same as a fragment in OSS.

When the application tries to write/read more than than would be
available, ALSA waits until the next period boundary before checking
again.


HTH
Clemens
