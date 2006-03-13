From: Carlos Munoz <carlos@kenati.com>
Subject: Re: Buffer management questions
Date: Mon, 13 Mar 2006 12:03:29 -0800
Message-ID: <4415D011.80001@kenati.com>
References: <4415C6FE.2080202@kenati.com> <1142277952.9235.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1142277952.9235.14.camel@localhost.localdomain>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Adrian McMenamin wrote:

>On Mon, 2006-03-13 at 11:24 -0800, Carlos Munoz wrote:
>  
>
>>Hi all,
>>
>>I'm writing my first alsa driver and I have the following questions 
>>regarding buffer management (I've read all the documents in the alsa 
>>site but none answered my questions):
>>
>>How is the sound data replenished in the dma buffer for playback ? I 
>>call snd_pcm_lib_malloc_pages() to allocate the buffer. I assume when 
>>the trigger function is called, there is valid data in the buffer. 
>>However, once the driver sends all the data in the buffer, how does it 
>>get more data ? Should I assume the data is there and just wrap around 
>>the buffer ?
>>
>>    
>>
>
>Just been through all this myself :)
>
>The alsa middle layer will handle this for if your driver is coded
>correctly. In my case that means having a timer check that a period has
>been played out, transferring new bytes across and then calling
>snd_pcm_period_elapsed which manages the refill - give us some more
>details of your hardware and I am sure others can help 
>
>
>
>  
>

Hi Adrian,

The driver is for the Sound Interface Unit (SIU) peripheral on the 
Renesas SH7343 processor. This chip has several peripherals including 
the SIU and a DMA controller. The end product is a cell phone that will 
play music as well. The DMA controller can be optimized for transfers 
to/from internal peripherals. I was  planning to use the DMA controller 
to write the sound data from the memory to the SIU fifo. The DMA 
transfer will be 1024 bytes (period) and I will call 
snd_pcm_period_elapsed() after each transfer completes. However, I don't 
know what to do when I get to the end of the buffer. How do I know there 
is new data in the buffer. Should I just wrap around ? Also, I need to 
know if caching is disabled for the buffer, since the DMA controller is 
not cache coherent and will not read the data from the cache but 
directly from the memory.

Please let me know if you have any questions.

Thanks,


Carlos


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
