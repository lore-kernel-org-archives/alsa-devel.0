From: Manjunath A M <manjunatham@tataelxsi.co.in>
Subject: Re: Audio driver for dbAu1250 Development board
Date: Mon, 08 Jun 2009 09:26:55 +0530
Message-ID: <4A2C8C07.2060904@tataelxsi.co.in>
References: <4A2793A6.9090800@tataelxsi.co.in>
	<20090606131313.07e142f8@scarran.roarinelk.net>
Reply-To: manjunatham@tataelxsi.co.in
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpin2.mailsecure.in (SMTPIN2.mailsecure.in [121.241.224.3])
	by alsa0.perex.cz (Postfix) with ESMTP id 2928D244F2
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 05:56:59 +0200 (CEST)
In-Reply-To: <20090606131313.07e142f8@scarran.roarinelk.net>
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


Hi Manuel,

Thanks for your reply..

I need to use the kernel for DB1250 borad..with the patches that you are 
suggesting will audio work on this board??
 kindly provide me the link for patches that you are suggesting..

Thanks
Manjunath.AM





Manuel Lauss wrote:
> Hello!
>
> On Thu, 04 Jun 2009 14:58:06 +0530
> Manjunath A M <manjunatham@tataelxsi.co.in> wrote:
>   
>> I am trying to make audio up in dbAu1250 Development board, I downloaded 
>> linux-2.6.29.4 kernel from the site 
>> "http://www.linux-mips.org/pub/linux/mips/kernel/v2.6/ " and
>> applied the patch "asoc-v2.6.29-rc8-2009-03-17.patch"downloaded from 
>> "http://opensource.wolfsonmicro.com/~git/asoc/"
>> but while compiling i am getting the bellow errors
>>
>> ********Linux compilation errors*************
>>
>> sound/soc/au1x/exmmb-ac97.c:24:38: error: asm/mach-exm1200/exm1200.h: No 
>>     
>
> For AC97, I suggest you use the "sound/soc/au1x/sample-ac97.c" driver.
> It does work on the DB1200 (and ONLY the db1200).   If you also want
> I2S, I posted a set of patches on linux-mips which enhance DB1200
> support; among it is a replacement audio machine driver with both AC97
> and I2S (selectable through one of the board switches of the S6 group).
>
> 	Manuel Lauss
>
>   


The information contained in this electronic message and any attachments to this message are intended for the exclusive 
use of the addressee(s) and may contain proprietary, confidential or privileged information. If you are not the intended
 recipient, you should not disseminate, distribute or copy this e-mail. Please notify the sender immediately and destroy
 all copies of this message and any attachments contained in it.
