From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ASoC:Question on strict sequence followed for
	trigger
Date: Thu, 29 Mar 2012 08:49:37 +0200
Message-ID: <4F740601.8080907@ladisch.de>
References: <1ea6fbaaca7ffeaa7b7325f18fe4e959.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id BF97E104353
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 08:46:24 +0200 (CEST)
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 3E29F20BDB
	for <alsa-devel@alsa-project.org>; Thu, 29 Mar 2012 02:46:18 -0400 (EDT)
In-Reply-To: <1ea6fbaaca7ffeaa7b7325f18fe4e959.squirrel@www.codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: gsantosh@codeaurora.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

gsantosh@codeaurora.org wrote:
> I see there is a strict sequence followed for trigger callback to codec
> dai, platform dai and cpu dai.
> In the below function of soc-core .
> int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd);
>
> In some scenarios we may require the sequence to be the other case to make
> sure the underlying DSP / codec is configured and triggered properly.

The trigger callback should do nothing but actually start the stream.
(In the ideal case, this would be setting one bit in a register of the
DMA controller.)

Any configuration should be done in hw_params.


Regards,
Clemens
