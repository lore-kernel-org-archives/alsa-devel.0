From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [ALSA] ISA drivers bailing on first IS_ERR
Date: Sat, 25 Mar 2006 01:39:11 +0100
Message-ID: <4424912F.2080109__46434.6510627822$1143247162$gmane$org@keyaccess.nl>
References: <4423848E.9030805@keyaccess.nl> <s5hslp8nlpk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtpq3.tilbu1.nb.home.nl (smtpq3.tilbu1.nb.home.nl [213.51.146.202])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5AA3319D
	for <alsa-devel@alsa-project.org>; Sat, 25 Mar 2006 01:38:09 +0100 (MET)
In-Reply-To: <s5hslp8nlpk.wl%tiwai@suse.de>
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
Cc: Greg Kroah-Hartman <gregkh@suse.de>, ALSA devel <alsa-devel@alsa-project.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> These looks OK to me.  Could you regenerate patches against the latest
> git (or ALSA CVS) ?
> 
> Or, it might be better against to mm tree, since pnp registrations
> will be modified there, too.  They should go also to mainstream
> together.

Will do.

> Nevertheless, the patches (this and the previous one) are good to go
> to stable tree, too.

I'll wait a bit for a comment from Greg on the error propagation thing 
and will submit both then.

Even when simply returning the error as the patch to bus_add_device() 
did, there's a problem in that driver_probe_device() specifically 
ignores -ENODEV and -ENXIO. I suppose that's for hotpluggable stuff, 
where do you do want the driver loaded even without devices...

I guess for -stable the minimal fix would be to make sure all the probe 
methods do not return -ENODEV. I'll audit them for that. For mainline, 
it might be a better idea to have an option in the platform_driver 
struct that, no, we certainly don't want to ignore -ENODEV for this 
ancient non-hotplug non-pnp ISA stuff.

Needs a comment from Greg as well.

Rene.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
