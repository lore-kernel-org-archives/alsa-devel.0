From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Problems with HDSP Multiface+CardBus
Date: Thu, 12 Jun 2003 15:03:33 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19QXHr-0008Mx-00@sc8-sf-list1.sourceforge.net>
References: <200306121915.31285.Jaakko.Prattala@Helsinki.FI>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 12 Jun 2003 19:15:31 +0300."
             <200306121915.31285.Jaakko.Prattala@Helsinki.FI>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaakko Pr tt l <Jaakko.Prattala@Helsinki.FI>
Cc: Jesse Chappell <jesse@essej.net>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>Maybe this is just because I don't know how to use the
>mixer... What I did was
> # /sbin/modprobe snd-hdsp line_outs_monitor=1; hdsploader
> # for i in $(seq 18); do amixer cset name=Chn,index=$i 32768; done;
> # amixer cset numid=5 26,26,32768
> # amixer cset numid=5 27,27,32768
> # aplay ...
>Isn't this supposed to give me something through the
>headphones?

use alsamixer.

as with all ALSA drivers, after loading, all channels are muted. if
there is no state to restore in asound.state or whatever its called,
they will stay muted. 

to make it "simple" to get the volumes up, the driver presents a
"simple mixer" interface that alsamixer and other similar programs can
use. it controls the gain applied to routing between a playback stream
(from the CPU) and an output (to a physical channel). you don't need
to know anything about the matrix mixer to use it, but it obviously
can't represent the full power of the matrix mixer either.

if you pass line_outs_monitor=1, then you should hear all inputs and
all outputs in the headphone outs. you don't need to set the mixer to
get this to work. i also enclose a very helpful post from a few months
back that we should really put into the wiki (below).

>As with Jochem's hdsp9652,
>cat /proc/asound/card0/pcm0p/sub0/status
>shows signs of life (state: RUNNING etc.)

please don't confuse your situation with the hdsp9652. there is a bug
in the code for the hdsp9652 that prevents any sound regardless of the
mixer settings.

-- post from roger williams --------------------------------------------

Some of the numbering is discontinuous (because the Multiface doesn't
have the Digiface's ADAT2 range of channels), so the full Multiface
I/O list is:

Inputs to HDSP Mixer
========================================================================
Multiface analogue inputs 1-8      = amixer source channels 0-7
Multiface ADAT inputs 1-8          = amixer source channels 16-23
Multiface SPDIF input              = amixer source channels 24-25
alsa_pcm:playback_1-26             = amixer source channels 26-51

Outputs from HDSP Mixer
========================================================================
Multiface analogue outputs 1-8     = amixer destination channels 0-7
Multiface ADAT outputs 1-8         = amixer destination channels 16-23
Multiface SPDIF output             = amixer destination channels 24-25
Multiface line (headphone) output  = amixer destination channels 26-27

Mapping between Multiface inputs and alsa_pcm:capture channels
========================================================================
Multiface analogue inputs 1-8      = capture_1-8
Multiface ADAT inputs 1-8          = capture_9-16
Multiface SPDIF input              = capture_17-18


-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
