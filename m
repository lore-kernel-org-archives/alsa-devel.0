From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: problems with hdsp
Date: Mon, 12 May 2003 08:52:02 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19FCiE-0006Hg-00@sc8-sf-list1.sourceforge.net>
References: <1052691952.419.76.camel@localhost>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "11 May 2003 18:25:52 EDT."
             <1052691952.419.76.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "David E. Storey" <dave@tamos.net>
Cc: alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>I tried compiling the hdsp driver and it tells me:
>
>(root@scorpius root)# modprobe snd-hdsp
>/lib/modules/2.4.21-rc2/kernel/sound/pci/rme9652/snd-hdsp.o: unresolved
>symbol snd_hwdep_new
>/lib/modules/2.4.21-rc2/kernel/sound/pci/rme9652/snd-hdsp.o: insmod
>/lib/modules/2.4.21-rc2/kernel/sound/pci/rme9652/snd-hdsp.o failed
>/lib/modules/2.4.21-rc2/kernel/sound/pci/rme9652/snd-hdsp.o: insmod
>snd-hdsp failed
>
>it seems simple to fix, but my knowledge of alsa isn't intimate... yet.
>It was compiled via:

this was fixed in CVS a few days ago. the hwdep module (which is now
used by the hdsp driver) wasn't declared as a dependency for the hdsp
driver. 

there are other (non-hdsp-related) issues ALSA CVS current, but i
believe they won't affect you on a single CPU system.

>I've kind-of gotten it to work in the past, but I had to rev down the
>firmware, which I'm really hoping I won't have to do soon. (Since the

that's correct. there is no reason to do this with the current driver.

>Also, I've read in numerous places that it's a really BAD idea to "bond"
>multiple sound cards together using one's .asoundrc file since they're
>not synchronized. Is that still the case if, say, I synced the word
>clock among multiple multifaces? Would anything change in the .asoundrc
>file?

this should work. jeremy hall has been doing this, and i believe that
with the recent changes (the ones causing the ALSA CVS current
problems i referred to above), it is now working for him.

--p


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
