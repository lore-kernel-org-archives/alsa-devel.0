From: Eric Peters <epeters@graphics.cs.uni-sb.de>
Subject: Re: Starting the device manually
Date: Tue, 25 Jul 2006 08:20:25 +0200
Message-ID: <44C5B829.1090809@graphics.cs.uni-sb.de>
References: <44C494F4.6050301@graphics.cs.uni-sb.de>
	<44C4E8D0.5020104@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <44C4E8D0.5020104@superbug.co.uk>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
> Eric Peters wrote:
>> Dear all,
>>
>> I'm a bit confused by the alsa documentation. I want to fill up a buffer
>> of a alsa device with snd_pcm_writei and then if the buffer is full, I
>> want to be able to start the playback manually. By looking to the
>> documentation, I found the method snd_pcm_sw_params_set_start_threshold.
>> In some other messages on this list there was the hint to set this
>> threshhold larger than the max_buffer_size and then the device shouldn't
>> start automatically. So I've done. But unfortunately the playback starts
>> again automatically. Here are the lines of code, I'm setting the
>> buffer_size and period_size and the start threshhold:
>>
>>   
> Why would you actually want to do what you describe. (You certainly can 
> do it with ALSA, but as to why you would want to, is another thing 
> entirely)
> It is normally better to get the buffers running, sending silence 
> samples to the buffer, and then introduce your sound when you want to.
> One can accurately determine the delay or latency of the buffer, so 
> accurately timing samples is not a problem.
> One uses a callback approach to send sound to the card. A good example 
> of this callback approach is an application called jackd.
> http://jackaudio.org/
> 
> James
> 

Thank you James for your answer,

but unfortunately it isn't a real simple application. So it wouldn't be 
possible to start the device with silence samples. But I will take this 
approach into account to make it better. :-)

Best regards,
Eric

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
