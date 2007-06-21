From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: at91 SoC Modifications
Date: Thu, 21 Jun 2007 22:26:24 +0100
Message-ID: <1182461184.26658.201.camel@localhost.localdomain>
References: <61c0054e0706201421x3725f809g80822d32d78d216e@mail.gmail.com>
	<61c0054e0706210747gc83f1dx2a6ee8bc5cf346f9@mail.gmail.com>
	<61c0054e0706211210s40158268oea170946cf62a9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id A799F10384C
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jun 2007 23:26:25 +0200 (CEST)
In-Reply-To: <61c0054e0706211210s40158268oea170946cf62a9f@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Kavan <pkavan@gmail.com>
Cc: alsa-devel@alsa-project.org, Frank Mandarino <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2007-06-21 at 14:10 -0500, Paul Kavan wrote:

> The playback side of everything seems to work well for .raw files. I
> have some that I made with my old ssc polling driver. The sound fine
> using aplay with either the bare bones or the default alsa.conf file.
> However, I cannot use arecord at all. I am not sure why, but something
> is preventing the sync line from working during record. The sync line
> has a .3V,pp square that rides around 3V DC. The frequency is that of
> the bit clock ~256.4K. Now, when I playback a sample, the RF0 and RD0
> look like they should. 
> 
> I have RF0 and TF0 tied together and assume TF0 generates the sync.
> Also, I have TK0 and RK0 tied together and assume TK0 generates the
> clock. Could this be the problem.
> 

Best not to assume here, check the Atmel datasheet wrt SSC clocking.

> Oh...and playback with PCM A (DSP_A) works fine, but no recording
> still. I get the same type of signal on RF0 as before with PCM A fmt.
> Does anyone have a sense if this is a ssc configuration problem or an
> alsa problem? 

It's probably not an alsa problem as playback works.  If your SSC
register settings for capture look correct then I'd check the hardware
again. 

Liam
