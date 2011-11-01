From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] asoc: tegra: wm8903: Simplify pin
	disconnect
Date: Tue, 1 Nov 2011 18:09:57 +0000
Message-ID: <20111101180957.GF10029@opensource.wolfsonmicro.com>
References: <1320164771-457-1-git-send-email-thutt@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2A492244C6
	for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2011 19:10:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1320164771-457-1-git-send-email-thutt@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Taylor Hutt <thutt@chromium.org>
Cc: alsa-devel@alsa-project.org, swarren@nvidia.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 01, 2011 at 09:26:11AM -0700, Taylor Hutt wrote:

> (Note that this patch fails the kernel patch checker because
>  the 'M' macro produces an error that it's value should be enclosed
>  in parenthesis; this is not actually possible for this use & expansion.)

So, this whole patch doesn't look like a Linux patch in either the code
itself or the way it's presented.  I remember having similar problems
before with patches you've submitted but this is even further off the
mark than previously.  I did start replying in detail but there's so
many really basic issues from the coding and patch submission style
level up that it was taking too long.

In general whenever you're modifying code (kernel or otherwise) if what
you're doing doesn't visually resemble the rest of the system there's
probably a problem.
