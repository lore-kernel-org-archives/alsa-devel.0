From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] ALSA driver for Yamaa AICA on Sega Dreamcast
Date: Mon, 17 Apr 2006 12:52:26 +0300
Message-ID: <20060417095226.GA8910@linux-sh.org>
References: <1145232784.12804.2.camel@localhost.localdomain> <20060417012913.GA16821@linux-sh.org> <1145267096.9238.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linuxsh-dev-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1145267096.9238.6.camel@localhost.localdomain>
Sender: linuxsh-dev-admin@lists.sourceforge.net
Errors-To: linuxsh-dev-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linuxsh-dev@lists.sourceforge.net>
List-Help: <mailto:linuxsh-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linuxsh-dev>
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>, linux-sh <linuxsh-dev@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Removing l-k from CC, since it's not likely anyone cares.

On Mon, Apr 17, 2006 at 10:44:56AM +0100, Adrian McMenamin wrote:
> As I wrote last week dma_wait_for_completion won't hack G2 DMA:
> 
> get_residue never returns 0 for G2 DMA. When the dma is complete
> get_residue returns the size of the total transfer. Therefore I've no
> choice but to write my own handler (spinlocks question aside).

Then the G2 DMA ->get_residue() op needs to be fixed, as it's broken.
Don't work against the subsystem, it knows what it's doing.

You might be better off getting rid of it entirely and seeing about
getting the TEI working, you can check for completion and wake up
accordingly in this case, which is what you ideally want anyways. The
busy-loop in the generic dma_wait_for_completion() is a stupid hack for
people that haven't fixed up their TEI handling yet, it's not intended
for widespread use..


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
