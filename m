From: Davy Durham <pubaddr@davyandbeth.com>
Subject: Re: buffers, periods, cycles.. oh my!
Date: Sat, 04 Sep 2004 20:38:15 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <413A6E07.90403@davyandbeth.com>
References: <200408291648.i7TGmvjM015281@localhost.localdomain>	 <4133A1EC.8000501@davyandbeth.com> <1094237841.2082.22.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1094237841.2082.22.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: mjander@users.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Manuel Jander wrote:

>>would prefer to have maybe a second or so of buffer time if it becomes 
>>necessary [streaming to disk and all].  I'm willing to go with the 
>>nearest power of 2 if necessary of course.  Is this possible given any 
>>hardware, or will I need to buffer captured data myself to be on the 
>>safe side?
>>    
>>
> I've got playback pretty much how I want it. But for my capture code, I
>
>
>One second of buffer time... that would be around 176KB ! I very doubt
>that any soundcard would handle that. If you want such a large buffer, i
>guess you will need a own buffer implementation in your app. Are you
>really sure that you need such a large buffer ? Remember that disk
>drivers and filesystem I/O layers provide additional buffers, so you
>don't have to bother about actual hardware latencies.
>
>  
>
Well I figured that if it's a software buffering implementation then 
what does the software much care about how much buffer time I ask for.
Now, I'm pretty sure I've got an 8k buffer working, so whatever the 
buffering mechanism is, it's not straight DMA which was limited by 4k 
you said.

thats all


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
