From: Ross Bencina <rossb-lists@audiomulch.com>
Subject: Re: [alsa-devel] Recording devices opened mono still
 sending stereo causing corrupt audio
Date: Sat, 12 Oct 2013 12:05:04 +1100
Message-ID: <5258A040.8050708@audiomulch.com>
References: <52575722.7060208@mixxx.org> <5257F01D.3040908@ladisch.de>
Reply-To: Portaudio Mailing List <portaudio@music.columbia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <portaudio-bounces@music.columbia.edu>
In-Reply-To: <5257F01D.3040908@ladisch.de>
List-Unsubscribe: <http://music.columbia.edu/mailman/options/portaudio>,
	<mailto:portaudio-request@music.columbia.edu?subject=unsubscribe>
List-Archive: <http://music.columbia.edu/pipermail/portaudio>
List-Post: <mailto:portaudio@music.columbia.edu>
List-Help: <mailto:portaudio-request@music.columbia.edu?subject=help>
List-Subscribe: <http://music.columbia.edu/mailman/listinfo/portaudio>,
	<mailto:portaudio-request@music.columbia.edu?subject=subscribe>
Errors-To: portaudio-bounces@music.columbia.edu
Sender: portaudio-bounces@music.columbia.edu
To: Portaudio Mailing List <portaudio@music.columbia.edu>
Cc: mixxx-devel <mixxx-devel@lists.sourceforge.net>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On 11/10/2013 11:33 PM, Clemens Ladisch wrote:
> Sean M. Pappalardo - D.J. Pegasus wrote:
>> the problem occurs when PA is asked to open just one channel of
>> a sound input device yet the device seems to stream two anyway.
>
> Many devices do not support mono streams.
>
>> I'm suspecting there's a miscommunication between PA and ALSA
>
> The communication between ALSA and PA works just fine; ALSA reports the
> minimum number of channels, and PA saves this value.
>
> What does not work is the communication between PA and the application;
> PA has no mechanism to report the minimum number of channels.

Since PortAudio is designed to provide useful features to the client, it 
does not make sense to restrict the client from opening a stereo device 
as mono.

This is by design.

However obviously there is an implementation issue in PA/ALSA if it does 
not respect ALSA's interface requiring support for a minimum number of 
channels > 1.

In this case PortAudio should either select the first (left) channel  or 
downmix to mono before passing to the client. I'd suggest the former. 
(or in general min(userRequestedChannelCount,availableChannelCount)


> Even worse, if some application tries to use a channel count that is too
> low, PA cleverly replaces it with the minimum support channel count:
>
>    self->numHostChannels = PA_MAX( params->channelCount, StreamDirection_In == streamDir ? devInfo->minInputChannels
>            : devInfo->minOutputChannels );
>
> and then does not bother to tell anybody about this.

The implementation should be dropping the second channel. So it should 
be telling the PA buffer processor to do so.


> This bug is especially egregious because PA does later check whether the
> number of channels is actually supported by the device; the code above
> ensures that this checks uses the wrong channel number.

Thanks for your input,

Ross.


>
> Regards,
> Clemens
