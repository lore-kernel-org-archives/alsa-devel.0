From: Alien <alien999999999@users.sourceforge.net>
Subject: Re: [Openvortex-dev] Re: [PATCH] au88x0: clean up __devinit/__devexit
Date: Mon, 10 Apr 2006 13:38:34 +0200
Message-ID: <200604101338.35172.alien999999999@users.sourceforge.net>
References: <20060409004019.GA23548@morgase.caliginous.net> <s5hfykl90rg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hfykl90rg.wl%tiwai@suse.de>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: openvortex-dev@nongnu.org
Cc: Takashi Iwai <tiwai@suse.de>, Dale Sedivec <dale-keyword-alsa.049f33@codefu.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Monday 10 April 2006 12:35, Takashi Iwai wrote:
> At Sat, 8 Apr 2006 20:40:19 -0400,
>
> Dale Sedivec wrote:
> > Removed all use of __devinit/__devexit and init.h from headers.  Any
> > attributes given in the prototype but not in the function definition have
> > been moved to the definition.
> >
> > An exception is vortex_eq_free: I removed the __devexit attribute because
> > vortex_eq_free is called from vortex_core_shutdown, and
> > vortex_core_shutdown may be called from __devinit snd_vortex_create.
> >
> > Compile tested with allyesconfig and allmodconfig.
> >
> > Signed-off-by: Dale Sedivec <dale@codefu.org>
>
> Thanks, I applied the patch to ALSA cvs tree.

what about all the other changes, bugfixes and patches that have been posted 
on this list? are they being applies as well? (also, that gigantic bugreport 
and all changes being submitted there...)

-- 
Alien is my name and head-biting is my game


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
