From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: start_threshold having no effect
Date: Tue, 21 Oct 2003 08:39:22 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310211239.h9LCdMWo023245@oud.linuxaudiosystems.com>
References: <20031021095054.GB30326@via.ecp.fr>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 21 Oct 2003 11:50:54 +0200."
             <20031021095054.GB30326@via.ecp.fr>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Johan Bilien <jobi@via.ecp.fr>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I am working on a voice over IP application. We would like delays from
>the write to soundcard to the actual playout lower than 50ms. Do you
>think it is impossible with ALSA ? With OSS free the delay we got were
>quite good, without any tweaking. But ALSA is said to have better
>support for full-duplex.

JACK routinely works with 5ms latency on low latency kernels, and 20ms
on regular kernels. its easy, as long as you understand how to write
software correctly.

>Maybe using a small buffer on the sound card should then be a better
>solution ? I tried with a buffer of 50 ms, and the playout is fine until
>for some reason the buffer gets full. At that point I get an EPIPE error
>on the next write, I then do a snd_pcm_prepare, can write again, but
>after that both reading and writing give a lot of errors, and after a
>very short while a write will block for more than one second. Are those
>ALSA related problems, or hardware ones ?

OSS has *NO* xrun detection. ALSA has it, and its turned on by
default. you need to set the stop threshold to -1, so that ALSA never
stops for xruns and never reports them. 

But please note: if you get EPIPE, it means there was an xrun, which
in turn means that your application was *not keeping up with the audio
interface*. you will normally never know this under OSS, whereas ALSA
offers you the chance to find out.


-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
