From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: sample rate conversion
Date: Fri, 03 Sep 2004 17:15:35 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <413898A7.7090502@superbug.demon.co.uk>
References: <200409021953.57939.grabner@icg.tu-graz.ac.at> <Pine.LNX.4.58.0409031710210.21405@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0409031710210.21405@linux.local>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Markus Grabner <grabner@icg.tu-graz.ac.at>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Thu, 2 Sep 2004, Markus Grabner wrote:
> 
> 
>>    I am working on a Linux driver for a weird device that only accepts
>>24bit input at 39062.5Hz (PODxt Pro by Line6), so for this driver to be
The current resamplers only handle 16bit or less samples.

>>able to play regular audio files, the built-in sample rate conversion
>>(via plughw:n)  has to be used. I noticed that the resampler improved a
>>lot since ALSA-1.0.4, but it still has some problems. The sound quality
>>is significantly reduced compared to a file that is resampled offline
>>(e.g., by the resampler included in "sox"). It sounds like additional
>>noise when high frequencies occur (aliasing?). It should be technically
>>possible to use the "sox" algorithm in the ALSA libraries, but before I
>>dive into the code, I wanted to ask if anybody else is aware of this
>>problem or maybe even works on a solution!
> 
> 
> We are using only poor but very fast linear interpolation in our 
> resampling algorithm.
> 
> There are several problems to implement another algorithm with filters:
> 
> 1) algorithm state depending on the previous samples
>    - we can move back in the stream (rewind)
>    - we can also skip some samples in the stream (forward)
> 2) fixed size input and output chunks (input and output period size)
I think this point is the most problematic for sample rate conversion.
The pcm_rate.c plugin can store state, so can store previous chunks if 
needed, the real problem is that the resampling is done in chunks, and 
the application(input) chunk size does not aways equal an integer number 
of hardware(output) chunk size. e.g. input rate=44100, output 
rate=48000, output chunk size=1024, input chunk size should = 940.8
I have thought of several ideas about how to fix this problem, but they 
result is rather complicated solutions. e.g. If someone calls the 
snd_pcm_writei() we could do high quality resampling like sox does, but 
it would not work if the application is using direct audio buffer 
accesses, or if the application was trying to write one period at a 
time. So, there is not nice simple method that will work in all cases.
I recently did modifications to the alsa-lib resamplers, to fix a 
problems where it was accidentally inserting 0 samples (quiet) into the 
stream as it played or captured. It is just a simple resampler 
(interpolator) so it adds aliases, so users at least get some sound out, 
but the quality of the sound will be quite bad, although some people 
might not notice.

Resampling is generally quite CPU intensive, and also adds latency, so 
it is better if the application does the resampling using a polyphase 
filter. (I.e. I agree with Jaroslav)

> 
> In other words, it's much easier to do rate conversion in the application 
> code where samples are processed in a stream.
> 
> 						Jaroslav
> 



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
