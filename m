From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: can't find snd_card_next!
Date: Wed, 01 Jul 2009 16:53:43 +0200
Message-ID: <4A4B7877.2060602@ladisch.de>
References: <20090626082750.6D1B210092@gold.linx.net>	<s5hzlbrv76f.wl%tiwai@suse.de>	<d54969c50906292054j77aa8dd5ha0e2954b1e793f38@mail.gmail.com>	<b0bb99640906292307o13c2d842nbf3a078590cee911@mail.gmail.com>	<s5h8wjai600.wl%tiwai@suse.de>	<b0bb99640906301256g64ee3aa1yc66364d3800c934a@mail.gmail.com>	<1246392149.11792.8.camel@localhost>
	<4A4B739C.7050001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id C2EC52447F
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Jul 2009 16:53:32 +0200 (CEST)
In-Reply-To: <4A4B739C.7050001@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guilherme <grlongo.ireland@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Guilherme wrote:
> I studing the aplay program and there is a function that I can't find in 
> any header.
> Ive tried asound.h and asoundlib.h among other but without success!
> [...]
> Where is the snd_card_next() function?

$ grep snd_card_next /usr/include/alsa/*
/usr/include/alsa/control.h:int snd_card_next(int *card);


HTH
Clemens
