From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: pcmcia hdsp problems
Date: Fri, 09 May 2003 11:46:09 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19EA0j-0005pp-00@sc8-sf-list1.sourceforge.net>
References: <1052414802.1344.59.camel@localhost.localdomain>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "08 May 2003 13:26:41 EDT."
             <1052414802.1344.59.camel@localhost.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: jfm3 <jfm3@ouroboros-complex.org>
Cc: ALSA Developer List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>Thanks. I had gathered as much. Is there a way to tell
>snd-hammerfall-mem to allocate memory for a card even if it doesn't find
>one? I'd like to be able to put the pcmcia card in after the machine
>boots. The enable parameter to snd-hammerfall-mem doesn't seem to do
>anything anymore.

no, it never did what you want right now. all it was therefore was to
turn off memory allocation if the card was detected but for some
reason you didn't want to use it.

the module would need a fairly significant overhaul to do what you're
asking, although its actually a very small piece of code.

>This is especially important to me right now because for some reason the
>pcmcia interface is not found correctly at boot time, only when the card
>is inserted after hotplug has started...

i think it might be better to see if you can find out why it comes up
with an illegal PCI ID during boot time. that strikes me as very wrong
(and almost certainly a BIOS/kernel issue, since i bet the same card
in another machine would not do this).

--p


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
