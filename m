From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: [patch] Add a software amplifier plugin
Date: Wed, 01 Aug 2007 16:26:53 +0400
Message-ID: <46B07C0D.5040202@aknet.ru>
References: <46B07580.6050705@aknet.ru> <s5hejintqar.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (241-226.umostel.ru [77.246.241.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 26BE22459D
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Aug 2007 14:28:00 +0200 (CEST)
In-Reply-To: <s5hejintqar.wl%tiwai@suse.de>
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

Hello.

Takashi Iwai wrote:
> Did you try the recent softvol plugin?
Yep, I tried it for the whole day with
alsa-lib-1.0.14, trying to feed it with
the max_dB value to no avail.

> It supports already amplifier (> 0dB), not only attenuation.
Oh, it does so only in hg, not in 1.0.14,
now I see.
Well, it seems to me that my plugin gives
a way better quality (doing sine amplification,
while yours probably does linear), but then
yes, there is no point for the new plugin
indeed.
