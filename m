From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Loud POP from sound system during module init w/
	2.6.19
Date: Sat, 9 Dec 2006 15:11:50 +0100 (MET)
Message-ID: <Pine.LNX.4.61.0612091511111.8055__24910.0186316811$1165673669$gmane$org@yvahk01.tjqt.qr>
References: <2a6e8c0d0612081053v4fa0f2b0uea82fac75976b767@mail.gmail.com>
	<Pine.LNX.4.61.0612091020450.8055@yvahk01.tjqt.qr>
	<2a6e8c0d0612090517j5afe2161p591203c70ddfc890@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from tmailer.gwdg.de (tmailer.gwdg.de [134.76.10.23])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 14063286
	for <alsa-devel@alsa-project.org>; Sat,  9 Dec 2006 15:13:25 +0100 (MET)
In-Reply-To: <2a6e8c0d0612090517j5afe2161p591203c70ddfc890@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, perex@suse.cz
List-Id: alsa-devel@alsa-project.org


On Dec 9 2006 08:17, Ian E. Morgan wrote:
>
> Previous kernel was 2.6.18.3, which did not exhibit the problem. I was
> aware of udev setting the mixer at module load time, but I disabled
> that and the problem still exists.

Another reason might be that the sound driver sets the initial volume 
(even before udev can act) to 100%. That's probably Not So Good.
I'd suggest to take a diff between 2.6.18.3's sound tree and the 2.6.19 
one, and see if the driver for your card changed.


	-`J'
-- 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
