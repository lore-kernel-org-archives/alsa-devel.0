From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_mixer_selem_get_playback_volume return value
 outside allowed range
Date: Thu, 17 Jun 2010 16:01:00 +0200
Message-ID: <4C1A2A9C.3000902@ladisch.de>
References: <AANLkTikQ5cUjiAtVWhLaR348-eF3xzPFoBkfmEdefJU8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 61A2C24441
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Jun 2010 16:01:03 +0200 (CEST)
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E8D97F8A8B
	for <alsa-devel@alsa-project.org>; Thu, 17 Jun 2010 10:01:01 -0400 (EDT)
Received: from [10.1.2.19] (srv004.schk01.int.dmc-one.com [85.232.8.141])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 731C94D032B
	for <alsa-devel@alsa-project.org>; Thu, 17 Jun 2010 10:01:01 -0400 (EDT)
In-Reply-To: <AANLkTikQ5cUjiAtVWhLaR348-eF3xzPFoBkfmEdefJU8@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Raymond Yau wrote:
> Should snd_mixer_selem_get_playback_volume() perform range check ?

No, it's the responsibility of the control implementation to return
valid values (and to check that values that are being set are valid).


Regards,
Clemens
