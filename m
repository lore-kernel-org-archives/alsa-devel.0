From: oeai <oeai@ya.ru>
Subject: Re: EMU-1212m "no Audiodock - no firmware" patch
Date: Mon, 26 Nov 2012 00:09:30 +0400
Message-ID: <50B27AFA.8000208@ya.ru>
References: <50AD5347.5040003@ya.ru> <s5h8v9tr1zu.wl%tiwai@suse.de>
 <50AE8681.3080409@ya.ru> <s5hy5hsk1gf.wl%tiwai@suse.de>
 <CAAMvbhHyG-W-vtu+wpq3JY-Uh-1uuK+5WC6+LJNEG3oy7z=J+A@mail.gmail.com>
Reply-To: oeai@ya.ru
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward9.mail.yandex.net (forward9.mail.yandex.net
 [77.88.61.48]) by alsa0.perex.cz (Postfix) with ESMTP id BE6D8260317
 for <alsa-devel@alsa-project.org>; Sun, 25 Nov 2012 21:09:56 +0100 (CET)
In-Reply-To: <CAAMvbhHyG-W-vtu+wpq3JY-Uh-1uuK+5WC6+LJNEG3oy7z=J+A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Oh, it's nice really!!
Did i understand you correctly - that the ca_cardbus - is the pcmcia bus 
support?
So i need just to turn it off and that will solve the problem of waking 
up from suspend?
nor should i put it in the end of the init process (so that sequence 
would be loaded before it)?

just didn't understand what do you mean @new card@ because it is 
actually stopped being supported and now they do the pcie and usb cards 
only.

  =)

On 25.11.2012 23:05, James Courtier-Dutton wrote:
> Can I help at all?
> I don't have much time spare, but I do have datasheets for some EMU cards.
> The PCMCIA/Cardbus versions need a special startup sequence before you
> can write or read any other registers.
> Failing to follow the startup sequence causes a PCI fault on the bus
> when you write to other registers on the card.
> I have not read the code recently, but I think that is what
> "ca_cardbus_chip = 1".
> For any new cards, you can try removing it, and if you get a PCI fault
> or hang on start up, put it back in.
>

--
RA
OE
AI
