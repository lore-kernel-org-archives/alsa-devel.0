From: RJ Ryan <rryan@mixxx.org>
Subject: Re: [Portaudio] Recording devices opened mono still
 sending stereo causing corrupt audio
Date: Fri, 11 Oct 2013 21:20:22 -0400
Message-ID: <CAKrSP5YF0D+yAwXahUKBvK0jC30bXF4qBXNQPcaUWdrc9xo8Pw__21181.6362258562$1381736768$gmane$org@mail.gmail.com>
References: <52575722.7060208@mixxx.org> <5257F01D.3040908@ladisch.de>
 <5258A040.8050708@audiomulch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f180.google.com (mail-ob0-f180.google.com
 [209.85.214.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FC79261A81
 for <alsa-devel@alsa-project.org>; Sat, 12 Oct 2013 03:20:45 +0200 (CEST)
Received: by mail-ob0-f180.google.com with SMTP id wn1so3353108obc.11
 for <alsa-devel@alsa-project.org>; Fri, 11 Oct 2013 18:20:45 -0700 (PDT)
Received: by mail-ie0-f173.google.com with SMTP id u16so2171835iet.18
 for <alsa-devel@alsa-project.org>; Fri, 11 Oct 2013 18:20:43 -0700 (PDT)
In-Reply-To: <5258A040.8050708@audiomulch.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Portaudio Mailing List <portaudio@music.columbia.edu>
Cc: mixxx-devel <mixxx-devel@lists.sourceforge.net>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

bcc: alsa-devel

Excellent -- glad to see it's as simple as a fix to the ALSA hostapi! Is
anyone from the PA side interested in picking this up or should we work on
a patch? We'd like to fix this for good in our next major release (early
2014?) so it would be good to try and get this into a PA release soon so we
can get it packaged in the various distros.

Best regards,
RJ


On Fri, Oct 11, 2013 at 9:05 PM, Ross Bencina <rossb-lists@audiomulch.com>wrote:

> On 11/10/2013 11:33 PM, Clemens Ladisch wrote:
>
>> Sean M. Pappalardo - D.J. Pegasus wrote:
>>
>>> the problem occurs when PA is asked to open just one channel of
>>> a sound input device yet the device seems to stream two anyway.
>>>
>>
>> Many devices do not support mono streams.
>>
>>  I'm suspecting there's a miscommunication between PA and ALSA
>>>
>>
>> The communication between ALSA and PA works just fine; ALSA reports the
>> minimum number of channels, and PA saves this value.
>>
>> What does not work is the communication between PA and the application;
>> PA has no mechanism to report the minimum number of channels.
>>
>
> Since PortAudio is designed to provide useful features to the client, it
> does not make sense to restrict the client from opening a stereo device as
> mono.
>
> This is by design.
>
> However obviously there is an implementation issue in PA/ALSA if it does
> not respect ALSA's interface requiring support for a minimum number of
> channels > 1.
>
> In this case PortAudio should either select the first (left) channel  or
> downmix to mono before passing to the client. I'd suggest the former. (or
> in general min(userRequestedChannelCount,**availableChannelCount)
>
>
>
>  Even worse, if some application tries to use a channel count that is too
>> low, PA cleverly replaces it with the minimum support channel count:
>>
>>    self->numHostChannels = PA_MAX( params->channelCount,
>> StreamDirection_In == streamDir ? devInfo->minInputChannels
>>            : devInfo->minOutputChannels );
>>
>> and then does not bother to tell anybody about this.
>>
>
> The implementation should be dropping the second channel. So it should be
> telling the PA buffer processor to do so.
>
>
>
>  This bug is especially egregious because PA does later check whether the
>> number of channels is actually supported by the device; the code above
>> ensures that this checks uses the wrong channel number.
>>
>
> Thanks for your input,
>
> Ross.
>
>
>
>
>> Regards,
>> Clemens
>>
> ______________________________**_________________
> Portaudio mailing list
> Portaudio@music.columbia.edu
> http://music.columbia.edu/**mailman/listinfo/portaudio<http://music.columbia.edu/mailman/listinfo/portaudio>
>
