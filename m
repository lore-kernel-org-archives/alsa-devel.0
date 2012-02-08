From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Multiple channels mapping
Date: Wed, 08 Feb 2012 10:18:29 +0100
Message-ID: <4F323DE5.4050108@ladisch.de>
References: <4F31C988.3090201@codeaurora.org> <s5hwr7xln03.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 1EC94103D71
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 10:16:22 +0100 (CET)
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 7E1372029F
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 04:16:21 -0500 (EST)
In-Reply-To: <s5hwr7xln03.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Currently the channel-mapping information is a missing piece in ALSA
> framework, and it's a very long-standing item on my TODO list.
>
> The implementation itself should be easy, but the only question is the
> API design.  If you have a good proposal, please speak up.

TLVs on media controller entities.

I really should complete those patches ...


Regards,
Clemens
