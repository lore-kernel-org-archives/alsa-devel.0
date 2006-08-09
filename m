From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Linux v2.6.18-rc4, snd-aoa link error
Date: Wed, 09 Aug 2006 13:37:09 +0200
Message-ID: <44D9C8E5.10109@sipsolutions.net>
References: <Pine.LNX.4.64.0608061127070.5167@g5.osdl.org>	<20060808194651.GA29482@aepfle.de>	<1155067429.26338.96.camel@mindpipe>	<s5hoduudypc.wl%tiwai@suse.de>	<44D9B1BE.9070600@sipsolutions.net>
	<s5hk65idwia.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F3AE7234
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Aug 2006 13:37:23 +0200 (MEST)
In-Reply-To: <s5hk65idwia.wl%tiwai@suse.de>
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
Cc: Olaf Hering <olaf@aepfle.de>, Lee Revell <rlrevell@joe-job.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Someone who owned G5 must know...
>   
Yeah, I really should know :) But I'm not sure at the moment, and the 
powermac I own is a few hundred kilometers away...
> diff -r 5b67bba2d36f aoa/codecs/Kconfig
> --- a/aoa/codecs/Kconfig	Tue Aug 08 21:13:42 2006 +0200
> +++ b/aoa/codecs/Kconfig	Wed Aug 09 12:10:43 2006 +0200
> @@ -1,6 +1,7 @@ config SND_AOA_ONYX
>  config SND_AOA_ONYX
>  	tristate "support Onyx chip"
>  	depends on SND_AOA
> +	select I2C
>  	---help---
>  	This option enables support for the Onyx (pcm3052)
>  	codec chip found in the latest Apple machines
> @@ -18,6 +19,7 @@ config SND_AOA_TAS
>  config SND_AOA_TAS
>  	tristate "support TAS chips"
>  	depends on SND_AOA
> +	select I2C
>  	---help---
>  	This option enables support for the tas chips
>  	found in a lot of Apple Machines, especially
>   
That looks good to me, and should get rid of the build failure. However, 
if one doesn't configure I2C_POWERMAC, no codec will ever be found at 
runtime.

johannes

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
