From: Carlos Munoz <carlos@kenati.com>
Subject: Re: Couple of questions
Date: Mon, 20 Mar 2006 10:11:49 -0800
Message-ID: <441EF065.4020407@kenati.com>
References: <1142467271.9298.7.camel@localhost.localdomain>	 <s5hirqer7r5.wl%tiwai@suse.de> <1142680136.9435.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D683B20E
	for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2006 19:06:06 +0100 (MET)
Received: from mail.kenati.com (unknown [69.90.147.196])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id 348899929C
	for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2006 19:06:06 +0100 (MET)
In-Reply-To: <1142680136.9435.2.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adrian McMenamin wrote:

>On Thu, 2006-03-16 at 11:42 +0100, Takashi Iwai wrote:
>  
>
>>At Thu, 16 Mar 2006 00:01:11 +0000,
>>Adrian McMenamin wrote:
>>    
>>
>>>If my driver declares this:
>>>
>>>	.info = (SNDRV_PCM_INFO_NONINTERLEAVED),
>>>
>>>Can I expect samples to come in all left followed by all right, or how?
>>>      
>>>
>>Yes.  It's the non-interleaved format (LLLLLLLL....RRRRRR.....).
>>
>>    
>>
>>>And will cat somefile.wav > /dev/dsp using oss emulation respect that?
>>>      
>>>
>>Yes.
>>    
>>
>
>
>Are you sure about this bit? Either my code is extremely broken or cat
>isn't doing anything other than pump the bytes in as a simple stream
>  
>
Hi Adrian,

If I cat a wav file to /dev/dsp I just hear noise. However, if  the 
driver opens/reads the same wav file (bypassing the alsa layer) and 
feeds it to the hardware I get perfect sound. Your may want to try that 
to validate your driver and hardware. You might need to parse the file 
into RL buffers as you read it.


Carlos




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
