From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 0/4] FIFO caused playback delay
	(latency)	handling in soc
Date: Tue, 2 Mar 2010 13:53:01 +0000
Message-ID: <20100302135301.GG10658@sirena.org.uk>
References: <1267537191-25254-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1552C103908
	for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2010 14:53:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1267537191-25254-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 02, 2010 at 03:39:47PM +0200, Peter Ujfalusi wrote:

> There has been discussion in alsa-devel in this subject several times,
> but no actual patches has been sent.

Well, it's never really been discussed in an ASoC context - most of the
interest has been on the PC audio side.  This is the first interest in
it from the embedded side.

This is pretty much what I would have implemented, aside from the
playback/capture thing I mentioned the only other thing that I'd suggest
is also adding a callback for the platform driver.  Many CPUs actually
introduce the latency in the DMA stream rather than in the interface,
for example by filling up a SRAM buffer as DaVinci currently does, and
it's more natural for them to keep track of the latency introduced in
the code that's managing the DMA.  For devices where the buffer is on
the interface the DAI makes sense.
