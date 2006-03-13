From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Buffer management questions
Date: Mon, 13 Mar 2006 19:25:52 +0000
Message-ID: <1142277952.9235.14.camel@localhost.localdomain>
References: <4415C6FE.2080202@kenati.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4415C6FE.2080202@kenati.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Carlos Munoz <carlos@kenati.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-03-13 at 11:24 -0800, Carlos Munoz wrote:
> Hi all,
> 
> I'm writing my first alsa driver and I have the following questions 
> regarding buffer management (I've read all the documents in the alsa 
> site but none answered my questions):
> 
> How is the sound data replenished in the dma buffer for playback ? I 
> call snd_pcm_lib_malloc_pages() to allocate the buffer. I assume when 
> the trigger function is called, there is valid data in the buffer. 
> However, once the driver sends all the data in the buffer, how does it 
> get more data ? Should I assume the data is there and just wrap around 
> the buffer ?
> 

Just been through all this myself :)

The alsa middle layer will handle this for if your driver is coded
correctly. In my case that means having a timer check that a period has
been played out, transferring new bytes across and then calling
snd_pcm_period_elapsed which manages the refill - give us some more
details of your hardware and I am sure others can help 




> I'm used to the write()/read() function calls to pass data in/out of 
> drivers, but don't yet understand how data is passed in the alsa model. 
> Any help is appreciated.
> 

The middle layer does most of the work for you though the implementation
details depend on how your hardware works. you don't need a write()


> Thanks,
> 
> 
> Carlos
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting language
> that extends applications into web and mobile media. Attend the live webcast
> and join the prime developer group breaking into this new coding territory!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
