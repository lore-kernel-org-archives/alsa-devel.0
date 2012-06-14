From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 2/2] ALSA: hda: support for wallclock
	timestamps
Date: Thu, 14 Jun 2012 10:15:35 +0200
Message-ID: <4FD99DA7.60206@ladisch.de>
References: <1339619192-2733-1-git-send-email-pierre-louis.bossart@linux.intel.com>
	<1339619192-2733-3-git-send-email-pierre-louis.bossart@linux.intel.com>
	<CA+v+29goT9xmx-h4Fuiyg6wuZFCvBvuFx=1P_=e8CfqoQFahMA@mail.gmail.com>
	<4FD96F57.3090502@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 5E39824339
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Jun 2012 10:15:38 +0200 (CEST)
In-Reply-To: <4FD96F57.3090502@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pierre-Louis Bossart wrote:
> As long as you have 2 periods or events per 179s, the wrap-around can
> be detected without any issues. It's explicitely handled in the code.

AFAICS there is no code that enforces the 179s restriction.

And why are you using a separate wallclock timer instead of the sample
count?  Does the higher resolution result in a noticeable improvement?

How should userspace detect streams whose sample clock is not
synchronous with this wall clock, such as digital inputs?


Regards,
Clemens
