From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: dB gain
Date: Tue, 30 May 2006 19:59:58 +0100
Message-ID: <447C962E.3010103@superbug.co.uk>
References: <4478A290.80702@superbug.co.uk> <s5hverp7zcr.wl%tiwai@suse.de>
	<447B0A19.2050408@superbug.co.uk> <s5hy7wkddyf.wl%tiwai@suse.de>
	<447B308E.2050502@superbug.co.uk> <s5hirnod7l2.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0605292017280.11164@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from anchor-post-30.mail.demon.net (anchor-post-30.mail.demon.net
	[194.217.242.88])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 65014150
	for <alsa-devel@alsa-project.org>;
	Tue, 30 May 2006 21:00:02 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.61.0605292017280.11164@tm8103-a.perex-int.cz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

So, from what I can see, there have been no real reasons why I should
not commit my db gain code now.
Except for the actual name of the ioctl function. Should I also use a
different number?
Lets take a vote:
1) SNDRV_CTL_IOCTL_MISC = _IOR('U', 0x22, struct snd_ctl_misc),
2) SNDRV_CTL_IOCTL_INFO2 = _IOR('U', 0x22, struct snd_ctl_info2),
3) SNDRV_CTL_IOCTL_TLV = _IOR('U', 0x22, struct snd_ctl_tlv),
4) Something else...suggest.

Once we decide, I will commit it.

James
