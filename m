From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Why do I get broken pipe on write to a pcm instatePREPARED?
Date: Thu, 10 Oct 2002 12:15:33 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DA4E2C5.1050703@superbug.demon.co.uk>
References: <Pine.HPX.4.33n.0210090843120.2463-100000@studcom.urz.uni-halle.de> <3DA42EEB.2030208@superbug.demon.co.uk> <200210091354.g99DsA007307@d1o87.telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
To: Anders Torger <torger@ludd.luth.se>
Cc: alsa-devel@lists.sourceforge.net, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Anders Torger wrote:

>On Wednesday 09 October 2002 15.28, you wrote:
>  
>
>>Clemens Ladisch wrote:
>>    
>>
>>>The behaviour of polling during capture is just fine:
>>>
>>>RUNNING: block until avail_min is available, then return POLLIN
>>>DRAINING: return POLLIN until buffer is empty, then return POLLERR
>>>(other states: POLLERR)
>>>
>>>The current behaviour for playback is:
>>>
>>>PREPARED: return POLLOUT until the buffer is full, then return
>>>POLLERR
>>>      
>>>
>>Why would the buffer get full in PREPARED state ?
>>Surely any sensible, "start_threshold" should cause the state to
>>change to RUNNING before the buffer is full.
>>I can't see any reason to not to use "start_threshold" in order to
>>get from PREPARED to RUNNING.
>>    
>>
>
>Because another thread that should start the card is not ready yet. In 
>threaded programming it may be fully natural to first fill the output 
>buffer and then start the card from another thread. Of course, you can 
>always adapt to how it works (for example if there would always be a 
>start threshold which could not be changed), but it is best if poll() 
>works in a way that is expected, and is conforming to standards.
>
>If poll() behaviour is changed to the proposed, we will not only get a 
>more clear standard conformance (what is conforming or not is however 
>always a question of interpretation, since there is no relevant 
>standard that directly relates to sound cards), but a more flexible API 
>in terms of how to design your multi-threaded/process applications.
>
>/Anders Torger
>
>  
>
Ok, as far as Iam concerned, my application will not care. It never 
reaches the "PREPARED, buffer full" state because I use "start_threshold".
Although my application is multi-treaded, all the audio out happens in a 
single thread. Other threads do the grabbing  the data of the hard disk 
etc. and  buffering it in memory.

I do think that any poll should block unless data can be written to the 
file handle irrespective of the BLOCK/NON-BLOCK status of the file 
handle. BLOCK/NON-BLOCK should only effect open and write calls, not 
poll calls.

I don't understand which applications prefer: -
1) "PREPARED: return POLLOUT until the buffer is full, then return POLLERR."
and which would prefer (as suggested): -
2) "PREPARED: return POLLOUT until the buffer is full, then BLOCK."

As I understand it, the poll works correctly in RUNNING state?
I think (2) would basically kill all single thread apps so on balance, I 
think (1) is the best to go with for now.

The application I have thought of is that an application might want to 
fill many file handles/streams buffers but keep them in PREPARED state. 
Then release all the channels at the same time so that they play in 
sync. But for that one does not need to do any polling in PREPARED 
state. One just does snd_pcm_write until one gets an error.

I guess the solution to all this would be to provide two different 
poll/snd_pcm_wait calls so the application writer can choose which 
behaviour they want. This would then make everyone happy, and also not 
break any old apps.

Another solution is for the application writer to use the pthreads 
"pthread_cond_wait()" to get one thread to wait until another thread has 
done some work. Then alsa would not have to change at all. ;-)

Cheers
James





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
