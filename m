From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH] ALSA: hda_intel: disable corb rirb when
 single_cmd active
Date: Wed, 11 Nov 2009 12:05:39 -0700
Message-ID: <4AFB0B03.1010303@boundarydevices.com>
References: <1257276157-7164-1-git-send-email-troy.kisky@boundarydevices.com>	<s5hd43yzov7.wl%tiwai@suse.de>	<4AF1D9D0.9080007@boundarydevices.com>	<s5h7hu5cv01.wl%tiwai@suse.de>	<4AF32A8B.4050404@boundarydevices.com>	<s5h3a4s86j7.wl%tiwai@suse.de>	<s5hiqdo80xq.wl%tiwai@suse.de>	<4AF4C6E7.8010807@boundarydevices.com>	<s5hfx8qybfx.wl%tiwai@suse.de>	<4AF86F3F.9020709@boundarydevices.com>	<s5hhbt2g7gp.wl%tiwai@suse.de>	<4AF9D7EF.6000800@boundarydevices.com>
	<s5hzl6t608p.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth00.csee.onr.siteprotect.com
	(smtpauth00.csee.onr.siteprotect.com [64.26.60.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 1CEE924591
	for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2009 20:05:54 +0100 (CET)
In-Reply-To: <s5hzl6t608p.wl%tiwai@suse.de>
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
Cc: pshou@realtek.com.tw, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Yes, in theory.  But this doesn't happen actually because you usually
> read the response often.  The read sequence synchronizes.
> 
> 
Can resume type processing send a lot of verbs without waiting for a response?

Speaking of synchronizing, if 2 different processes simultaneously send
different command verbs to the same codec, won't they both read the response
of the last verb sent? Or is there locking somewhere to prevent this?


Troy
