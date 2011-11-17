From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 2/2] Improve hw_params documentation
Date: Thu, 17 Nov 2011 14:27:51 +0100
Message-ID: <4EC50BD7.1050703@ladisch.de>
References: <20111116195607.GI30602@foghorn.codeweavers.com>	<4EC42907.80104@ladisch.de>	<20111116213135.GJ30602@foghorn.codeweavers.com>
	<CAN8cciYAvUuBScTDTVsuBVaUwvisizgX8TKtyrH9faS5J9090w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id C822E244F3
	for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2011 14:27:55 +0100 (CET)
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id D8F5D203E8
	for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2011 08:27:52 -0500 (EST)
Received: from [10.1.2.56] (unknown [94.101.37.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 61934482545
	for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2011 08:27:52 -0500 (EST)
In-Reply-To: <CAN8cciYAvUuBScTDTVsuBVaUwvisizgX8TKtyrH9faS5J9090w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Raymond Yau wrote:
> The logic of your program is wrong since your program did not set
> channel, rate and format

It is allowed to not set some parameters; snd_pcm_hw_params() then
chooses some random values for them.

> The buffer and period calculation is only valid after you have choose
> the format and channels

This is wrong; parameters can be set in any order.
(As long as format/channels are not yet set, the exact relationship
between frames and bytes is not yet known, but this is handled by
the parameters being intervals.)


Regards,
Clemens
