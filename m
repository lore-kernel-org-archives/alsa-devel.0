From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: problems: flushing during snd_pcm_wait()
Date: Fri, 11 Oct 2002 22:50:35 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DA6C91B.6030502@superbug.demon.co.uk>
References: <3DA59BDF.7030904@superbug.demon.co.uk> <s5hit09chus.wl@alsa2.suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>At Fri, 11 Oct 2002 01:25:19 +1000,
>James Courtier-Dutton wrote:
>  
>
>>Hello
>>I have an application that has many different threads.
>>The sound card's PCM buffer is full during playback, and one thread is 
>>currently in snd_pcm_wait() waiting for enough space to appear in the 
>>buffer before doing the next snd_pcm_write().
>>A different thread wants to flush the buffer. There are two types of 
>>flush: -
>>1) Immeadiately empty the buffer.
>>    
>>
>
>snd_pcm_drop() ?
>
>  
>
>>2) Stop accepting snd_pcm_write() commands until the current buffer has 
>>drained.
>>    
>>
>
>snd_pcm_drain() ?
>
>
>Takashi
>
>  
>
Thankyou, I will use snd_pcm_drop(), but as a side note, what actually 
does "snd_pcm_reset()" do.
Just resetting delay to 0 does not make much sense to me.

Cheer




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
