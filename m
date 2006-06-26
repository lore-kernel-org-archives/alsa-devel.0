From: Andi Kleen <ak@suse.de>
Subject: Re: Alsa update in mainline broke ATI-IXP sound driver
	II
Date: Mon, 26 Jun 2006 20:28:31 +0200
Message-ID: <200606262028.31807.ak__21250.713725067$1151346536$gmane$org@suse.de>
References: <200606252139.36002.ak@suse.de> <200606261845.32450.ak@suse.de>
	<s5hr71b95q7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3CB4A256
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jun 2006 20:28:34 +0200 (MEST)
In-Reply-To: <s5hr71b95q7.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org


> OK, and still you get the same error like:
> 
> 	ALSA lib confmisc.c:672:(snd_func_card_driver) cannot find card '0'
> 	...
> ??

Yes.

> Any change if you set CONFIG_SND_DYNAMIC_MINORS=y ?

With that it finally works. Thanks.

Still can it be fixed?

-Andi


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
