From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Problems with multiple simultaneous ac97 quirks
Date: Fri, 16 Sep 2005 15:25:44 +0100
Message-ID: <20050916142544.GA20279@srcf.ucam.org>
References: <20050915180415.GA24705@srcf.ucam.org> <s5h4q8mm7qi.wl%tiwai@suse.de> <20050915202858.GA5169@srcf.ucam.org> <20050916104137.GA18311@srcf.ucam.org> <20050916123711.GA22825@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from vavatch.codon.org.uk (cavan.codon.org.uk [217.147.92.49])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9E5D0187
	for <alsa-devel@alsa-project.org>; Fri, 16 Sep 2005 16:25:46 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <20050916123711.GA22825@tuxdriver.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 16, 2005 at 08:37:13AM -0400, John W. Linville wrote:

> I don't suppose you have a list of PCI sub-system IDs that this helps?

Yup:

AC97_TUNE_HP_MUTE_LED

4200    103c:0938
6120	103c:099c
6220    103c:0944
8220    103c:0934

All of Those plus the following also want to be added to the list in 
check_ad1981_hp_jack_sense():

4000/10 0e11:005a

The 6125 wants AC97_TUNE_MUTE_LED - it's an ATI chipset, using the 
snd-atiixp driver. It's 103c:308b. However, it doesn't need TUNE_HP_ONLY 
and doesn't need to be added to check_ad1981_hp_jack_sense().

I'd guess that the nx9600 probably needs the same, but I don't have 
access to one of those to check. The 8230 and 8240 have the same IDs as 
the 8220, and the 6110 shares with the 6120 (it doesn't actually have a 
mute LED, but the motherboard is identical). The 6230 ought to be 
identical to the 6220.

I'd guess that some of the consumer range also has these requirements, 
but I'm afraid I don't have any available to test.
-- 
Matthew Garrett | mjg59@srcf.ucam.org


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
