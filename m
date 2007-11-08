From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: underruns and strange code in pcm_rate.c (and
	patch)
Date: Thu, 08 Nov 2007 19:10:17 +0500
Message-ID: <473318C9.1070804@ums.usu.ru>
References: <472E5A64.6010705@aknet.ru> <s5hy7dbvcgf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay4.usu.ru (relay4.usu.ru [194.226.235.39])
	by alsa0.perex.cz (Postfix) with ESMTP id 4502B248D9
	for <alsa-devel@alsa-project.org>; Thu,  8 Nov 2007 15:10:34 +0100 (CET)
Received: from relay4.usu.ru (localhost [127.0.0.1])
	by relay4.usu.ru (PostSystem) with ESMTP id 02A4817F2B
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Nov 2007 19:10:37 +0500 (YEKT)
Received: from usu2.usu.ru (usu2.usu.ru [194.226.237.16])
	by relay4.usu.ru (PostSystem) with ESMTP id 8D76E17F2B
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Nov 2007 19:10:36 +0500 (YEKT)
Received: from usu2.usu.ru (localhost.usu2.usu.ru [127.0.0.1])
	by usu2.usu.ru (Postfix) with ESMTP id 58622A7ECB
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Nov 2007 19:10:30 +0500 (YEKT)
Received: from ums.usu.ru (ums.usu.ru [194.226.236.116])
	by usu2.usu.ru (Postfix) with ESMTP id 0BE3CA7EB0
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Nov 2007 19:10:25 +0500 (YEKT)
In-Reply-To: <s5hy7dbvcgf.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> The problem is that the hardware is woken up only at the period size
> of the slave side.  Assume the slave (hardware playback) is running
> 48kHz and the client (input) is 44.1kHz.  When dmix is used, usually
> the period size = 1024 in the h/w side.  Then the period size of the
> client side is supposed to be 940.
> Here, note that 940 != 1024 * 44.1 / 48.0 exactly.  This rounding
> causes the drift of wake-up time at each period and the delay is
> accumulated.

Let me propose a solution: let the "rate" plugin return a rate slightly 
different from the requested one, adjusted based on the period size, so that the 
mismatch and rounding error doesn't happen (i.e.: use 44062 Hz instead of 44100 
in calculations of pointer positions in the above example, and resample the 
client data from that rate instead of exact 44100). This would not be a 
regression anyway, as there are cards (e.g., ens1371) that can do 48 kHz only 
approximately.

-- 
Alexander E. Patrakov
