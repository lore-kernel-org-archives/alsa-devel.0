From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/6] Fixups to MPC5200 ASoC drivers
Date: Sat, 7 Nov 2009 12:57:13 +0000
Message-ID: <20091107125713.GF3228@sirena.org.uk>
References: <20091107081631.18908.82921.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 615DC1037F2
	for <alsa-devel@alsa-project.org>; Sat,  7 Nov 2009 13:57:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091107081631.18908.82921.stgit@angua>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 07, 2009 at 01:33:40AM -0700, Grant Likely wrote:

> However, I was able to reproduce the noise problem when using aplay
> if I have DEBUG #defined at the top of the mpc5200_dma.c file with
> debug console logs being spit out the serial port.  In that situation,
> the STOP trigger calls printk(), and a stale sample can be heard at
> the end of playback.  However, I believe this is a bug with the serial
> console driver (in that it disables IRQs for a long time) causing
> unbounded latencies, so the trigger doesn't get processed fast enough.

Yes, that will always be a problem with free running DMA - if it's not
shut down quickly enough then it'll just keep processing data.  Serial
ports don't tend to play well with instrumenting it, sadly.

> So, please test.  Let me know if these work or not.  I've don't know
> if the last patch (Add fudge factor...) is needed or not.

I've applied patches 1-5 since they seem fairly clear code cleanups and 
fixes.  If they've introduced any problems we can fix them incrementally.
I'll wait to see what the outcome of testing is for patch 6.  

As I mentioned on IRC testing with PulseAudio would be good for this -
it makes more demands on the quality of the DMA implementation than most
applications.
