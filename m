From: Timur Tabi <timur@freescale.com>
Subject: Re: underruns and strange code in pcm_rate.c
Date: Thu, 31 Jan 2008 14:49:45 -0600
Message-ID: <47A23469.1010905@freescale.com>
References: <472E5A64.6010705@aknet.ru> <s5hy7dbvcgf.wl%tiwai@suse.de>
	<473091F4.80105@aknet.ru> <s5h8x5auxz3.wl%tiwai@suse.de>
	<4731F2F4.2080704@aknet.ru> <s5hode6xhgp.wl%tiwai@suse.de>
	<4732097E.3040401@aknet.ru> <s5htznx9znk.wl%tiwai@suse.de>
	<4732C455.7040503@aknet.ru> <s5hd4ulthy3.wl%tiwai@suse.de>
	<473488CA.7050308@freescale.com>
	<1194869575.32342.1220819105@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 04EAE2447A
	for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2008 21:49:50 +0100 (CET)
In-Reply-To: <1194869575.32342.1220819105@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Timur Tabi wrote:
>> [...]
> 
> It is likely that your problem is related to the sample rate converter
> in the OSS emulation code.
> 
> Try disabling CONFIG_SND_PCM_OSS_PLUGINS in the kernel configuration,
> then mplayer will use its owner sample rate converter.

Has there been any progress made on this issue since November?  I have a 
customer that is affected by it, and I was wondering if the problem is fixed in 
the latest ALSA.

If not, is there a bug entry in https://bugtrack.alsa-project.org for it? I need 
to make a formal write-up of this bug, but I don't really understand it that well.

-- 
Timur Tabi
Linux kernel developer at Freescale
