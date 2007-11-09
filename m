From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: underruns and strange code in pcm_rate.c
Date: Fri, 09 Nov 2007 23:00:31 +0300
Message-ID: <4734BC5F.8040800@aknet.ru>
References: <472E5A64.6010705@aknet.ru>	<s5hy7dbvcgf.wl%tiwai@suse.de>	<473091F4.80105@aknet.ru>	<s5h8x5auxz3.wl%tiwai@suse.de>	<4731F2F4.2080704@aknet.ru>	<s5hode6xhgp.wl%tiwai@suse.de>	<4732097E.3040401@aknet.ru>	<s5htznx9znk.wl%tiwai@suse.de>	<4732C455.7040503@aknet.ru>	<s5hd4ulthy3.wl%tiwai@suse.de>
	<473488CA.7050308@freescale.com> <4734A448.7000909@aknet.ru>
	<4734BA93.6040900@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.AKNET.ru [77.246.241.226])
	by alsa0.perex.cz (Postfix) with ESMTP id C5FD424391
	for <alsa-devel@alsa-project.org>; Fri,  9 Nov 2007 20:59:16 +0100 (CET)
In-Reply-To: <4734BA93.6040900@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Timur Tabi wrote:
> How can I tell that my /etc/asound.conf is actually loaded and used?
Write some total crap into it, and
if the sound stops working, then it
is definitely used. :)
