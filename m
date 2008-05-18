From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: [patch] snd-pcsp: silent misleading warning
Date: Sun, 18 May 2008 20:49:48 +0400
Message-ID: <48305E2C.3070303@aknet.ru>
References: <482737BE.20502@infracom.it>	<4827415A.7060101@aknet.ru>	<482756F0.8020609@infracom.it>	<48275D8D.10500@aknet.ru>	<4827F0A1.9090600@infracom.it>	<48288ACC.1020909@aknet.ru>	<48299F08.2060702@infracom.it>	<4829B6A1.90707@infracom.it>	<s5h7idycfmf.wl%tiwai@suse.de>	<482A7A17.8070706@infracom.it>	<s5hwslxb3t8.wl%tiwai@suse.de>	<482C9A3E.3000009@infracom.it>	<482C9F3E.4050104@aknet.ru>	<482EC93E.7080702@infracom.it>	<482EFED2.1020504@aknet.ru>	<s5hskwgkqe1.wl%tiwai@suse.de>	<48306837.7030505@aknet.ru>
	<s5hk5hrd1a5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.aknet.ru [78.158.192.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 86309243FD
	for <alsa-devel@alsa-project.org>;
	Sun, 18 May 2008 18:49:58 +0200 (CEST)
In-Reply-To: <s5hk5hrd1a5.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, Roberto Oppedisano <roberto.oppedisano@infracom.it>
List-Id: alsa-devel@alsa-project.org

Hello.

Takashi Iwai wrote:
> Well, judging from your previous comment, I thought that it's no sane
> situation for *your* driver.
Only by wrongly triggering a warning
that was supposed for the different
purpose. :)

> But if the driver doesn't care in
> practice, your fix should be fine.  I'll queue it on my tree. 
Thanks.
