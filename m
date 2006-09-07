From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: oops in snd-powermac due to snd-aoa
Date: Thu, 07 Sep 2006 15:08:32 +0200
Message-ID: <1157634512.2857.69.camel@ux156>
References: <20060907124256.GA22928@aepfle.de>
	<s5h64fzltyg.wl%tiwai@suse.de> <1157634124.2857.67.camel@ux156>
	<s5h3bb3ltcd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 24B0F187
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Sep 2006 15:08:04 +0200 (MEST)
In-Reply-To: <s5h3bb3ltcd.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-09-07 at 15:05 +0200, Takashi Iwai wrote:

> Yes.  There is a bogus assumption in the invokation of i2c stuff
> there.  Feel free to fix this issue if you're interested ;)

I'd rather port the remaining things to aoa ;)

johannes

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
