From: James C Georgas <jgeorgas@rogers.com>
Subject: Re: ac97 maintenance
Date: Wed, 06 Dec 2006 15:18:33 -0500
Message-ID: <1165436313.23056.53.camel@Rainsong>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-06-12 at 20:44 +0100, Jaroslav Kysela wrote:
> On Wed, 6 Dec 2006, Randy Cushman wrote:
> 
> > I also have posted a patch, and I am testing another.
> > 
> > The impression I've gotten from reading bugtracker postings is that 
> > Takashi Iwai might be the person to accept our patches.  He/she is
on 
> > vacation, according to a message posted last week.
> 
> Please, post your patches to this mailing list for review or try 
> ALSA BTS again (there was a smtp setup problem, but it should be ok
now).
> We have more than one developer accepting patches.
> 
>                                       Thanks,
>                                               Jaroslav
> 
Ok, yeah, my login failed ten minutes ago, but it's working now. Thanks
to whoever fixed that.

Here's my patch again, in case the old post got lost somehow:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Summary: trivial fix for bit update functions.

This patch fixes a couple of bit update functions in
alsa-kernel/pci/ac97/ac97_codec.c, which could possibly corrupt bits not
in the given mask.

Specifically, it'll clobber unset bits in the target that are not in the
mask, when the corresponding bit in the given new value is set.

Signed-off-by: James C Georgas <jgeorgas@rogers.com>

diff -r bc7ef767d0cf pci/ac97/ac97_codec.c
--- a/pci/ac97/ac97_codec.c     Wed Nov 29 15:29:40 2006 +0100
+++ b/pci/ac97/ac97_codec.c     Fri Dec  1 02:04:30 2006 -0500
@@ -389,7 +389,7 @@ int snd_ac97_update_bits_nolock(struct s
        unsigned short old, new;

        old = snd_ac97_read_cache(ac97, reg);
-       new = (old & ~mask) | value;
+       new = (old & ~mask) | (value & mask);
        change = old != new;
        if (change) {
                ac97->regs[reg] = new;
@@ -406,7 +406,7 @@ static int snd_ac97_ad18xx_update_pcm_bi

        mutex_lock(&ac97->page_mutex);
        old = ac97->spec.ad18xx.pcmreg[codec];
-       new = (old & ~mask) | value;
+       new = (old & ~mask) | (value & mask);
        change = old != new;
        if (change) {
                mutex_lock(&ac97->reg_mutex);


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
