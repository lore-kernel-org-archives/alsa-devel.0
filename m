From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: [PATCH] ALSA driver for Yamaa AICA on Sega
	Dreamcast
Date: Mon, 17 Apr 2006 21:00:36 +0100
Message-ID: <1145304037.9244.27.camel@localhost.localdomain>
References: <1145232784.12804.2.camel@localhost.localdomain>
	 <20060417012913.GA16821@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linuxsh-dev-admin@lists.sourceforge.net>
In-Reply-To: <20060417012913.GA16821@linux-sh.org>
Sender: linuxsh-dev-admin@lists.sourceforge.net
Errors-To: linuxsh-dev-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linuxsh-dev@lists.sourceforge.net>
List-Help: <mailto:linuxsh-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linuxsh-dev>
To: Paul Mundt <lethal@linux-sh.org>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>, linux-sh <linuxsh-dev@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


> 
> > +	/* AICA has no capture ability */
> > +	if ((err =
> > +	     snd_pcm_new(dreamcastcard->card, "AICA PCM", pcm_index, 1, 0,
> > +			 &pcm)) < 0)
> > +		return err;
> 
> Weird notation, linux kernel style would be:
> 
> 	err = snc_pcm_new(...);
> 	if (unlikely(err < 0))
> 		return err;
> 
> please refactor accordingly.
> 

Actually this sort of formulation is common in the kernel as any grep
will show. In fact I copied it directly from the guide to writing ALSA
drivers:

http://www.alsa-project.org/~iwai/writing-an-alsa-driver/x447.htm

But I am happy to change it.



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
