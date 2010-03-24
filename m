From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: [PATCH 0/7] snd-asihpi playback improvement +
	others
Date: Thu, 25 Mar 2010 09:05:49 +1300
Message-ID: <4BAA709D.3060308@audioscience.com>
References: <1269332067-25959-1-git-send-email-linux@audioscience.com>
	<s5hvdcnt9mf.wl%tiwai@suse.de> <s5hvdcmq8rg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 05F7B1038A1
	for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2010 21:06:00 +0100 (CET)
Received: from [192.168.1.6]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0KZS00MAZYHP2920@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 25 Mar 2010 09:05:50 +1300 (NZDT)
In-reply-to: <s5hvdcmq8rg.wl%tiwai@suse.de>
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

Takashi Iwai wrote:
> OK, now I committed all your revised patches.
> Also firmware package is updated, too.

Great, thanks.

One last thing, please also remove from firmware/asihpi the files
dsp4300.bin and dsp5200.bin

Or I could send you the -185K binary diff that removed them ;)
with the following signoff:

Remove obsolete firmware.

Signed-off-by: Eliot Blennerhassett

thanks
