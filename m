From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: [alsa-cvslog] CVS: alsa-kernel/pci/emu10k1
 emu10k1_main.c,1.12,1.13
Date: Tue, 16 Apr 2002 09:15:10 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0204160911040.509-100000@pnote.perex-int.cz>
References: <873cxxmmjt.fsf@www.gitteundmarkus.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <873cxxmmjt.fsf@www.gitteundmarkus.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Markus Plail <plail@web.de>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 15 Apr 2002, Markus Plail wrote:

> Hi Takashi!
> 
> * Takashi Iwai writes:
> > At Thu, 11 Apr 2002 15:42:23 +0100,
> > James Courtier-Dutton wrote:
> >> 
> >> [1  <text/plain; us-ascii (7bit)>]
> >> Takashi Iwai wrote:
> >> 
> >> >Update of /cvsroot/alsa/alsa-kernel/pci/emu10k1
> >> >In directory usw-pr-cvs1:/tmp/cvs-serv9192
> >> >
> >> >Modified Files:
> >> >	emu10k1_main.c 
> >> >Log Message:
> >> >fixed default mask values
> >> >(these change won't affect the actual behavior, though)
> 
> [snip]
> 
> >> This seems to have fixed AC3 Passthru mode on SB Live (rev 7) cards.
> >> Just so you know, all SB Live cards worked before for AC3 Passthru 
> >> except the rev 7 cards.
> >> I just got a report on the xine-user list about it.
> >> Ok, so you did not know you were fixing it, but well done anyway!!!! ;-)
> > err, frankly speaking, i still don't figure out why with this change
> > the pass-through works.  i'm glad to to hear a good news, anyway ;)
> 
> Just wanted to let you know that it wasn't the changes in emu10k1_main.c,
> but the changes in emumixer.c that made my (I was the one reporting it on
> the xine ML) rev07 card working.

The joke is, that this behaviour is caused by a mistake. Here is the right 
patch against current CVS:

Index: emumixer.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emumixer.c,v
retrieving revision 1.9
diff -u -r1.9 emumixer.c
--- emumixer.c  8 Apr 2002 12:21:45 -0000       1.9
+++ emumixer.c  16 Apr 2002 07:10:59 -0000
@@ -369,7 +369,7 @@
        int change;

        spin_lock_irqsave(&emu->reg_lock, flags);
-       if (emu->audigy) {
+       if (!emu->audigy) {
                reg = inl(emu->port + HCFG);
                val = ucontrol->value.integer.value[0] & 1 ? 0 : HCFG_GPOUT0;
                change = (reg & HCFG_GPOUT0) != val;


At least, we know that for rev07 cards we shouldn't modify GPOUT0. These 
cards have separated the digital output or shared with an analog output?


						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com
