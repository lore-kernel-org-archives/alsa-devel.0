From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: 1.0.10rc3 release
Date: Sat, 12 Nov 2005 14:18:00 +0000
Message-ID: <20051112141800.42b262c8.pochini@shiny.it>
References: <Pine.LNX.4.61.0511081101340.9285@tm8103.perex-int.cz>
	<Pine.LNX.4.58.0511091131250.28985@denise.shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from vsmtp3alice.tin.it (vsmtp3alice.tin.it [212.216.176.143])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2C34C15E
	for <alsa-devel@alsa-project.org>; Sat, 12 Nov 2005 15:18:17 +0100 (MET)
In-Reply-To: <Pine.LNX.4.58.0511091131250.28985@denise.shiny.it>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@denise.shiny.it>
Cc: perex@suse.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 9 Nov 2005 11:33:55 +0100 (CET)
Giuliano Pochini <pochini@denise.shiny.it> wrote:

> 
> 
> On Tue, 8 Nov 2005, Jaroslav Kysela wrote:
> 
> > 	1.0.10rc3 ALSA packages were released for testing. Hopefully, the
> > 1.0.10-final release will come soon. For full list of changes, please, see
> > http://www.alsa-project.org/changes/v1-0-10rc2--v1-0-10rc3.txt .
> 
> The pmac driver didn't compile with the CVS version of few days ago. I
> can't check anything until tomorrow night, sorry.

Ok, I have finally had time to check it out. The latest CVS version does not
compile (pulled just now: Sat Nov 12 14:05:35 UTC 2005):

In file included from /home/giu/soft/ad/uuuuuuuuu/alsa-driver/ppc/beep.c:6:
/home/giu/soft/ad/uuuuuuuuu/alsa-driver/ppc/../../alsa-kernel/ppc/beep.c: In function `snd_pmac_attach_beep':
/home/giu/soft/ad/uuuuuuuuu/alsa-driver/ppc/../../alsa-kernel/ppc/beep.c:220: warning: implicit declaration of function `input_allocate_device'
/home/giu/soft/ad/uuuuuuuuu/alsa-driver/ppc/../../alsa-kernel/ppc/beep.c:220: warning: assignment makes pointer from integer without a cast
/home/giu/soft/ad/uuuuuuuuu/alsa-driver/ppc/../../alsa-kernel/ppc/beep.c:236: error: structure has no member named `cdev'
/home/giu/soft/ad/uuuuuuuuu/alsa-driver/ppc/../../alsa-kernel/ppc/beep.c:252: warning: implicit declaration of function `input_free_device'
make[3]: *** [/home/giu/soft/ad/uuuuuuuuu/alsa-driver/ppc/beep.o] Error 1
make[2]: *** [/home/giu/soft/ad/uuuuuuuuu/alsa-driver/ppc] Error 2
make[1]: *** [_module_/home/giu/soft/ad/uuuuuuuuu/alsa-driver] Error 2
make[1]: Leaving directory `/opt/KernelSrc/linux-2.6.13.2'
make: *** [compile] Error 2


I didn't find the symbol 'input_allocate_device' in 2.6.1[34] kernel trees.
What is it supposed to be ?


--
Giuliano.


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
