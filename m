From: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Subject: Re: "Resource temporarily unavailable" while reading
 although poll returns POLLIN event
Date: Mon, 26 Apr 2010 09:52:03 +0200
Message-ID: <4BD54623.3080808@gmail.com>
References: <4BCEE140.5060704@gmail.com>
	<4BCF24AC.3000301@gmail.com>	<alpine.LNX.2.00.1004211917120.16336@eeebox2.perex-int.cz>	<4BD02061.2010204@gmail.com>	<k2i4f3252891004231832kcd722592hac37a667da424742@mail.gmail.com>	<4BD3025D.1060207@gmail.com>
	<h2q4f3252891004241643j9ccd9315i9f8d6427752d471d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from keymachine.tbmn.org (mail.tbmn.org [87.118.84.39])
	by alsa0.perex.cz (Postfix) with ESMTP id 397611037F7
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Apr 2010 09:52:06 +0200 (CEST)
In-Reply-To: <h2q4f3252891004241643j9ccd9315i9f8d6427752d471d@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Raymond Yau wrote:
> How about the qualtity of the playback ?
> did you speak to the mic and hear the result ?

Yes, when speaking into the mike I can hear the output on the speakers.
The sound quality is reasonable for 8kHz S16_LE and there are no sound
errors (e.g. no clicks or similar).

> Refer to your pulseaudio log , PA use "front" device for playback/capture

> I: module-alsa-sink.c: Successfully opened device hw:0.
> I: alsa-util.c: Successfully attached to mixer 'hw:0'
> I: alsa-util.c: Using mixer control "PCM".

Here you can see that PA uses the "hw" device.
(It just tries to use the "front" device in the beginning which fails.
The "hw" device is opened successfully after that (see log above).)

> but your test use "hw"

In my tests I first used the "default" device which uses the PA plugin.
The test clearly showed that poll() returns with POLLIN even though far
less than avail_min frames are available for reading.
Hence I suspect that there is a *bug* somewhere in the pulseaudio code
(either the plugin or the daemon).

In order to show that my code is working fine and the erroneous poll
behavior does not occur when PA is not used, I also tested with the "hw"
device.
The result, as mentioned, it that the POLLIN event is correctly returned
after at least avail_min frames are available.

In short:

* test with "default" uses PA: erroneus poll() behavior, BUG
* test with "hw" does *not* use PA: everything works fine


> Do you mean that you suspect the problem is related to alsa-pulse plugin or
> PA server ?

Yes.

cheers,
Stefan
