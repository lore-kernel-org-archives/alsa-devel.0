From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: Re: [ALSA 1/2] continue on IS_ERR from platform
 device registration
Date: Tue, 11 Apr 2006 01:10:59 +0200
Message-ID: <443AE603.5070509__38608.4464415491$1144710628$gmane$org@keyaccess.nl>
References: <44347822.9050206@keyaccess.nl>	<s5h3bgqlcfd.wl%tiwai@suse.de>	<443692B2.7000309@keyaccess.nl> <s5hacat49y3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtpq3.tilbu1.nb.home.nl (smtpq3.tilbu1.nb.home.nl [213.51.146.202])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 848DD16A
	for <alsa-devel@alsa-project.org>; Tue, 11 Apr 2006 01:09:30 +0200 (MEST)
In-Reply-To: <s5hacat49y3.wl%tiwai@suse.de>
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
Cc: ALSA devel <alsa-devel@alsa-project.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> Hm, surely it's not so intuitive in the case of ISA devices.  Maybe 
> it'd be better to keep the current behavior:  probe() returns an
> error if no device is found at loading...

Okay. It's always possible to revisit the isssue later. Keeping the old
behaviour is what the already submitted patches did. probe() returning
an error is not enough; the issue was/is that that error is not
being passed up. Using drvdata as a private success flag as submitted
works fine fortunately; all drivers do a platform_set_drvdata(device,
card) just before returning success from probe().

I'll repost them following this message. Have been generated against
2.6.17-rc1-mm2.

Will also post them (and the !enable[i] patch) against 2.6.16.2 for
-stable. You already acked the !enable[i] and continue-on-is_err patches
for -stable, the third is the same unregister patch, restoring the old
fail-to-load behaviour also for -stable.

Considering that one of the rules for -stable is that fixes also need to 
be present in upstream trees, could you relay the three patches for 
-stable yourself?

Rene.




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
