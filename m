From: tom@dbservice.com
Subject: Re: alsa pulse bugs
Date: Mon, 05 May 2008 11:37:08 +0200
Message-ID: <20080505113708.sqz59g43s40c4ck8@dbservice.com>
References: <20080505103410.zv8dezd9z44cksoc@dbservice.com>
	<fvmi82$f7a$1@ger.gmane.org>
	<20080505111126.lhtr3bwyo0sg4wc4@dbservice.com>
	<fvmjd0$it8$1@ger.gmane.org>
Reply-To: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <pulseaudio-discuss-bounces@mail.0pointer.de>
In-Reply-To: <fvmjd0$it8$1@ger.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://tango.0pointer.de/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=unsubscribe>
List-Archive: <https://tango.0pointer.de/pipermail/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@mail.0pointer.de>
List-Help: <mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=help>
List-Subscribe: <https://tango.0pointer.de/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=subscribe>
Sender: pulseaudio-discuss-bounces@mail.0pointer.de
Errors-To: pulseaudio-discuss-bounces@mail.0pointer.de
To: Colin Guthrie <gmane@colin.guthr.ie>
Cc: pulseaudio-discuss@mail.0pointer.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Quoting Colin Guthrie <gmane@colin.guthr.ie>:

Attached patches to #3943 and #3944. Please read the comments there.

> tom@dbservice.com wrote:
>>> Re the snd_pcm_delay() including network latency (#3945), this clearly
>>> makes sense for network streams. Does you proposed fix include this
>>> delay (albeit with the improvement that it also will drop to 0 if there
>>> are no samples queued)?
>>
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

Your arguments seem reasonable. Let's see what others have to say to  
it. It would be interesting to see how much delay such change  
introduces. I can't test PA over network at home, but if someone  
wants, the patch is attached to the bug entry in the alsa bugtracker.

>>> Also re #3942, I believe (but not sure) that the max buffer in the
>>> glitch free branch has been increased significantly (as it now needs to
>>> keep some degree of past sound as well as future buffer to allow the
>>> rewinds to work properly (this is no doubt an inaccurate description of
>>> why it's needed.... :p)) I'm not sure how this would affect this
>>> solution, but Lennart will be able to advise better.
>>
>> I'd suggest to export MAX_MEMBLOCKQ_LENGTH in a public API so that
>> applications can make use of it. If the max buffer length has been
>> increased, then the alsa pulse plugin should be able to propagate that
>> to applications using the alsa API.
>
> Well I'm not sure of the internals of the glitch-free stuff, but I doubt
> it's a buffer that can be used in quite the same way as that. Lennart
> will be able to advise if I've got the wrong end of the stick in my
> comments :)

tom
