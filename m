From: "Paul Kavan" <pkavan@gmail.com>
Subject: SoC Machine Code Suggestions
Date: Wed, 27 Jun 2007 10:47:26 -0500
Message-ID: <61c0054e0706270847n42fbd896lc2e778e1e3862380@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by alsa0.perex.cz (Postfix) with ESMTP id C171824504
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jun 2007 17:47:27 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id h2so360939ugf
	for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2007 08:47:27 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

First, thanks to all for helping me get the at91 soc stuff working with my
board and codec. It now plays telecom quality audio using aplay and records
it as well using arecord. For those who were following my trials and did not
hear what the solution was, essentially, when the at91-ssc code goes into
playback mode, it only activates the TX side of the SSC (PCM) bus.
Similarly, when it is in capture mode, it only activates the RX side of the
bus. This certainly makes sense and works in most situations I am sure.
However, I needed both the RX and TX frames operating in both playback and
capture. As such, I had to modify at91-ssc slightly to accomplish this.

Now that I have decent audio, I want to clean up around the edges of the
audio and determine the best way to proceed with my application code.

First. when the pcm interface starts/stops, I get a pop that comes from the
codec analog output transitioning some. Now, there may be some hardware
fixes to this, but what I would like to do it mute the amp until the last
possible second before audio is played. I can accomplish this with a simple
gpio call, but am not sure where best to turn the mute on and off. Any
suggestions with that would be appreciated.

Also, my next phase of development is to determine whether I need to write
my own application to accomplish what I want to do, or if there is an
application out there that will do the trick--and that I can cross-compile
to an ARM. What I would like is an application I will stream audio
(half-duplex) between two ARM boards connected via ethernet. I would need to
be able to control the start/stop of the audio. Sometimes this control will
depend on the state of the machine and other times it will be activate with
a button press by the user. I hope that makes sense. Obviously it would have
to seamlessly stream to the codec via ALSA. Also, there may be times when it
streams to a pc. Now, the codec uses 8-bit ulaw, so this code if it were on
a pc, would need to be able to play that on the pc in its native state or
some type of conversion on the fly.

I guess you can think of the application as similar to voip, but half duplex
instead of full duplex. Does anyone know if something like this exists that
I might use. If not, how hard would it be to code this for ALSA?

Thanks again and I look forward to your responses.

Paul



-- 
***************************************
Paul David Kavan
Project Engineer
GRH Electronics, Inc.
402-734-4900
pkavan@gmail.com
***************************************
