From: Davy Durham <pubaddr@davyandbeth.com>
Subject: Re: buffers, periods, cycles.. oh my!
Date: Sat, 28 Aug 2004 19:08:27 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <41311E7B.4020608@davyandbeth.com>
References: <41301C40.10609@davyandbeth.com> <1093718182.2150.26.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1093718182.2150.26.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: mjander@users.sourceforge.net
List-Id: alsa-devel@alsa-project.org


I just wish this stuff was documented somewhere...

Ok, so periods are different than buffers.

I can set the period size and the number of periods.   And then separate 
from that seems to be setting a buffer size/time.

A sound card has to read/write to some area of memory for data 
transfer.  What's a buffer and what's a period?

Thanks,
  Davy

Manuel Jander wrote:

>Hi,
>
>On Sat, 2004-08-28 at 01:46, Davy Durham wrote:
>  
>
>>Hi,
>>   Something I don't seem to grasp is exactly what the difference is 
>>between, and min/max ranges of, periods and buffers.  I know that a 
>>sound card uses a buffer to which it reads/writes data (via DMA) and 
>>that an interrupt can be configured to trigger n times during that 
>>buffer's filling (these are periods and period count?)  Well, then 
>>there's API functions for buffer time and sizes (I assume you can set by 
>>time OR by size in frames, whichever you please, but you don't need to 
>>set by both).
>>    
>>
>
>NO! The max buffer size, period size and periods count are hardware
>dependant parameters ! You can't assume that any combintation will be
>available to you application.
>When you "try" a certain buffer setup, there happens to be a sort of
>"negotiation" with the hardware driver. That means that you may end up
>with a buffer setup that is NOT exactly what you wanted, but as close as
>possible.
>
>  
>
>>  I've looked but to no avail.. is there some higher level documentation 
>>that explains the big picture here?
>>
>>  When I fist started using the API I had a 1/4 second latency or so for 
>>playback.. I tried and tried to figure out why but couldn't.  Finally I 
>>coped JACKs use of the lib and eliminated that. 
>>    
>>
>
>Well, AFAIK, jack was designed for low latency :)
>
>  
>
>>  Now, I'm working on capture, but I can't seem to set the buffering 
>>time to more than 2*8192 frames.  I'd like to set it as high as possible 
>>to avoid studders in the recording and would rather not buffer the data 
>>myself if ALSA can already do that.
>>    
>>
>
>The buffer sizes are hardware dependant. So you will have to obey the
>values that are possible by the hardware, instead of just arbitrary
>selecting certain size/counts. Many application developer don't seme to
>understand that, which is very bad. The result are hardware dependant
>applications :P.
>Its pretty reasonable that you can't get more that 2 periods of 8192
>frames each. Many soundcards have a maximal buffer size of 64KiB, or
>smaller (a larger buffer is just silly). The maximal period size usually
>is 4KiB (page size). On i386 hardware, a period can't be larger than
>that, except if some sort of emulation is performed by the driver (and
>there would be no advantage). You may try to ask for more periods
>instead. But again, if the alsa-lib denies certain settings, your app
>should be able to cope with that. 
>
>Best Regards
>
>Manuel J.
>
>  
>



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
