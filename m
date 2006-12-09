From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Loud POP from sound system during module init w/
	2.6.19
Date: Sat, 9 Dec 2006 10:22:03 +0100 (MET)
Message-ID: <Pine.LNX.4.61.0612091020450.8055@yvahk01.tjqt.qr>
References: <2a6e8c0d0612081053v4fa0f2b0uea82fac75976b767@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from tmailer.gwdg.de (tmailer.gwdg.de [134.76.10.23])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5F0352F3
	for <alsa-devel@alsa-project.org>; Sat,  9 Dec 2006 10:24:44 +0100 (MET)
In-Reply-To: <2a6e8c0d0612081053v4fa0f2b0uea82fac75976b767@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: "Ian E. Morgan" <penguin.wrangler@gmail.com>
Cc: alsa-devel@alsa-project.org, emu10k1-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>, perex@suse.cz
List-Id: alsa-devel@alsa-project.org


On Dec 8 2006 13:53, Ian E. Morgan wrote:
>Subject: Loud POP from sound system during module init w/ 2.6.19

What kernel did you have before?

What you see is the same I am experiencing on every boot - when the sound
module is loaded, udev loads the previous volume settings. The volume settings
are normal for me, but I guess the instant jump from 0-70% (for Master) and
0-61% (for PCM) is not taken too heartly by the soundcard.

> Since upgrading to 2.6.19, two of my boxes (one workstation, one
> notebook) started making a very loud (and scary) POP from the sound
> system when the alsa modules are loaded. Unloading and reloading the
> modules will generate another pop.
>
> Anybody else seeing this behaviour and know how to stop it?
>

	-`J'
-- 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
