From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: difference between OSS mmap and alsa mmap? [alsa-oss]
Date: Tue, 24 Aug 2004 11:47:22 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200408241547.i7OFlMKA028889@localhost.localdomain>
References: <412B5115.5020309@superbug.demon.co.uk>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 24 Aug 2004 15:30:45 BST."
             <412B5115.5020309@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Jaroslav Kysela <perex@suse.cz>, Florian Schmidt <mista.tapas@gmx.net>, Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I also think that the best way to handle this is to use double buffering.
>So the user app writes to a ring buffer, and alsa just copies one period 
>at a time to the hardware buffer each time periods_elapsed is called.

this doesn't work. the whole point of the OSS mmap model is that the
app always has access to the entire hardware buffer, not just the
current period. this is why its so hard to make it work correctly in
emulation mode.

--p


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
