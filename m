From: Jan Niehusmann <jan@gondor.com>
Subject: Re: Slab corruptions & Re: 2.6.17-rc1: Oops in sound applications
Date: Wed, 5 Apr 2006 14:15:38 +0200
Message-ID: <20060405121537.GA4807__5056.30198536$1144239957$gmane$org@knautsch.gondor.com>
References: <Pine.LNX.4.63.0604032155220.17605@deepthought.mydomain> <20060404133814.GA11741@knautsch.gondor.com> <s5hlkul72rv.wl%tiwai@suse.de> <20060404190631.GA4895@knautsch.gondor.com> <s5h7j656tpp.wl%tiwai@suse.de> <20060404231911.GA4862@knautsch.gondor.com> <20060405002846.GA5201@knautsch.gondor.com> <20060405090117.GB4794@knautsch.gondor.com> <s5h1wwcp93l.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from moria.gondor.com (mail.gondor.com [212.117.64.182])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 34921170
	for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2006 14:15:43 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <s5h1wwcp93l.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Ken Moffat <zarniwhoop@ntlworld.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 05, 2006 at 01:14:54PM +0200, Takashi Iwai wrote:
> Try the patch below.  The change in pcm_native.c may be unnecessary,
> but it's better so.
> If it works, I'll submit the patches with a proper log.

The patch (applied to 2.6.17-rc1) does fix the oops, but sound is still
garbled with twinkle using /dev/dsp. 

About this garbled sound: I call an echo service on my asterisk server,
which just echoes back everything I say. Works well using /dev/dsp with
2.6.16, but with 2.6.17-rc1, even with the patch applied, I hear no echo
at all for ~1s. After that, I hear a strongly distorted echo.

If I change the twinkle settings to use the ALSA native devices instead
of /dev/dsp, everything is fine.

Pure playback, eg. with xmms, is fine with 2.6.17-rc1 using /dev/dsp.

Jan



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
