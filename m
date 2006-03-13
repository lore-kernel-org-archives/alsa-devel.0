From: Carlos Munoz <carlos@kenati.com>
Subject: Buffer management questions
Date: Mon, 13 Mar 2006 11:24:46 -0800
Message-ID: <4415C6FE.2080202@kenati.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

I'm writing my first alsa driver and I have the following questions 
regarding buffer management (I've read all the documents in the alsa 
site but none answered my questions):

How is the sound data replenished in the dma buffer for playback ? I 
call snd_pcm_lib_malloc_pages() to allocate the buffer. I assume when 
the trigger function is called, there is valid data in the buffer. 
However, once the driver sends all the data in the buffer, how does it 
get more data ? Should I assume the data is there and just wrap around 
the buffer ?

I'm used to the write()/read() function calls to pass data in/out of 
drivers, but don't yet understand how data is passed in the alsa model. 
Any help is appreciated.

Thanks,


Carlos


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
