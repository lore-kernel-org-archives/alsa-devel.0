From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: underruns and strange code in pcm_rate.c
Date: Mon, 12 Nov 2007 13:12:55 +0100
Message-ID: <1194869575.32342.1220819105@webmail.messagingengine.com>
References: <472E5A64.6010705@aknet.ru> <s5hy7dbvcgf.wl%tiwai@suse.de>
	<473091F4.80105@aknet.ru> <s5h8x5auxz3.wl%tiwai@suse.de>
	<4731F2F4.2080704@aknet.ru> <s5hode6xhgp.wl%tiwai@suse.de>
	<4732097E.3040401@aknet.ru> <s5htznx9znk.wl%tiwai@suse.de>
	<4732C455.7040503@aknet.ru> <s5hd4ulthy3.wl%tiwai@suse.de>
	<473488CA.7050308@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 45C652455C
	for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2007 13:12:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <473488CA.7050308@freescale.com>
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
> [...]

It is likely that your problem is related to the sample rate converter
in the OSS emulation code.

Try disabling CONFIG_SND_PCM_OSS_PLUGINS in the kernel configuration,
then mplayer will use its owner sample rate converter.


Regards,
Clemens
