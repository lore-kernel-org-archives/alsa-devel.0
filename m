From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: problems: flushing during snd_pcm_wait()
Date: Fri, 11 Oct 2002 23:23:55 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DA6D0EB.1010509@superbug.demon.co.uk>
References: <Pine.LNX.4.33.0210111458330.1244-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@perex.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>
>
>>>      
>>>
>>Thankyou, I will use snd_pcm_drop(), but as a side note, what actually 
>>does "snd_pcm_reset()" do.
>>Just resetting delay to 0 does not make much sense to me.
>>    
>>
>
>It drops all samples in the ring buffer (thus reseting delay to 0). Note 
>that everybody are welcome to improve the current documentation 
>(preferably with patches).
>
>						Jaroslav
>  
>
Ok, so snd_pcm_drop drops all samples in the buffer, so I would assume 
this sets the delay to 0.
so snd_pcm_reset drops all sample in the buffer, so as you say is sets 
delay to 0.
So my question is "What is the difference between the 2 functions?"

Cheers
James





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
