From: alejandro <alejandro@openstudionetworks.com>
Subject: IO streams sync
Date: Tue, 20 Jun 2006 12:38:32 +0200
Message-ID: <4497D028.5060604@openstudionetworks.com>
References: <mailman.4401.1150734905.2958.alsa-devel@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <mailman.4401.1150734905.2958.alsa-devel@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Lee Revell escribi=F3:

>On Mon, 2006-06-19 at 18:17 +0200, alejandro wrote:
>  =

>
>>Hello,
>>
>>Is there any document describing the ALSA components and functions?
>>Particularly the link between audio I/O and timers, in order to frame =

>>accurate sync multiple audio cards and video.
>>    =

>>
>
>You probably want to be using JACK for this.  ALSA is just a low level
>HAL.  There are some patches floating around that add video capabilities
>("videojack").
>
>Lee
>
>  =

>
James Courtier-Dutton escribi=F3:

>alejandro wrote:
>
>>Hello,
>>
>>Is there any document describing the ALSA components and functions?
>>Particularly the link between audio I/O and timers, in order to frame =

>>accurate sync multiple audio cards and video.
>>
>>Thank you,
>>
>
>
>Alejandro,
>
>This is achieved using the snd_pcm_delay() function call.
>It gives you a measure of the number of samples between the current
>write pointer and the codec output.
>I.e. If you call snd_pcm_writei() now, it will be snd_pcm_delay() sample
>frames duration until the sample reach the speakers.
>So, from that you can accurately predict the exact time that a
>particular sample will reach the speakers, and therefore keep video in
>sync with it.
>This method is used in xine  (http://xinehq.de)
>See the audio_out.c loop.
>
>One then combines this with a resampler (as xine does), to adjust for
>clock speed differences between sound cards and the system timer, so
>this prevents sync drift.
>
>James
>
>
>

Lee and James,

It is not possible to sync two interfaces if we don't have timestamped
frame numbering (UST/MSC pairs). That means that we need to know, from a
common clock, the time at which a (numbered) frame will be output or was
input from a jack. Current time is not usable, because obviously there
is an unknown delay between function calls. If the system is not able to
produce timestamp/frame count pairs, there is no possibility to sync
audio streams or audio to video streams. I have looked at JACK, and the
situation is the same as with the ALSA API.

There are cards in the market with such timestamped operations supported
in the hardware and proprietary APIs, but is there a way to accessing
these operations from ALSA or JACK?

Thank you,

Alejandro


-- =

Alejandro Palencia
Open Studio Networks
+34 932054354
