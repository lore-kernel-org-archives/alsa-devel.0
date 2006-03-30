From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Midi name string in mpu401_uart not unique
Date: Thu, 30 Mar 2006 14:43:17 +0200
Message-ID: <20060330124317.GB12081@turing.informatik.uni-halle.de>
References: <200603292313.21160.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200603292313.21160.gineera@aspect135.co.uk>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Alan Horstmann wrote:
> For a card with ->shortname, snd_mpu401_uart_new creates the same string for 
> all ports on all cards of same type.

These names should be overridden by the card driver, but it's perfectly
valid behaviour.  ALSA sequencer port names are not guaranteed to be
unique.

> Muse, eg, is unable to distinguish them, and cannot use the second port.

This is a bug in Muse.


Regards,
Clemens


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
