From: Andi Kleen <ak@suse.de>
Subject: Re: Alsa update in mainline broke ATI-IXP sound driver
Date: Mon, 26 Jun 2006 12:26:01 +0200
Message-ID: <200606261226.01422.ak@suse.de>
References: <200606252139.36002.ak@suse.de> <s5hpsgw9qgz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mx2.suse.de (ns2.suse.de [195.135.220.15])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BF94D1A8
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jun 2006 12:26:08 +0200 (MEST)
In-Reply-To: <s5hpsgw9qgz.wl%tiwai@suse.de>
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

On Monday 26 June 2006 12:11, Takashi Iwai wrote:
> At Sun, 25 Jun 2006 21:39:35 +0200,
> Andi Kleen wrote:
> > 
> > 
> > Since I updated an ATI x86-64 box to 2.6.17-git6 sound doesn't work anymore.
> > 
> > I just get
> > 
> > ALSA lib confmisc.c:672:(snd_func_card_driver) cannot find card '0'
> > ALSA lib conf.c:3493:(_snd_config_evaluate) function snd_func_card_driver returned error: No such device
> (snip) 
> > User land is from SUSE 10.0
> 
> First check /proc/asound/cards after loading snd-atiixp.  If the ATI
> IXP entry appears, the device was initialized and set up.  If not,
> something wrong in the driver initialization.

I'll defer testing because -git9 broke SATA too until after that is fixed.

-Andi (who hasn't had such a low quality kernel for a long time) 

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
