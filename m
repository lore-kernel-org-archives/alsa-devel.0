From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: TWL4030 low-latency
Date: Tue, 14 Feb 2012 09:46:15 +0200
Message-ID: <4F3A1147.4070209@ti.com>
References: <B4E3E481-AEFC-4E2E-A5FA-A63908D8DE12@ccrma.Stanford.EDU>
	<CAPo=G1yzBxH3FL=Y5yqmR+REVawPV7eAdO5jmrxEJ6RRkndgxg@mail.gmail.com>
	<7C8103E9-A683-4FCA-9E55-9D81A3CA3439@ccrma.Stanford.EDU>
	<CAPo=G1zpT9wupMnpWBcxEu6iK9vr=EdrkKLMuHkpk7kyBCUMXw@mail.gmail.com>
	<loom.20120104T191613-550@post.gmane.org> <4F0ADE5C.5040807@ti.com>
	<CA+fpFZ9-QQ=5uihMfjCQaJBMYeq3QBHMgmYAW3DBQHQTAwK1gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog106.obsmtp.com (na3sys009aob106.obsmtp.com
	[74.125.149.76])
	by alsa0.perex.cz (Postfix) with ESMTP id C991A103D4A
	for <alsa-devel@alsa-project.org>; Tue, 14 Feb 2012 08:46:14 +0100 (CET)
Received: by lagu2 with SMTP id u2so6686078lag.33
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2012 23:46:11 -0800 (PST)
In-Reply-To: <CA+fpFZ9-QQ=5uihMfjCQaJBMYeq3QBHMgmYAW3DBQHQTAwK1gw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jacinto Alvarez <fidorul@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 01/12/2012 02:09 AM, Jacinto Alvarez wrote:
> Hi Peter,
> =

> Thanks for your reply.
> =

>     Not sure what you mean under latency. For me the latency is the time
>     needed to play out the sample at the DMA pointer in main memory.
>     In case of McBSP2 (which has 1280 word long buffer) it is maximum of:
>     (1280/<number of channels>)/sampling frequency
>     In case of stereo sample it is 14.51ms with 44.1KHz, and 13.3ms with
>     48KHz.
> =

> =

> With latency I refer to the round-trip of the combined capture-playback
> operation. The application I am using creates a couple of input/output
> streams and bounds them together with snd_pcm_link(). The shortest time
> I can get for this round-trip is 1024 frames (~23 ms) and I get that by
> initializing the streams with 8 periods of 128 frames each.
>  =

> =

>     In McBSP element mode the McBSP FIFO will be kept full all the time
>     (threshold is 0). This means that the McBSP will request one word from
>     the DMA if there's a single free slot in the FIFO.
> =

>     If you switch to threshold mode things will be different under the ho=
od
>     (providing better power saving):
>     the McBSP threshold value will be calculated according to the period
>     size. In this mode the DMA will request for a chunk of data based on =
the
>     threshold value, so the FIFO will be filled with DMA bursts. You still
>     have the FIFO caused latency, but the system can rest between bursts.
>     I think if you use McBSP threshold mode with 3x 5ms periods you should
>     be fine (the ALSA buffer is going to be 15ms).
> =

> =

> Is this threshold mode set by the application with the
> snd_pcm_sw_params_set_start_threshold() command (e.g., passing a
> non-zero parameter) or are you talking of some tweak INSIDE the driver's
> code?

It is McBSP driver specific. we do not have (yet) ALSA level control for
it. The best fit would be some type of QoS, but I'm not sure of it.

> Currently the application is initializing the streams with
> snd_pcm_sw_params_set_start_threshold() and a value equal to the period
> size (128 frames).

Lets' try this (assuming you are using McBSP2):
echo threshold > /sys/devices/platform/omap/omap-mcbsp.2/dma_op_mode

Do you see difference in the round-trip?

-- =

P=E9ter
