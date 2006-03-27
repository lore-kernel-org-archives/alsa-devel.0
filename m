From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [ALSA] AdLib FM card driver
Date: Mon, 27 Mar 2006 10:31:13 +0200
Message-ID: <20060327083113.GB2521@turing.informatik.uni-halle.de>
References: <442710A1.5030207@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate2.urz.uni-halle.de (mailgate2.urz.Uni-Halle.DE [141.48.3.8])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 540F4143
	for <alsa-devel@alsa-project.org>; Mon, 27 Mar 2006 10:31:45 +0200 (MEST)
In-reply-to: <442710A1.5030207@keyaccess.nl>
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
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>, Adrian Bunk <bunk@stusta.de>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Rene Herman wrote:
> [...]
> I also stuck a very tiny HOWTO in ALSA-Configuration.txt, assuming quite 
> a few people would have no idea how to operate the thing, even if they 
> do happen across a card. Is it okay there?

It should probably go into a seperate file below Documentation/.

> + This module supports multiple cards. It does not support autoprobe, so
> + the port must be specified. For actual AdLib FM cards it will be 0x388.

Does it make sense to support more than one card or a non-default port
address?  I.e., is there any card using an OPL2/3 that we do not have a
driver for (except the AdLib FM)?

I think at least the port address for the first card should be defaulted
to 0x388.


Regards,
Clemens


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
