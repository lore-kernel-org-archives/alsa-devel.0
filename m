From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: does snd_pcm_info_get_sync work at all?
Date: Fri, 18 May 2012 23:21:15 +0200
Message-ID: <4FB6BD4B.5010409@ladisch.de>
References: <1337323363-11449-1-git-send-email-ricardo.neri@ti.com>	<1337323363-11449-4-git-send-email-ricardo.neri@ti.com>
	<4FB6B521.4000901@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 5978A24340
	for <alsa-devel@alsa-project.org>;
	Fri, 18 May 2012 23:21:46 +0200 (CEST)
In-Reply-To: <4FB6B521.4000901@linux.intel.com>
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
> After looking a number of times at the code to start multiple devices at
> the same time, I wonder if the alsa-lib snd_pcm_info_get_sync() routine
> works at all.
>
> The documentation says "Because the drivers cannot guarantee the
> synchronization (sample resolution) on hardware lacking this feature,
> the #snd_pcm_info_get_sync() function returns synchronization ID,
> which is equal for hardware synchronized streams".

This is somewhat misleading.

> It seems some drivers set a value when opening the stream using the
> snd_pcm_set_sync() helper. What exactly is the purpose of this id

This ID has the same value for two streams if those streams _can_ be
started at exactly the same time.

> The value returned seems to be the card#, the same value no matter if
> streams are synchronized or not.

Typically, a card that supports simultaneous starting of multiple
streams does so for all its streams (with a register that has one bit
for each stream), so the card number is the correct ID to describe this
relationship.


Regards,
Clemens
