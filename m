From: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: Problems with multiple simultaneous ac97 quirks
Date: Fri, 16 Sep 2005 08:37:13 -0400
Message-ID: <20050916123711.GA22825@tuxdriver.com>
References: <20050915180415.GA24705@srcf.ucam.org> <s5h4q8mm7qi.wl%tiwai@suse.de> <20050915202858.GA5169@srcf.ucam.org> <20050916104137.GA18311@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from ra.tuxdriver.com (ra.tuxdriver.com [24.172.12.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CC8B0185
	for <alsa-devel@alsa-project.org>; Fri, 16 Sep 2005 14:37:21 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <20050916104137.GA18311@srcf.ucam.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 16, 2005 at 11:41:37AM +0100, Matthew Garrett wrote:
> On Thu, Sep 15, 2005 at 09:28:58PM +0100, Matthew Garrett wrote:
> 
> > Ok. Something like the following patch? It introduces 
> > AC97_TUNE_HP_MUTE_LED (yes, it's a poor name...) which is identical to 
> > AC97_TUNE_MUTE_LED except it calls bind_hp_volsw_put instead of 
> > snd_ac97_put_volsw and removes the headphone mixer controls.

I don't suppose you have a list of PCI sub-system IDs that this helps?

Thanks,

John
-- 
John W. Linville
linville@tuxdriver.com


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
