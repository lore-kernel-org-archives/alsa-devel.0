From: Tomko <tomko@avantwave.com>
Subject: Re: about the alsa i2c interface
Date: Thu, 09 Jun 2005 15:15:53 +0800
Message-ID: <42A7ECA9.5020108@avantwave.com>
References: <9AEDBAA573BBD346BCF9637D80097D9119E60A@greysvr02.GreyInnovation.com> <1118299677.14638.1.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.avantwave.com (mail.avantwave.com [210.17.210.210])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 55C1E1CC
	for <alsa-devel@alsa-project.org>; Thu,  9 Jun 2005 09:15:58 +0200 (MEST)
In-Reply-To: <1118299677.14638.1.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:

>On Thu, 2005-06-09 at 13:09 +1000, Tehn-Yit Chin wrote:
>  
>
>>Hi,
>>
>>We are trying to provide support for the CS43L43 device under the ALSA
>>architecture on an embedded platform.
>>
>>During my early investigation, I noticed that ALSA has its own i2c code.
>>What is this required, and why doesn't it use the mainline i2c support?
>>On our platform, there are one other devices on the i2c bus, so I would
>>like to use the mainline i2c code.
>>    
>>
>
>This is explained in "Writing an ALSA Driver"  (you did read it,
>right?).  Basically the kernel's i2c layer is overly complex, and ALSA
>only needs a small subset of it, so ALSA implements its own minimal i2c
>layer.
>
>  
>
So will this cause losing control on the I2c device ? for example i have 
4 device on the i2c bus , 3 of them are under the kernel's i2c which the 
the sequence control that they can't access the bus at the same time and 
one of them are under alsa's i2c , what will happen if the alsa's i2c 
device and the kernel's i2c device access the bus together ?

Regards,
TOM


>Lee
>-------------------------------------------------------
>This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
>a projector? How fast can you ride your desk chair down the office luge track?
>If you want to score the big prize, get to know the little guy.  
>Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel
>  
>



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
