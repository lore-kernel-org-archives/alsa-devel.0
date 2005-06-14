From: Tomko <tomko@avantwave.com>
Subject: Re: question : crash between kernel i2c and alsa i2c
Date: Tue, 14 Jun 2005 09:34:09 +0800
Message-ID: <42AE3411.9040709@avantwave.com>
References: <42AD5670.6070900@avantwave.com> <s5hslzme9sk.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.avantwave.com (mail.avantwave.com [210.17.210.210])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 48FA71C1
	for <alsa-devel@alsa-project.org>; Tue, 14 Jun 2005 03:34:11 +0200 (MEST)
In-Reply-To: <s5hslzme9sk.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>At Mon, 13 Jun 2005 17:48:32 +0800,
>Tomko wrote:
>  
>
>>Hi everyone,
>>
>>I know that there is a tiny i2c subsystem inside alsa , i would like to 
>>know is there any control betwen the kernel i2c subsystem and the alsa 
>>i2c ?  Will there any crashes if two i2c access the bus togethre ?
>>    
>>
>
>No, they have no relevence between them at all.
>If you try to access the same hardware, of course it would be a
>problem.  But ALSA's i2c usually accesses only the chip-connection in
>the sound card, which is quite unlikely accessed from kernel i2c.
>
>  
>
No, what i mean is what if they are accessing different device ? for 
example kernel access it's own i2c device but alsa access it's i2c audio 
device , but there is only ONE pair of i2c bus in hardware, just like 
when the alsa's i2c just initiate a "START" and throw out the hardware 
address but kernel's i2c want to initiate a "START" also and throw out 
another hardware address . How's this situation be avoided if there is 
no control between two i2c subsystem?

TOM

>Takashi
>  
>



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
