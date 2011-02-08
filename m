From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: MIDI playback not keeping steady time with recent
 kernels
Date: Tue, 08 Feb 2011 16:40:08 +0100
Message-ID: <4D5163D8.8010708@ladisch.de>
References: <559v18-575.ln1@ppp121-45-136-118.lns11.adl6.internode.on.net>	<bma128-mok.ln1@ppp121-45-136-118.lns11.adl6.internode.on.net>	<elo128-8u4.ln1@ppp121-45-136-118.lns11.adl6.internode.on.net>
	<11c228-725.ln1@ppp121-45-136-118.lns11.adl6.internode.on.net>
	<4D512EA9.2020909@ladisch.de> <4D515EFD.3040909@internode.on.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 4CB662436F
	for <alsa-devel@alsa-project.org>; Tue,  8 Feb 2011 16:39:08 +0100 (CET)
In-Reply-To: <4D515EFD.3040909@internode.on.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arthur Marsh <arthur.marsh@internode.on.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Arthur Marsh wrote:
> OK, I applied this patch.
> 
> When the MIDI file was playing:
> I still experienced some slow-down and speed-up under heavy load.

Is "some" less than previously?

It shouldn't be possible to get a speed-up; this looks as if your
computer's clock is not stable.  Are you using an NTP daemon?

What kind of heave load is this?  Does the same happen if you execute
"yes | tail" in a shell?


Regards,
Clemens
