From: Daniel Mack <daniel@caiaq.de>
Subject: Digital distortion when converting Mono to Stereo?
Date: Thu, 29 Oct 2009 02:01:18 +0100
Message-ID: <20091029010117.GO29442@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 977732444A
	for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2009 02:01:29 +0100 (CET)
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
Cc: Tim Ruetz <tim@caiaq.de>
List-Id: alsa-devel@alsa-project.org

While testing with our ASoC enabled embedded platform, we observed a
strange phenomena with Mono audio files. We used external audio test
equipment for SNR/THD analysis and used a mono wav file (16bit, 44.1
KHz) which plays a simple sweep from ~10Hz to ~20KHz.

As the hardware output is Stereo, an implicit conversion takes places
(don't know which part of ALSA actually does it, though).

Strangely, the measurement showed a phantom frequency which looks like
the sweeping test signal frequency was somehow 'mirrored' at 11.025KHz
(fs/4). This phantom noise becomes stronger the lower its frequency
gets. So while sweeping, those two peaks were approaching each other,
they met at 11KHz, and when the 'real' peak aproached 20KHz, the
phantom was at something like 1KHz and had comparable level than the
'real' signal. All that was much stronger on one channel and barely
there, but still measurable, on the other one.

We first though about an analog filter issue, then suspected the digital
input stream, but eventually it turned out that with the same test
file in stereo, all these effects suddenly went away. So there must be
something in the chain from aplay to the actual PXA SSP ports which adds
considerable digital distortion to one channel when converting from Mono
to Stereo.

I didn't dig any deeper, but still wanted to let you know. Can anyone
think of a possible reason for that? It doesn't harm us in our
application as we will never play Mono audio eventually, but I guess
it could affect others.

Thanks,
Daniel
