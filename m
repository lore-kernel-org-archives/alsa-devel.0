From: James C Georgas <jgeorgas@rogers.com>
Subject: ac97_codec.c bit update mask fix
Date: Fri, 01 Dec 2006 02:07:24 -0500
Message-ID: <1164956844.22052.19.camel@Rainsong>
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

/**
 * snd_ac97_update_bits - update the bits on the given register
 * @ac97: the ac97 instance
 * @reg: the register to change
 * @mask: the bit-mask to change
 * @value: the value to set
 *
 * Updates the masked-bits on the given register only when the value
 * is changed.
 *
 * Returns 1 if the bits are changed, 0 if no change, or a negative
 * code on failure.
 */

If the intent is to update _only_ the bits given in the mask, as the
comment seems to suggest, then the current code won't do it. 

Specifically, it'll clobber unset bits that are _not_ in the mask, if
the new bit is set. Here's a fix:

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
