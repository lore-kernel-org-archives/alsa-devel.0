From: Tim Goetze <tim@quitte.de>
Subject: [ot] Re: Xruns with Audiophile 2496 M-audio
Date: Sat, 29 May 2004 16:31:32 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0405291614570.566@autumn>
References: <20040529114908.2118135c@pentium233.krystal.net>
 <Pine.LNX.4.58.0405291234350.566@autumn>  <20040529131601.641aa202@pentium233.krystal.net>
  <1085830277.21677.17.camel@eviltwin>  <20040529140631.09962c03@pentium233.krystal.net>
  <Pine.LNX.4.58.0405291413180.566@autumn> <1085839300.21679.28.camel@eviltwin>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1085839300.21679.28.camel@eviltwin>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jan Depner <eviltwin69@cableone.net>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

[Jan Depner]

>On Sat, 2004-05-29 at 07:13, Tim Goetze wrote:
>> [Remi Bernhard]
>> >To be more sharp, i need to reduce latency because i use softsynth
>> >(zynaddsubfx, fluidsynth, etc.) that needs a low latency when playing
>> >from midi keyboard, and if not, there is a "lag" time, that man can
>> >hear, between the time when you hit the key, and the time it is played.
>> >
>> >I don't know about wich latency i spoke, i think it is system latency.
>> >So I think that buffer size is **the** parameter to change.
>> >
>> >Is that true ?
>>
>> yes.
>>
>	Yes, that is the parameter to change but no, that isn't system
>latency.  System latency is response to interrupt time not buffer fill
>time.

depends on what 'system' we're talking about, which isn't really clear
in the first place (nor is it too important, but here goes anyway ...
:)

you can see the whole setup as the system, then latency is the time
from keypress to voltage change at the DAC out. or you can just look
at the kernel side as as you do. or you can look at the time from MIDI
interrupt to the audio DAC converting the first affected audio sample.

all examples of valid 'systems' to look at in this context, depending
on whether you assume the musician's, the kernel- or the audio
application-programmer's view.

sorry for nitpicking.

tim


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
