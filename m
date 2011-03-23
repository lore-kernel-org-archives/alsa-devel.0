From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Bad file descriptor : -EBADFD
Date: Wed, 23 Mar 2011 16:54:58 +0100
Message-ID: <4D8A17D2.6040305@ladisch.de>
References: <16F32A3F9AF4E441B752BCD79C151ACA69D0BB56B7@EXGMBX01.sasken.com>,
	<4D89D9DB.3060001@ladisch.de>
	<16F32A3F9AF4E441B752BCD79C151ACA69D0BB56B8@EXGMBX01.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 0BA832441A
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2011 16:53:32 +0100 (CET)
In-Reply-To: <16F32A3F9AF4E441B752BCD79C151ACA69D0BB56B8@EXGMBX01.sasken.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Irfan Shaikh <irfan.shaikh@sasken.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Irfan Shaikh wrote:
> I have used following check and it is success.
> 
>  if (snd_pcm_hw_params(alsaParams->playback_handle,                                  \
>                           alsaParams->hwparams_playback) < 0)

Check the device's current state with snd_pcm_state(); it should be PREPARED.


Regards,
Clemens
