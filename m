From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: [Alsa-devel] Re: Patch for AICA sound support on SEGA Dreamcast
Date: Mon, 03 Apr 2006 23:36:02 +0100
Message-ID: <1144103762.11511.55.camel@localhost.localdomain>
References: <1144075522.11511.20.camel@localhost.localdomain>
	 <s5hvetqac7i.wl%tiwai@suse.de>
	 <1144086510.11511.46.camel@localhost.localdomain>
	 <s5h1wwea4wq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linuxsh-dev-admin@lists.sourceforge.net>
In-Reply-To: <s5h1wwea4wq.wl%tiwai@suse.de>
Sender: linuxsh-dev-admin@lists.sourceforge.net
Errors-To: linuxsh-dev-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linuxsh-dev@lists.sourceforge.net>
List-Help: <mailto:linuxsh-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linuxsh-dev>
To: Takashi Iwai <tiwai@suse.de>, Paul Mundt <lethal@linux-sh.org>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>, linux-sh <linuxsh-dev@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-04-03 at 20:29 +0200, Takashi Iwai wrote:

> 
> Anyway, you should use dma_wait_for_completion() instead of your
> home-made one.
> 
The dma_wait_for_completion is broken for g2 dma afaics. Paul - would
you concur?

(Unfortunately the dma_residue register in g2 does not stick at 0 when
there is no residue but returns to the size of the completed dma
transfer. Therefore I can really see no alternative but to writing my
own unless Paul has a better idea.)



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
