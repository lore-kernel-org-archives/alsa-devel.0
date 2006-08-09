From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Linux v2.6.18-rc4, snd-aoa link error
Date: Wed, 09 Aug 2006 14:29:38 +0200
Message-ID: <44D9D532.9010200@sipsolutions.net>
References: <Pine.LNX.4.64.0608061127070.5167@g5.osdl.org>	<20060808194651.GA29482@aepfle.de>	<1155067429.26338.96.camel@mindpipe>	<s5hoduudypc.wl%tiwai@suse.de>	<44D9B1BE.9070600@sipsolutions.net>	<s5hk65idwia.wl%tiwai@suse.de>	<44D9C8E5.10109@sipsolutions.net>
	<s5h7j1idrvf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 88BFF222
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Aug 2006 14:29:46 +0200 (MEST)
In-Reply-To: <s5h7j1idrvf.wl%tiwai@suse.de>
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
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>, Lee Revell <rlrevell@joe-job.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
>> Yeah, I really should know :) But I'm not sure at the moment, and the 
>> powermac I own is a few hundred kilometers away...
>>     
>
> Don't worry, we can wait :)
>   
Maybe someone on linuxppc-dev can quickly check? Does a G5 use 
I2C_POWERMAC for access to the codecs? I think it does, but there are 
other I2C busses as well.
>> That looks good to me, and should get rid of the build failure. However, 
>> if one doesn't configure I2C_POWERMAC, no codec will ever be found at 
>> runtime.
>>     
>
> Yes, that's my concern, too.
>   
I'm not sure how much we should force the users to a sensible 
configuration ;) But I suppose selecting I2C_POWERMAC is fine for all 
relevant machines for now.

johannes

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
