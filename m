From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Re: Echo driver
Date: Wed, 24 Nov 2004 09:40:09 +0100 (CET)
Message-ID: <XFMail.20041124094009.pochini@shiny.it>
References: <20041124031406.M70915@stickist.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041124031406.M70915@stickist.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Yon Mercury <swirlee@stickist.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 24-Nov-2004 Yon Mercury wrote:

> Yes, the register dump was taken when the card was in. I tried manually
> changing latency timer and pci prefetch but with no success. Running:
>
> setpci -s 00:0f latency_timer=c0
> setpci -s 00:0f 80.B=00
>
> Shows changed values in lspci.
> But still the driver fails to load when I do a 'modprobe snd-indigoio'. If I
> try a '/etc/init.d/pcmcia restart' to restart CardBus services, all the PCI
> settings return to their old values and I have to use setpci again.
>
> This is getting to be a bit ridiculous. If this is a CardBus bridge issue,
> someone with a different bridge chip should be able to get the Echo card
> working, right? Does anyone out there on the list have audio working on a
> CardBus system that could test an Echo card?

I talked with several people in the past who had Mona and Layla24
-cardbus version. None of them could make it work. The PCI version
of those cards works fine. Thus I guess the problem is not in the
driver, at least for the two cards above. But since the firmware
loading routine is the same for any card I don't think there is
an indigo-specific bug in this case. So, if it's unlikely it's
driver fault and other people has (partly unresolved) problems
with the PCMCIA interface, I guess the problems stays in the
interface also in this case.


> Giuliano, have you heard from any of the other Echo Audio users who
> might have one of those cards?

Yes, I'll contact them.


> On the other hand, is it possible that its an Echo driver issue?

Of course it's possible, but it's very unlikely.


--
Giuliano.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
