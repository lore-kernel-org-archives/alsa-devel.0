From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: A suggestion for better resamplers in alsa.
Date: Tue, 05 Apr 2005 20:58:49 +0100
Message-ID: <4252EDF9.6090608@superbug.co.uk>
References: <s5h1x9qdcex.wl@alsa2.suse.de>	<Pine.HPX.4.33n.0504041709240.17949-100000@studcom.urz.uni-halle.de> <s5hfyy6bjzm.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hfyy6bjzm.wl@alsa2.suse.de>
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
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Mon, 4 Apr 2005 17:49:27 +0200 (METDST),
> Clemens Ladisch wrote:
> 
>>Takashi Iwai wrote:
>>
>>>...
>>>IMO, the only "perfect" solution is to change API to allow variable
>>>period sizes.  Otherwise the size mismatch always occurs regardless
>>>what trick you apply.
>>
>>This is yet another case of a constant-period-size device, like USB or
>>ymfpci.
>>
>>
>>>However, the variable period size would introduce the significant
>>>changes to the core part.
>>
>>Maybe we could generalize what usb-usx2y's hwdep does.
>>
>>
>>>For example, currently the hw/appl pointers are accumulated until
>>>the boundary near to INT_MAX.  The real DMA buffer position in the
>>>ringbuffer is calculated as 'hwptr % buffer_size'.  With the
>>>variable period size, it's no longer true.
>>
>>But buffer_size would remain constant, wouldn't it?
> 
> 
> I don't think so (in the above, I suppose the input-hwptr on rate
> plugin, not the output-hwptr on the real hardware).
> 
> 
> Takashi
> 

You are correct, the buffer size on the application side (before
resampling) would not be constant.
If the application sets 44100 Hz, the sound should play 44100 samples
from the application per second. With the current fixed period sizes,
this does not happen, approximations happen at each period, resulting in
a slightly incorrect rate at which 44100 samples are played.

I have yet another possible idea. What about reporting to the
application whether resampling needs to be done at the rate requested by
the application, together with reporting the resulting hardware rate.
The application could then detect when it should maybe try resampling
itself to improve quality. We could then have resampling helper
functions to alsa-lib, that the application could call to do the actual
resampling before it send the samples to the card. In this way the
application will get visibility of the fixed hardware period size, and
make more educated descisions regarding which output rate to use.
This could probably be supported by the addition of a new function call
"snd_pcm_prevent_resampling(...)". This call would be called by the
application just before it calls snd_pcm_set_rate(), and this would
modify the behaviour of the snd_pcm_set_rate() function or just
implement a new function "snd_pcm_set_rate_no_resample()".

We would still want alsa-lib pcm layer to do the sample format
conversion and all the other plugins, just not the problematic resampling.
alsa-lib would then provide a selection of resampling functions that the
application could then use before snd_pcm_writei() or any other form of
mmap transfer.

For example, the application xine has a feature to force a particular
output sample rate, but at the moment, the user has to manually
configure the output sample rate if they wish it to be anything apart
from the sample rate of the media stream. With this new alsa function,
xine could be informed when to use it's own internal resamplers, and
when not to bother, removing the need for the user having to manually
configure the "force_output_sample_rate" setting. But xine would still
wish to send floating point samples to alsa-lib, knowing that alsa-lib
will convert them to 24bit or 16bit depending on the sound card.

James


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
