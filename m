From: Michal Seta <mis@creazone.com>
Subject: Re: [Alsa-devel Request for test of powermac driver
Date: Mon, 20 May 2002 20:58:13 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <acc6u4$jgh$2@main.gmane.org>
References: <s5hn0v15p95.wl@alsa2.suse.de>
	<20020520104117.7f18005a.mis@creazone.com>
	<3CE95E36.A6122F19@folkwang-hochschule.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3CE95E36.A6122F19@folkwang-hochschule.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 20 May 2002 22:36:06 +0200
Jörn Nettingsmeier <nettings@folkwang-hochschule.de> wrote:
> > In file included from pmac.c:1:
> > ../alsa-kernel/ppc/pmac.c: In function `snd_pmac_new':
> > ../alsa-kernel/ppc/pmac.c:1353: structure has no member named `mode'
> > make[1]: *** [pmac.o] Error 1
> > make[1]: Leaving directory `/home/mis/CVS/alsa-driver/ppc'
> > make: *** [compile] Error 1

> that's a typo. change "mode" to "model".

ok.  thanks.  Jack H. has pointed this out to me already and it compiled fine and installed and all is fine and dandy.  However, there's one problem that I have noticed (and I had the same problem with the 0.5.12 version as well):  The CD will not play.  I mean, it plays but there's no sound.  The only way to play CDs is through a cdplayer plugin in xmms but any other cd app (I tried wmcdplay, xfreecd, groovycd and cdplay commandline) will not play.  Also, mixers will not allow me to change levels for Line-in, Mic and CD inputs.  Although this is not such a problem, I can control the audio input in the apps I'm using, I was wondering if this is a wanted behaviour.  At this time alsamixer shows those levels at '0' and other mixers at 100%.  

I'm on an iMac indigo 350Mhz, Debian woody, 2.4.18 kernel.

otherwise the drivers are working fine for me but I haven't tested it extensively, yet.  Also, I started to recompile some apps agains the new alsa libs and so far no problems.

thanks!
-- 
./MiS

Michal Seta		http://creazone.eworldmusic.com/doc/mis
CreaZone		http://www.creazone.com
No One Receiving	http://creazone.eworldmusic.com/doc/nor

upcoming release:
NOR - "The Release of the Wandering-Eyed Girl"
	http://www.grainofsound.com


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
