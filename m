From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC] Initialize volumes of HD-audio slave ctls
Date: Fri, 9 Mar 2012 07:04:23 +0800
Message-ID: <CAN8cciZNJvo_60b3icNT61+oy9n1U0Qy33u+T98OexPKwrL__A@mail.gmail.com>
References: <s5haa3ryuxb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C1F2C1041B5
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 00:04:23 +0100 (CET)
Received: by wgbed3 with SMTP id ed3so769525wgb.20
	for <alsa-devel@alsa-project.org>; Thu, 08 Mar 2012 15:04:23 -0800 (PST)
In-Reply-To: <s5haa3ryuxb.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2012/3/8, Takashi Iwai <tiwai@suse.de>:
> Hi,
>
> the patch below is an attempt to initialize the volume / mutes of
> slave controls (such as "Headphone", "Speaker") with vmaster in
> HD-audio, so that the sound can come out only by changing the master
> volume/mute.
>
> We have thought that such initializations could be done well in
> alsactl init, but it seems that not everyone installs the latest and
> greatest alsactl, and there is always a risk that any new controls may
> be added before alsactl is updated and released.  Since the master
> volume is set muted, the risk by this change should be low.
>
> patch_cirrus.c still doesn't support this because it's handling
> vmaster by itself, but it can be fixed later, too.
>
> If anyone has a concern by this, please let me know.
>

Can you explain the dB calculation of the volume controls when there
is a "virtual master" ?

The Documentation only mention that all the slaves must have the same dB range

There are codecs which only have "Headphone switch" but no "Headphone Volume"
(e.g. alc660) and some 4 channels codecs still not implemented (e.g.
ad1984 and ad1884) "Headphone Volume" control by using the extra DAC
