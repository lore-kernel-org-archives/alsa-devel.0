From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: "Resource temporarily unavailable" while reading
	although poll returns POLLIN event
Date: Tue, 27 Apr 2010 08:35:08 +0800
Message-ID: <u2s4f3252891004261735v5153335dt13c7f913cf1bc680@mail.gmail.com>
References: <4BCEE140.5060704@gmail.com> <4BCF24AC.3000301@gmail.com>
	<alpine.LNX.2.00.1004211917120.16336@eeebox2.perex-int.cz>
	<4BD02061.2010204@gmail.com>
	<k2i4f3252891004231832kcd722592hac37a667da424742@mail.gmail.com>
	<4BD3025D.1060207@gmail.com>
	<h2q4f3252891004241643j9ccd9315i9f8d6427752d471d@mail.gmail.com>
	<4BD54623.3080808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id EF4C224778
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Apr 2010 02:35:09 +0200 (CEST)
Received: by pwj8 with SMTP id 8so7820126pwj.38
	for <alsa-devel@alsa-project.org>; Mon, 26 Apr 2010 17:35:08 -0700 (PDT)
In-Reply-To: <4BD54623.3080808@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/4/26 Stefan Schoenleitner <dev.c0debabe@gmail.com>

> :
>
> In my tests I first used the "default" device which uses the PA plugin.
>
The test clearly showed that poll() returns with POLLIN even though far
>
less than avail_min frames are available for reading.
> Hence I suspect that there is a *bug* somewhere in the pulseaudio code
> (either the plugin or the daemon).
>
> In order to show that my code is working fine and the erroneous poll
> behavior does not occur when PA is not used, I also tested with the "hw"
> device.
> The result, as mentioned, it that the POLLIN event is correctly returned
> after at least avail_min frames are available.
>
> In short:
>
> * test with "default" uses PA: erroneus poll() behavior, BUG
> * test with "hw" does *not* use PA: everything works fine
>
>
http://0pointer.de/blog/projects/guide-to-sound-apis.html

Most likely , the PA developer will tell you

Do *not* touch buffering/period metrics unless you have specific latency
needs. Develop defensively, handling correctly the case when the backend
cannot fulfill your buffering metrics requests. Be aware that the buffering
metrics of the playback buffer only indirectly influence the overall latency
in many cases. i.e. setting the buffer size to a fixed value might actually
result in practical latencies that are much higher.

Do *not* assume that the time when a PCM stream can receive new data is
strictly dependant on the sampling and buffering parameters and the
resulting average throughput. Always make sure to supply new audio data to
the device when it asks for it by signalling "writability" on the fd. (And
similarly for capturing)



>
> > Do you mean that you suspect the problem is related to alsa-pulse plugin
> or
> > PA server ?
>
> Yes.
>
> cheers,
> Stefan
>
