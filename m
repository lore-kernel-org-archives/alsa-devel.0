From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: underruns and strange code in pcm_rate.c (and
	patch)
Date: Thu, 08 Nov 2007 12:13:29 +0300
Message-ID: <4732D339.5060509@aknet.ru>
References: <472E5A64.6010705@aknet.ru>	<s5hy7dbvcgf.wl%tiwai@suse.de>	<473091F4.80105@aknet.ru>	<s5h8x5auxz3.wl%tiwai@suse.de>	<473206A7.1000305@aknet.ru>	<s5hpryl9wl1.wl%tiwai@suse.de>	<4732C87E.8000706@aknet.ru>
	<s5hbqa5th8e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.AKNET.ru [77.246.241.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C6F42480E
	for <alsa-devel@alsa-project.org>; Thu,  8 Nov 2007 10:12:14 +0100 (CET)
In-Reply-To: <s5hbqa5th8e.wl%tiwai@suse.de>
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
> Not really.  It checks appl_ptr of the client, not hw_ptr.  appl_ptr
> is what app writes.  So, as long as app writes only the period size,
> the hack isn't triggered.
No, its not that simple.
When the partially filled period
on slave appears, it then gets
populated back. Namely, snd_pcm_write_areas()
takes it via snd_pcm_avail_update().
It then adjusts the "frames" accordingly,
and then also "size" gets infected.
Then the hack triggers.
