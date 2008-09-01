From: William Estrada <MrUmunhum@popdial.com>
Subject: Re: Using GDB for ALSA How to?
Date: Mon, 01 Sep 2008 13:33:28 -0700
Message-ID: <48BC5198.1050906@popdial.com>
References: <48BC4E6A.1070508@popdial.com> <20080901202407.GL15719@lug-owl.de>
Reply-To: MrUmunhum@popdial.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from MAIL02.inside.adbasesystems.com (mail.1dial.com [64.136.164.73])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D69924508
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Sep 2008 22:33:44 +0200 (CEST)
In-Reply-To: <20080901202407.GL15719@lug-owl.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: William Estrada <MrUmunhum@popdial.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Yes, the device is opened. Is that what you mean??


Jan-Benedict Glaw wrote:
> On Mon, 2008-09-01 13:19:54 -0700, William Estrada <MrUmunhum@popdial.com> wrote:
>   
>>   I am trying to use GDB with my ALSA program. I wish to display (print) 
>> a handle for
>> an snd_pcm_t pointer. I am getting the following error:
>>     
>>> (gdb) p Device
>>> $9 = (snd_pcm_t *) 0x92be458
>>> (gdb) p *Device
>>> $10 = <incomplete type>
>>>       
>>   How do I display the snd_pcm_t structure?
>>     
>
> My guess is that this pointer is simply uninitialized. Did you check
> that it was properly prepared?
>
> MfG, JBG
>
>   


-- 
William Estrada
MrUmunhum@popdial.com
Mt-Umunhum-Wireless.net ( http://Mt-Umunhum-Wireless.net )
Ymessenger: MrUmunhum
