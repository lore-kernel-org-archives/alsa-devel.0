From: "Thomas Charbonnel" <thomas@undata.org>
Subject: Re: RME 9632 Mixer...
Date: Thu, 27 May 2004 16:54:38 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <34773.217.81.127.171.1085669678.squirrel@www.undata.org>
References: <40B3A472.5050206@wildgooses.com>
        <Pine.HPX.4.33n.0405261744140.27472-100000@studcom.urz.uni-halle.de>
        <34947.217.81.127.171.1085593594.squirrel@www.undata.org>
        <40B5ED85.7010809@wildgooses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40B5ED85.7010809@wildgooses.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: lists@wildgooses.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> Aha, at last the penny drops... I had mucked around with this based on
> the alsa wiki instructions and hadn't got it working.  I (wrongly) seem
> to remember a post where it said this was not working anymore, and gave
> up.
>

There were simple mixer controls (using the MIXER api, compatible with
alsamixer) that have been dropped, because they were conflicting with
hdspmixer's representation.
The matrix 'mixer' ctl is implemented using the HWDEP (hardware dependant)
interface because it is non-standard (and thus doesn't show up in
alsamixer).

> The trick is clearly that the normal alsa sound channels start from 16,
> and outputs start from 0.
>

The syntax is
amixer -c X numid=5 in,out,gain
where
* X is your hdsp's alsa card number
* in is the input (physical: 0-15, playback 16-31 for the hdsp 9632)
* out is the physical output targetted (0-15 for the 9632)
* gain is the gain between 0 and 65535 (-infinity to +6dB, 32768 being 0dB)

> A couple of questions while I have your attention:
>
> 1) Is 32678 really 0dB?  Should it be 32767?  (I want to avoid any
> software rescaling of values where possible)

0dB is 32768. It's true that 32767 would sound more logical, but this
appears to work (Jesse Chappell successfully fed an AC-3 external receiver
through raw spdif, which only works if the stream is totally unaltered).

> 2) How can I set the output mixer values?

You can't, that's the whole problem, and that's why it's not trivial to
implement simple mixer controls the proper way (this is also an answer to
your last post about this on alsa-user).
The mixer control is just a wrapper around the way the hardware works.
There is no output attenuation stage in hardware. It is simulated in
hdspmixer, but in the end when you move an output fader it translates to
simpler calls to the mixer ctl. This leads to your next point.

> 3) Is there any way to start hdspmixer and not load the defaults, ie so
> that I can experiment and reload hdspmixer in order to determine the
> current state of the mixer?

No, precisely because the representation hdspmixer proposes doesn't match
the hardware. There is no way for hdspmixer to reconstruct a coherent view
from the matrix mixer cache in the driver. So for now there is no way to
have hdspmixer and other programs access the mixer in a cooperative way.
The solution (already discussed on alsa-devel) is to write a daemon to
control the mixer and have all the other apps use it. I even can think of
a crooked use of the alsa ctl callback mechanism to make it compatible
with standard alsa mixer apps (define dummy simple mixer ctls, and have
the daemon register a callback for them. when an application requires a
change, the driver does nothing but the daemon is notified and does the
job).

> 4) Why does the OSS emulation write to all (16)  channels when an app
> opens it in 2 channel mode?  It's very easy to do something really silly
>  as a result (I got a rather nasty burning smell from my expensive
> speakers after inadvertently putting a lot of clipped signal through
> them at high power...)  Is this an OSS issue, or just the way this
> driver works?  (I don't have any other multichannel cards to compare
> against!)

I'm aware of this problem, but still have to track it down. I guess it's
related to the fact that the card can only be opened using all available
channels. I don't know if oss emulation uses the plughw facility, but
there must be something similar because non-interleaved streams are
handled properly, there just lacks something to deal with the number of
channel.

> 5) Can you please point me to the relevant chunk of code which does the
> software mixing in the matrix mixer, also on the output channels.  I
> want to understand which if any levels can be set on the card rather
> than by dropping bits in the driver (or if you have the time, please
> feel free to enlighten me).  I'm trying to get highest quality signal,
> and wondering whether there is any kind of output based volume control
> on this card on the outside of the DAC, as opposed to just feeding it
> fewer bits.
>

There is no software mixing, only hardware mixing. Even hdspmixer's output
stage, which is a software construction, translates to hardware calls.

> Thanks Thomas, I really appreciate the work you have done making this
> all work.  I will try and add some notes on the alsa site for the RME
> 9632 on the mixer settings
>
> Ed W
>

You're welcome. It would be indeed nice to add some 9632 specific notes on
the alsa site, thanks.

Thomas





-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
