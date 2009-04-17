From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: Re: [PATCH] us122l: add snd_us122l_free()
Date: Fri, 17 Apr 2009 13:38:24 +0200
Message-ID: <200904171338.24877.fzu@wemgehoertderstaat.de>
References: <200904161938.50539.fzu@wemgehoertderstaat.de>
	<s5hws9jahh0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout4.freenet.de (mout4.freenet.de [195.4.92.94])
	by alsa0.perex.cz (Postfix) with ESMTP id DE6D810380E
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Apr 2009 13:38:30 +0200 (CEST)
In-Reply-To: <s5hws9jahh0.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

Am Freitag 17 April 2009 schrieb Takashi Iwai:
> At Thu, 16 Apr 2009 19:38:50 +0200,
> Karsten Wiese wrote:
> > 
> > Use it to clean up snd_us122l_card_used[].
> > 
> > Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>
> > Cc: stable@kernel.org
> 
> Is it really for stable kernel?  Any bug report for this?

This really is for stable too. The bug it fixes happens if one does:

	Start on a pc with onboard soundcard at index 0.
	$ modprobe snd_usb_us122l modprobe snd_usb_us122l index=2
	plug US122L soundcard
	$ cat /proc/asound/devices
	last command shows the US122L soundcard is at index 2.

	unplug US122L soundcard
	plug US122L soundcard
	$ cat /proc/asound/devices
	last command shows the US122L soundcard is at index 1 now, which is the bug
	the patch fixes.

Thanks,
Karsten

	
