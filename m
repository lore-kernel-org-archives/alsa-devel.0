From: Jan Niehusmann <jan@gondor.com>
Subject: Re: Slab corruptions & Re: 2.6.17-rc1: Oops in sound applications
Date: Wed, 5 Apr 2006 11:01:17 +0200
Message-ID: <20060405090117.GB4794__8729.00059116564$1144227971$gmane$org@knautsch.gondor.com>
References: <Pine.LNX.4.63.0604032155220.17605@deepthought.mydomain> <20060404133814.GA11741@knautsch.gondor.com> <s5hlkul72rv.wl%tiwai@suse.de> <20060404190631.GA4895@knautsch.gondor.com> <s5h7j656tpp.wl%tiwai@suse.de> <20060404231911.GA4862@knautsch.gondor.com> <20060405002846.GA5201@knautsch.gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from moria.gondor.com (mail.gondor.com [212.117.64.182])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C79D6221
	for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2006 11:01:18 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <20060405002846.GA5201@knautsch.gondor.com>
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

On Wed, Apr 05, 2006 at 02:28:47AM +0200, Jan Niehusmann wrote:
> If I now add the patch you suggested, correcting the check in
> snd_pcm_oss_open_file(), accessing /dev/dsp instead leads to EINVAL.
> 
> So I guess git bisect really lead me to this already known bug.

And another update. Sorry for sending so many small mails, but I want to
keep you informed to avoid unnecessary duplication of work.

To make sure I didn't do something stupid like confusing kernel
versions, I retried with 2.6.17-rc1 and the mentioned patch. It oopses
again, but the behaviour is different:

Versions 2.6.16 to commit bf1bbb5a49eec51c30d341606885507b501b37e8 only
allow a single open of /dev/dsp, and do not oops.

Commit 3bf75f9b90c981f18f27a0d35a44f488ab68c8ea and later do oops with
commands as simple as 'yes >/dev/dsp'.

Commit 3bf75f9b90c981f18f27a0d35a44f488ab68c8ea with the patch to
snd_pcm_oss_open_file() applied do not oops, but block every access to
/dev/dsp with EINVAL.

2.6.17-rc1 with the patch to snd_pcm_oss_open_file(), again, allows
opening of /dev/dsp, 'yes >/dev/dsp' does work as expected, but for
example twinkle (a VoIP application) gives garbled sound. Additionally,
I am now able to open /dev/dsp a second time (eg. 'yes >/dev/dsp' while
twinkle uses the sound device), immediately leading to an oops.

My guess is that this bug is just not triggered in commit
3bf75f9b90c981f18f27a0d35a44f488ab68c8ea because, for some other reason,
/dev/dsp is completely unusable.

Jan



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
