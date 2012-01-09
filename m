From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: TWL4030 low-latency
Date: Mon, 09 Jan 2012 14:32:28 +0200
Message-ID: <4F0ADE5C.5040807@ti.com>
References: <B4E3E481-AEFC-4E2E-A5FA-A63908D8DE12@ccrma.Stanford.EDU>
	<CAPo=G1yzBxH3FL=Y5yqmR+REVawPV7eAdO5jmrxEJ6RRkndgxg@mail.gmail.com>
	<7C8103E9-A683-4FCA-9E55-9D81A3CA3439@ccrma.Stanford.EDU>
	<CAPo=G1zpT9wupMnpWBcxEu6iK9vr=EdrkKLMuHkpk7kyBCUMXw@mail.gmail.com>
	<loom.20120104T191613-550@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog115.obsmtp.com (na3sys009aog115.obsmtp.com
	[74.125.149.238])
	by alsa0.perex.cz (Postfix) with ESMTP id 0EF6924400
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2012 13:32:33 +0100 (CET)
Received: by mail-lpp01m010-f44.google.com with SMTP id h2so1270627laa.3
	for <alsa-devel@alsa-project.org>; Mon, 09 Jan 2012 04:32:20 -0800 (PST)
In-Reply-To: <loom.20120104T191613-550@post.gmane.org>
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

Hi Jacinto,

On 01/04/2012 08:35 PM, Jacinto Alvarez wrote:
> Hi Peter, is there like a set of steps/hints/source that you could share =
for =

> developers to experiment around these 'hacks' to the McBSP/sDMA? Is it a =
matter =

> of recompiling a particular kernel module or lib?.

Unfortunately I was not able to spend time on this :(

> I have verified Edgar's statements; I am not using Jack, just straight AL=
SA pcm =

> commands and I cannot get the stream to run at anything less than a 23 ms=
: 128 =

> frames x 8 periods. I can use longer size w/less periods but ALSA will al=
ways =

> throw an error if I try a combined lower latency.

Not sure what you mean under latency. For me the latency is the time
needed to play out the sample at the DMA pointer in main memory.
In case of McBSP2 (which has 1280 word long buffer) it is maximum of:
(1280/<number of channels>)/sampling frequency
In case of stereo sample it is 14.51ms with 44.1KHz, and 13.3ms with 48KHz.

There's not that much we can do to reduce this.
The alsa buffer size need to be at least 1280/<number of channels> to
avoid error at stream start.

In McBSP element mode the McBSP FIFO will be kept full all the time
(threshold is 0). This means that the McBSP will request one word from
the DMA if there's a single free slot in the FIFO.

If you switch to threshold mode things will be different under the hood
(providing better power saving):
the McBSP threshold value will be calculated according to the period
size. In this mode the DMA will request for a chunk of data based on the
threshold value, so the FIFO will be filled with DMA bursts. You still
have the FIFO caused latency, but the system can rest between bursts.
I think if you use McBSP threshold mode with 3x 5ms periods you should
be fine (the ALSA buffer is going to be 15ms).
The only thing you need to make sure is that before you start the
playback you need to fill up the 15ms ALSA buffer. At the start of the
playback you most likely see that 2 period will elapse, and pretty soon
the third will also. From this point the time between periods will
settle, and will keep the 5ms distance.

I hope this helps.

-- =

P=E9ter
