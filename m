From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: compile error w/ envy24ht + linux 2.5.67
Date: Wed, 16 Apr 2003 10:52:35 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0304161052210.1026-100000@pnote.perex-int.cz>
References: <20030414204509.GA1263@www.angiotech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030414204509.GA1263@www.angiotech.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Stephen Hassard <steve@hassard.net>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 14 Apr 2003, Stephen Hassard wrote:

> Hi there,
> 
> When I try to compile a Linux 2.5.67 kernel with Alsa (from today's CVS) I get the following error:
> gcc -Wp,-MD,sound/pci/ice1712/.ice1724.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ice1724 -DKBUILD_MODNAME=snd_ice1724 -c -o sound/pci/ice1712/ice1724.o sound/pci/ice1712/ice1724.c
> sound/pci/ice1712/ice1724.c:1297: parse error before `__attribute__'
> sound/pci/ice1712/ice1724.c:1214: warning: `snd_vt1724_pro_internal_clock_info' defined but not used
> sound/pci/ice1712/ice1724.c:1243: warning: `snd_vt1724_pro_internal_clock_get' defined but not used
> sound/pci/ice1712/ice1724.c:1266: warning: `snd_vt1724_pro_internal_clock_put' defined but not used
> make[3]: *** [sound/pci/ice1712/ice1724.o] Error 1
> make[2]: *** [sound/pci/ice1712] Error 2
> make[1]: *** [sound/pci] Error 2
> make: *** [sound] Error 2
> 
> I have both gcc 2.95.4 and 3.2.3-0pre5 installed (debian - testing).

Try this patch (already in CVS):

diff -u -r1.3 -r1.4
--- ice1724.c   15 Mar 2003 15:38:29 -0000      1.3
+++ ice1724.c   16 Apr 2003 08:45:53 -0000      1.4
@@ -1294,7 +1294,7 @@
        return change;
 }

-static snd_kcontrol_new_t snd_vt1724_pro_internal_clock = __devinitdata {
+static snd_kcontrol_new_t snd_vt1724_pro_internal_clock __devinitdata = {
        .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
        .name = "Multi Track Internal Clock",
        .info = snd_vt1724_pro_internal_clock_info,


						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
