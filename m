From: Benno Senoner <sbenno@gardena.net>
Subject: Re: Event Based time synchronization with ALSA
Date: Tue, 18 Jan 2005 14:46:16 +0100
Message-ID: <41ED1328.4070802@gardena.net>
References: <41EB9874.4060407@hypersonic.it> <41EBEB8F.9030009@gardena.net> <41ECF73F.7070404@hypersonic.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <41ECF73F.7070404@hypersonic.it>
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

Paolo Losi wrote:

> Hi Benno,
>
>     thank you very much for you response.
>     
> Benno Senoner wrote:
>  > The above routine has the advantage that you can use any kind of
>
>> periodsize (fragment size) in ALSA
>> and the send_rtp packet() always gets 20msec worth of data.
>> But you must ensure that the ALSA period size must be <20msec , 
>> otherwise too much jitter is introduced.
>
>
> I see your point.... but I would have two objections:
> - I don't want/can't use threads


you can use a single thread as described in my previous mail.
you just write to a ringbuffer and afterwards read from the same 
ringbuffer to have an easy method
to queue up samples until you have at least 20msec worth of audio data 
(160 samples at 8kHz).
But as said you need to write(and read) to the ringbuffer with a 
granularity greater than 20msec otherwise
weird things do happen.
The same can be done on the receiving side. Assume you read/write audio 
samples with eg 8msec frequency
(period size 64 samples).
At each iteration you check if an RTP packet arrived (using nonblocking 
recv() ) and if it arrived you insert it into
the receiving buffer (check ordering etc).

> - I get too much jitter

this is not true. Jitter will always be here on a RTP data stream and 
that's why the receiver must use a receiving
buffer that is at least 2-3 times bigger than the payload of the RTP 
packet (eg 20msec).
For example if the receive buffer is 40msec you can have up to 40msec 
jitter (eg a packet can come up to 40msec late)
without any audio degradation. Keep in mind that an oversea SIP call can 
often have hundreds of msec of latency
and thus the jitter could be in the range of 100msec or more.
This means you have to use an adequately sized buffer, otherwise you get 
lots of late packets and therefore grabled audio.

Anyway why not use jack as the API for your application ? It's easier to 
program and you don't have to mess with
setting up the soundcard, deal with different characterstics of 
soundcards (like sample rate, sample size etc, ... ok
ALSA plughw can ease some pain too).

Jaroslav, while you are right about that periodsize can be != power of 
two on many cards, I agree with Takashi about
trying to use a power of two periodsize if possible.
Anyway the algorithm I proposed in my former mail does not impose 
restrictions on the period size except that
it must be < than RTP audio period size.
So if you use  RTP audio sizes of 20msec, you can use anything from  19 
down to 1msec.
But when choosing the capture size it is better to not go too low 
otherwise you could get XRUNs and you load up
the CPU more. Probably around 8-10msec is an ideal size because the 
introduced jitter is < 10msec (which
is not a problem for the receiver size which will have a receive buffer 
of N*20msec) plus  you can probably run
the app without SCHED_FIFO without getting significant xrun problems 
(except in high load situations).
 

>
> If I make poll timeout every 20ms in the main loop,
> I'm sure I get 20ms worth of data
> so I can busy loop to reading (in blocking mode) all samples
> (If I would want to enforced that period is power of two, I could
> choose the max power of two number of samples that is divider of the 
> required number of samples)
> That would be 8000HZ sampling for 20ms => 160 sample per packet
> => 5 32samples reads


5 x 32 sample reads means you must wake up the thread each 4msec, 
perhaps a bit of a waste.
Plus I would not trust the OS that you get woken up at the right time, 
but since I don't know ALSA's internals
well it could be that it does not matter since ALSA might queue up the 
samples in an internal ringbuffer for you
which could make my proposed external ringbuffer redundant.
The advantage of my proposal is that it works with any kind of audio 
interface and with any period size.
When coding apps I tend to make as little as possible assumptions about 
underlying APIs and subsystems
because if at a later time you want to switch to other APIs or hardware 
changing the app gets very messy.

>
> But I'd rather tell ALSA: "please wake up poll as soon as you have
> 160 samples available". Is that feaseble? Can I expect to be always
> woken up?
>
> How
>
> snd_pcm_sw_params_set_avail_min
> snd_pcm_sw_params_set_sleep_min
> snd_pcm_sw_params_set_start_threshold     
>
> relates to my problem?
>
> I tried to read the API doc but, since I've no experience with audio
> programming, I didn't get all the points...

> Can anyone point to a good poll based read example?

On the http://www.alsa-project.org site there should be some examples, 
otherwise try to check
out the source of aplay.
And if ALSA is too complex for you there's always jack  :) 
http://jackit.sf.net
What I prefer of jack is the ability to route audio from/to any app, use 
many apps at the same
time sharing the same soundcard etc.
For example a SIP phone with jack support could easily record the 
conversation into a HDR app
(like eca, ardour etc), or you could feed music into it by simply 
connecting the output from any app
into the SIP phone. (eg connect the softsynth to the SIP phone and then 
play a piece live for your
party on the other side :) )

>     thanks again benno!

no problem :)
I wish you luck with your audio programming. It's sometimes very 
frustrating until you get things
running smoothly but the gratification is big and you can learn lots of 
things when implementing
real time audio/networking apps. (synchronization, buffering, 
multithreading, jitter handling, scheduling etc).

cheers,
Benno
http://www.linuxsampler.org



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
