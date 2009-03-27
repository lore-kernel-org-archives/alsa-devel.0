From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: xrun on sdp340 with small buffers
Date: Fri, 27 Mar 2009 08:56:13 +0200
Message-ID: <20090327085613.dc719780.jarkko.nikula@nokia.com>
References: <2C7D3DF36ADFFC479B44490D912B616705ED076A6E@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 6DA6C10388F
	for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2009 07:56:27 +0100 (CET)
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705ED076A6E@dlee07.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ext Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 27 Mar 2009 05:02:29 +0100
"ext Lopez Cruz, Misael" <x0052729@ti.com> wrote:

> I use the sdp3430 machine driver for my board, which connects twl4030
> codec and OMAP McBSP/DMA drivers. Everything works fine, I can play
> audio files (using aplay).
> 
> However, I tried to force 'aplay' to use a different buffer size and
> period count, and it misbehaves. My experiment was setting buffer time
> to 10ms and periods to 4, and play a 8kHz sample file; this only
> generates underrun messages. Under that configuration, for 8kHz, it
> means a buffer size of 320B (16-bits, stereo) divided into 4 periods
> of 80B each. omap-pcm driver will report interrupts each 80B, as it
> uses a single DMA transfer for the buffer and generates interrupts
> each frame.
> 
Am I right that SDP3430 is using McBSP2 for audio codec? We had similar
issues sometime ago and I obviously forgot to report it here... grr.

But shortly:

McBSP2 in OMAP3 has 1 ksample (1k x 32 bit) internal FIFO. During
initial playback startup, this FIFO is keeping the DMA request active
until the FIFO is full.

So now if ALSA buffer size is smaller, DMA is looping around it while
filling up the HW FIFO, generating burst of interrupts as well and SW
doesn't have any change to fill enough data.

Hmm. We better to have a patch setting constraint for minimum buffer
size in case McBSP2 in OMAP3.


-- 
Jarkko
