From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: alsa pulse bugs
Date: Mon, 05 May 2008 10:44:29 +0100
Message-ID: <fvmktt$ofl$1@ger.gmane.org>
References: <20080505103410.zv8dezd9z44cksoc@dbservice.com>	<fvmi82$f7a$1@ger.gmane.org>	<20080505111126.lhtr3bwyo0sg4wc4@dbservice.com>
	<fvmjd0$it8$1@ger.gmane.org>
Reply-To: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <pulseaudio-discuss-bounces@mail.0pointer.de>
In-Reply-To: <fvmjd0$it8$1@ger.gmane.org>
List-Unsubscribe: <https://tango.0pointer.de/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=unsubscribe>
List-Archive: <https://tango.0pointer.de/pipermail/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@mail.0pointer.de>
List-Help: <mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=help>
List-Subscribe: <https://tango.0pointer.de/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=subscribe>
Sender: pulseaudio-discuss-bounces@mail.0pointer.de
Errors-To: pulseaudio-discuss-bounces@mail.0pointer.de
To: pulseaudio-discuss@mail.0pointer.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Colin Guthrie wrote:
> tom@dbservice.com wrote:
>>> Re the snd_pcm_delay() including network latency (#3945), this clearly
>>> makes sense for network streams. Does you proposed fix include this
>>> delay (albeit with the improvement that it also will drop to 0 if there
>>> are no samples queued)?
>> snd_pcm_delay() should not include any network latency. The API is  
>> defined as 'read pointer - write pointer', and applications expect  
>> that. Or at least they expect that when all samples are played that  
>> the delay drops to zero.
> 
> With the caveat of very limited technical knowledge, I can agree on the 
> latter point (drop to 0 when all samples are played), but if it was 
> implemented sans net-delay in pulse would this not cause e.g. a-v sync 
> issues when playing via alsa to a networked PA server? If so then this 
> fix would introduce another bug.

Actually just having a very quick glance at the Alsa API docs, it 
doesn't mention that this value should be 0 if there are no samples to play:

http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m.html#ga0d9e14a4be65209eb549e48a9f07302

Closest it says is: "It's positive and less than buffer size in normal 
situation".

So perhaps this is an invalid assumption at the wine side?

Is there perhaps a more appropriate API call they can use to do whatever 
test they are doing?

Col
