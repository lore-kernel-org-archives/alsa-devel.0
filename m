From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: About 'SNDRV_PCM_CLASS_MULTI' for devices with
	multi-channels
Date: Thu, 20 Feb 2014 23:25:31 +0900
Message-ID: <5306105B.9020905@sakamocchi.jp>
References: <5304C64D.3090400@sakamocchi.jp> <530508BB.6060802@canonical.com>
 <53056860.7090500@sakamocchi.jp> <s5h38jexldh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id C5D1C261A63
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 15:25:40 +0100 (CET)
In-Reply-To: <s5h38jexldh.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

> Right.  And the likely reason is that such a differentiation doesn't
> help much.

I thought usage of this macro can tell applications that the PCM 
channels are not for surround sound.

But for this purpose, card configuration is better. Applications can get 
to know by seeking 'surround' PCM devices such like 'surround51'.

 > You can still use your device for driving 5.1 surround :)

It's not my intention. I'm considering about the way to prevent 
applications from using the devices for surround sound.

I don't prepare for card configuration. So devices which my drivers 
support have no 'surround' PCM devices.

 > So, I rather would like to keep them RIP. Maybe worth to remove it
 > now.

Yes.

In the same reason, 'SND_PCM_SUBCLASS_MULTI_MIX' should be removed. As a 
result, 'SND_PCM_SUBCLASS_XXX', 'struct snd_pcm_info.dev_subclass' are 
also needless...


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp
