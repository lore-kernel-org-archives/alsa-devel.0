From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: concept of substream...
Date: Wed, 08 Feb 2012 10:16:55 +0100
Message-ID: <4F323D87.2020503@ladisch.de>
References: <1328691900.26182.149.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id A8455103D64
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 10:14:51 +0100 (CET)
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 18BB12121D
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 04:14:48 -0500 (EST)
In-Reply-To: <1328691900.26182.149.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Vinod Koul wrote:
> I was trying to understand the concept of substream. So can we have a
> device which can have support say 5 substreams and these are controlled
> (start/stop) independent of each other.

Yes.

> At any instance we can have any number of substreams active and runtime
> we should be able to activate/deactivate a particular substream.

If by "active" you mean opened or running, yes.


Please note that when opening a device without specifying a substream
number, ALSA will open the first free one.  This implies that all
substreams should go the same output (i.e., be mixed together).


Regards,
Clemens
