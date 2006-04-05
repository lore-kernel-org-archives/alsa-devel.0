From: Ken Moffat <zarniwhoop@ntlworld.com>
Subject: Re: Slab corruptions & Re: 2.6.17-rc1: Oops in sound
 applications
Date: Wed, 5 Apr 2006 22:19:55 +0100 (BST)
Message-ID: <Pine.LNX.4.63.0604052218280.8850__43532.6141109273$1144277962$gmane$org@deepthought.mydomain>
References: <Pine.LNX.4.63.0604032155220.17605@deepthought.mydomain>
 <20060404133814.GA11741@knautsch.gondor.com> <s5hlkul72rv.wl%tiwai@suse.de>
 <20060404190631.GA4895@knautsch.gondor.com> <s5h7j656tpp.wl%tiwai@suse.de>
 <20060404231911.GA4862@knautsch.gondor.com> <20060405002846.GA5201@knautsch.gondor.com>
 <20060405090117.GB4794@knautsch.gondor.com> <s5h1wwcp93l.wl%tiwai@suse.de>
 <20060405121537.GA4807@knautsch.gondor.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463809536-222924853-1144271995=:8850"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from queue03-winn.ispmail.ntl.com (queue03-winn.ispmail.ntl.com [81.103.221.57])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 107C716C
	for <alsa-devel@alsa-project.org>; Thu,  6 Apr 2006 00:57:06 +0200 (MEST)
In-Reply-To: <20060405121537.GA4807@knautsch.gondor.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jan Niehusmann <jan@gondor.com>
Cc: Takashi Iwai <tiwai@suse.de>, Ken Moffat <zarniwhoop@ntlworld.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463809536-222924853-1144271995=:8850
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Apr 2006, Jan Niehusmann wrote:

> On Wed, Apr 05, 2006 at 01:14:54PM +0200, Takashi Iwai wrote:
> > Try the patch below.  The change in pcm_native.c may be unnecessary,
> > but it's better so.
> > If it works, I'll submit the patches with a proper log.
>=20
> The patch (applied to 2.6.17-rc1) does fix the oops, but sound is still
> garbled with twinkle using /dev/dsp.=20

 As a simple user of (only) playback, it fixes it.  Thanks to you both.

Ken
--=20
das eine Mal als Trag=C3=B6die, das andere Mal als Farce
---1463809536-222924853-1144271995=:8850--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
