From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 2/3] ALSA: snd-usb-caiaq: set up internal
 sample pointer positions in trigger callback
Date: Fri, 10 Sep 2010 09:27:48 +0200
Message-ID: <4C89DDF4.8030200@ladisch.de>
References: <1284090901-4533-1-git-send-email-daniel@caiaq.de>
	<1284090901-4533-2-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 2701D243A3
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 09:27:29 +0200 (CEST)
In-Reply-To: <1284090901-4533-2-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> Calling prepare() on a stream which is already active

... would be a bug; snd_pcm_pre_prepare() in sound/core/pcm_native.c
should prevent this.  Why do you feel the need for this patch?

> shouldn't touch the sample pointer positions. This code belongs into
> the trigger callback, so move it there.

The trigger callback should execute as fast as possible; any
initialization that isn't need to directly start the stream should go
into the prepare callback.


Regards,
Clemens
