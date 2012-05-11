From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: ALSA calling pcm_pointer excessively?
Date: Fri, 11 May 2012 16:04:50 +0100
Message-ID: <20120511150450.GB16214@n2100.arm.linux.org.uk>
References: <20120510160601.GC12727@n2100.arm.linux.org.uk>
	<20120510162930.GA17361@n2100.arm.linux.org.uk>
	<4FABF574.7090804@ladisch.de> <s5h62c2alpf.wl%tiwai@suse.de>
	<20120511140237.GB6220@n2100.arm.linux.org.uk>
	<s5hwr4i94z5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id A8555104720
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2012 17:05:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hwr4i94z5.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Fri, May 11, 2012 at 04:17:50PM +0200, Takashi Iwai wrote:
> Actually the call of snd_pcm_update_hw_ptr() at the loop entry doesn't
> have to be done at each time, supposing the process of the loop
> (without wait_for_avail()) is fast enough.
> 
> How about the patch below?

This too seems to work fine on playback.  Thanks.
