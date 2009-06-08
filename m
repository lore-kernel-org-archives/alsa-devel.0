From: Manjunath A M <manjunatham@tataelxsi.co.in>
Subject: Re: Audio driver for dbAu1250 Development board
Date: Mon, 08 Jun 2009 12:36:30 +0530
Message-ID: <4A2CB876.1080701@tataelxsi.co.in>
References: <4A2793A6.9090800@tataelxsi.co.in>
	<20090606131313.07e142f8@scarran.roarinelk.net>
	<4A2C8C07.2060904@tataelxsi.co.in>
	<20090608060616.GA20003@roarinelk.homelinux.net>
Reply-To: manjunatham@tataelxsi.co.in
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpin1.mailsecure.in (SMTPIN1.mailsecure.in [121.241.224.1])
	by alsa0.perex.cz (Postfix) with ESMTP id 73B4E2442E
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 09:06:32 +0200 (CEST)
In-Reply-To: <20090608060616.GA20003@roarinelk.homelinux.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <mano@roarinelk.homelinux.net>
Cc: alsa-devel@alsa-project.org, "nitinm76 at yahoo.com"@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Thanks a lot, surely will test and comeback to you!!!

Regards
Manjunath.AM

Manuel Lauss wrote:
> Hello!
>
> On Mon, Jun 08, 2009 at 09:26:55AM +0530, Manjunath A M wrote:
>   
>> I need to use the kernel for DB1250 borad..with the patches that you are 
>> suggesting will audio work on this board??
>>     
>
> Yes, I don't  have any problems with audio playback on my Db1200.  A note
> on I2S though:  you need to unmute the "HiFi Playback Switch" in alsamixer
> before starting playback, otherwise the WM8731 won't provide bitclock and
> you'll get timeout errors on playback.  AC97 works fine as-is.
>
>
>   
>> kindly provide me the link for patches that you are suggesting..
>>     
>
> At a minimum, apply these here in this order:
> http://marc.info/?l=linux-mips&m=124429033530426&w=2
> http://marc.info/?l=linux-mips&m=124440001201703&w=2
> http://marc.info/?l=linux-mips&m=124440013101823&w=2
> http://marc.info/?l=linux-mips&m=124440005401759&w=2   (Db1200 audio)
>
> The last two contain new DB1200 support and DB1200 audio system; they
> depend on the first two.
>
>
>
> These are part of 2 separate patchseries I posted to linux-mips over
> the weekend.  I'd by very grateful if you could give them a spin,
> Alchemy testers are very rare...
>
> These links point to the first patches in each series, apply them in
> this order:
> http://marc.info/?l=linux-mips&m=124429030830390&w=2
> http://marc.info/?l=linux-mips&m=124440000101690&w=2
>
>
> 	Manuel Lauss
>
>   


The information contained in this electronic message and any attachments to this message are intended for the exclusive 
use of the addressee(s) and may contain proprietary, confidential or privileged information. If you are not the intended
 recipient, you should not disseminate, distribute or copy this e-mail. Please notify the sender immediately and destroy
 all copies of this message and any attachments contained in it.
