From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: [PATCH] usx2y jack driver
Date: Thu, 23 Sep 2004 00:50:22 +0100 (WEST)
Sender: jackit-devel-admin@lists.sourceforge.net
Message-ID: <32810.192.168.1.5.1095897022.squirrel@192.168.1.5>
References: <200409222228.38243.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <jackit-devel-admin@lists.sourceforge.net>
In-Reply-To: <200409222228.38243.annabellesgarden@yahoo.de>
Errors-To: jackit-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:jackit-devel@lists.sourceforge.net>
List-Help: <mailto:jackit-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=jackit-devel>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: Martin Langer <martin-langer@gmx.de>, Werner Schweer <ws@seh.de>, alsa-devel@lists.sourceforge.net, jackit-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Karsten,
>
> this adds a hw_dep device to snd-usb-usx2y to communicate pcm in native
> usb chuncs with userspace. it also adds a usx2y driver to jack, so you
> can play with it.
>
> works fine here.
> I can reliably use 128frames 2periods now on kernel 2.6.9-rc2-mm1-S1.
> Without crackles of course. (On a 500MHz PIII with UHCI-usb. Problems
> with OHCI may still be there, don't know.)
>

Amazing! I will check this out soon on my US-224. I'm a bit busy right
now, so can't afford to trash my alsa/jack environment, at least for the
time being.

BTW, that OHCI issue is really still open and quite ugly (cf. alsa-driver
bug #0000425). It makes my US-224 almost useless on my laptop :( Every
time I try to open the pcm device I get a fatal kernel oops. Midi is ok
however.

I must remember you that this all used to work satisfactorily around
alsa-driver-1.0.5a inclusive. IIRC it was that "no sleeping in ALSA's pcm
START/STOP callback" patch (as of CVS circa July 12-13) that broke
something, unfortunately I'm sure.

If you find the patience/time to lead me on debugging this, I'll
appreciate a lot.

Cheers,
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
