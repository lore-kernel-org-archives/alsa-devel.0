From: ANDREI LAHUN <zhirnyi@yahoo.com>
Subject: Re: Patch for ali5451 (ATI IGP chipset) "ali_codec_ready: codec is not ready"
Date: Mon, 7 Apr 2003 15:28:51 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030407222851.86040.qmail@web21510.mail.yahoo.com>
References: <s5hwui6qq9g.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hwui6qq9g.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--- Takashi Iwai <tiwai@suse.de> wrote:

> 
> thanks, i committed your patch to cvs.
> i changed the bit-and value to ~0x8000, since the
> alsa driver uses
> outl() for accessing while oss uses outw().
> to be sure, please check whether the latest driver
> works for you.
> 
> 
> ciao,
> 
> Takashi
> 
> 
Just checked latest cvs. No problems works good.
thank you.
Andrei.

__________________________________________________
Do you Yahoo!?
Yahoo! Tax Center - File online, calculators, forms, and more
http://tax.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
