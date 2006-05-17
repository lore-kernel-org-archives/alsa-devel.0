From: Juan Carlos Castro y Castro <jcastro@instant.com.br>
Subject: Re: Another asinine question
Date: Wed, 17 May 2006 13:22:04 -0300
Message-ID: <446B4DAC.1060906@instant.com.br>
References: <446B37A6.2080503@instant.com.br> <s5hmzdg3c93.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hmzdg3c93.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>>>>Another thing: you'll see I just "hung" another snd_pcm_file_t structure at the bottom of the original one. I'll understand if that offends people's coding sensibilities -- it offended mine. :-/
>>>>        
>>>>
>>>Does't only one file descriptor instead of the whole snd_pcm_file struct suffice?  Actually, it's used only in readi().
>>>      
>>>
>>Not really, especially when I finally tackle _readn. And even in the noninterleaved case, there's always the possibility read() will return a number of bytes that's not a multiple of the frame size (especially if the file is a named pipe). I'll need ->wbuf and some of those indexes to keep the remaining bytes for the next read.
>>    
>>
>Then let's create another object type.  It's confusing to use the existing object for completly another purpose.
>
>Also, "nextfile" doesn't sound intuitive in this case.  (it sounds like a linked chain of data.)
>  
>
Agree and agree. I DID say it was offensive. In my defense, boss was 
swinging the whip and I had to churn out code rather quickly. OK, that 
was a lame excuse. :-/

For the noninterleaved case, I think a plain dumb byte FIFO (buffer, 
head, tail) would be enough. I'll only be able to code on that tomorrow 
-- got an unrelated deadline to meet today.

Juan


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
