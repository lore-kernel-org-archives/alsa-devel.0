From: Marcus Andersson <054185595@telia.com>
Subject: Re: hdsp and midi problems
Date: Mon, 23 Jun 2003 20:12:38 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EF74316.4508B81@telia.com>
References: <3EF4BCA2.578FD128@telia.com>
			<NDBBLGIKBJENLAMOLFHGOEPKCIAB.mknecht@controlnet.com> <s5h3ci03gb8.wl@alsa2.suse.de> <3EF734CD.23E1E15@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, Mark Knecht <mknecht@controlnet.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Marcus Andersson wrote:
> 
> Takashi Iwai wrote:
> > btw, could you try the attached patch?
> > (and in-advance-scheduled excuse if it causes a hang-up :)
> 
> I will try it. Do you think I can safely apply it to 0.9.4, or should I
> use cvs?

Tested with current cvs. It locks up my computer. I used alsa-lib 0.9.4,
as I can't build the latest:

mkdir .libs
rm -fr .libs/libcontrol.la .libs/libcontrol.* .libs/libcontrol.*
(cd . && ln -s cards.lo cards.lo)
(cd . && ln -s hcontrol.lo hcontrol.lo)
(cd . && ln -s control.lo control.lo)
(cd . && ln -s control_hw.lo control_hw.lo)
(cd . && ln -s control_shm.lo control_shm.lo)
(cd . && ln -s setup.lo setup.lo)
(cd . && ln -s control_symbols.lo control_symbols.lo)
ar cru .libs/libcontrol.al cards.lo hcontrol.lo control.lo control_hw.lo
control_shm.lo setup.lo control_symbols.lo
ar: cards.lo: Too many levels of symbolic links
make[2]: *** [libcontrol.la] Error 1
make[2]: Leaving directory `/usr/local/src/alsa/alsa-lib/src/control'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/usr/local/src/alsa/alsa-lib/src'
make: *** [all-recursive] Error 1
debian:/usr/local/src/alsa/alsa-lib#

Probably my system configuration that is screwed up.

But I don't think it matters, as I open() the device directly.

Marcus


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
