From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Re: Echo driver
Date: Tue, 23 Nov 2004 10:41:38 +0100 (CET)
Message-ID: <XFMail.20041123104138.pochini@shiny.it>
References: <20041123004518.M39311@stickist.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041123004518.M39311@stickist.com>
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


On 23-Nov-2004 Yon Mercury wrote:

> OK, here's a comparison of the CardBus registers between Linux and Windows.
> As you can see, some registers are different-- take 0D for example.

I guess you got the register dump while the cards was in, didn't you ? 
Just to be sure :)  I'm asking this because the latency timer should
be 0xC0, not 0x40.


> The question is, what registers are likely to be the ones we have to change?

Register 0x80 should be 00 (PCI prefetch disabled).
Register 0x0D should be C0 (latency timer, the driver should be
able to set it, so don't touch it).

I don't know about all other registers because I couldn't find
any documentation. Registers >=0x80 are chip-specific and they
are explained here: http://pcmcia-cs.sourceforge.net/specs/AP476IIE10.pdf


--
Giuliano.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
