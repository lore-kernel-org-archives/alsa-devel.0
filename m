From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Fwd: Re: Linux 2.6.10-ac8] - Patch breaks audio
	report
Date: Thu, 13 Jan 2005 17:02:34 +0000
Message-ID: <1105634190.4644.65.camel@localhost.localdomain>
References: <1105381333.12004.83.camel@localhost.localdomain>
	 <s5hoefti7bg.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0E658205
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2005 19:06:51 +0100 (MET)
Received: from localhost.localdomain (unknown [81.2.110.250])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id 883C042E38
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2005 19:06:51 +0100 (MET)
In-Reply-To: <s5hoefti7bg.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Iau, 2005-01-13 at 17:10, Takashi Iwai wrote:
> He just needs to turn off "Headphone Jack Sense" mixer switch.  That
> resets the bit which was turned on by the patch.
> 
> The bit was set since most of machines with this codec are laptops and
> need this feature.


Are you sure - I've been _deluged_ by complaints about audio breakage
from this change ?



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
