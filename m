From: Jan Niehusmann <jan@gondor.com>
Subject: Re: Slab corruptions & Re: 2.6.17-rc1: Oops in sound applications
Date: Wed, 5 Apr 2006 02:28:47 +0200
Message-ID: <20060405002846.GA5201__32793.0020088845$1144197382$gmane$org@knautsch.gondor.com>
References: <Pine.LNX.4.63.0604032155220.17605@deepthought.mydomain> <20060404133814.GA11741@knautsch.gondor.com> <s5hlkul72rv.wl%tiwai@suse.de> <20060404190631.GA4895@knautsch.gondor.com> <s5h7j656tpp.wl%tiwai@suse.de> <20060404231911.GA4862@knautsch.gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from moria.gondor.com (mail.gondor.com [212.117.64.182])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C2678183
	for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2006 02:28:47 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <20060404231911.GA4862@knautsch.gondor.com>
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

On Wed, Apr 05, 2006 at 01:19:11AM +0200, Jan Niehusmann wrote:
> ...which happens to be the commit which contains the bug you already
> mentioned. I wonder if there is a second one hidden somewhere in that
> commit, or if git-bisect led me to that bug while the second one is
> hidden in a different commit...

Well, I did some additional debugging on that, working on git version
3bf75f9b90c981f18f27a0d35a44f488ab68c8ea:

In snd_pcm_oss_release() I added 
snd_assert(substream != NULL, return -ENXIO); 
in front of the first access to substream->pcm, which leads to

Apr  5 02:13:13 knautsch kernel: [17180638.784000] BUG? (substream != ((void *)0))

when opening /dev/dsp for write.

If I now add the patch you suggested, correcting the check in
snd_pcm_oss_open_file(), accessing /dev/dsp instead leads to EINVAL.

So I guess git bisect really lead me to this already known bug.

Jan



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
