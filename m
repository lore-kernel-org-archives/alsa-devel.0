From: Ken Moffat <zarniwhoop@ntlworld.com>
Subject: Re: Slab corruptions & Re: 2.6.17-rc1: Oops in sound
 applications
Date: Tue, 4 Apr 2006 18:32:40 +0100 (BST)
Message-ID: <Pine.LNX.4.63.0604041827290.8756__11083.2151644447$1144189754$gmane$org@deepthought.mydomain>
References: <Pine.LNX.4.63.0604032155220.17605@deepthought.mydomain>
 <20060404133814.GA11741@knautsch.gondor.com> <s5hlkul72rv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463809536-1923691522-1144171960=:8756"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from queue01-winn.ispmail.ntl.com (queue01-winn.ispmail.ntl.com [81.103.221.55])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0330B18D
	for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2006 00:27:54 +0200 (MEST)
In-Reply-To: <s5hlkul72rv.wl%tiwai@suse.de>
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
Cc: Jan Niehusmann <jan@gondor.com>, Ken Moffat <zarniwhoop@ntlworld.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463809536-1923691522-1144171960=:8756
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Apr 2006, Takashi Iwai wrote:

>=20
> Could you try the patch below by OGAWA Hirofumi
> <hirofumi@mail.parknet.co.jp>?

 I'm not sure if this is helping or not - a few hours ago, I took a=20
couple of new things out of my .config (vga scrollback, new rtc) and the=20
oops only happened when I opened a second tab in firefox (that is, start=20
the sound app, then start firefox, then open another tab).  With this=20
patch, it oopsed when I opened a _third_ tab.

 I guess something else is involved.

Ken
--=20
das eine Mal als Trag=C3=B6die, das andere Mal als Farce
---1463809536-1923691522-1144171960=:8756--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
