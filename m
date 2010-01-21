From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_pcm_hw_params_free() immediately after
 snd_pcm_hw_params() ???
Date: Thu, 21 Jan 2010 11:18:50 +0100
Message-ID: <4B582A0A.8030603@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id A5AF610384D
	for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2010 11:18:54 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Raymond Yau wrote:
> Is there any flags in substream which can indicate snd_xxx_hw_params() was
> called at first time since snd_xxx_hw_params() were called many times
> during OSS emulation (probing the supported rates , channels , .... ) ?

There is no such flag.  It is the responsibility of the driver to track
the resources it has allocated.

If a resource does not depend on the hardware parameters, it might be
a better idea to allocate/free it in the open/close callbacks.


Best regards,
Clemens
