From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 3.2
Date: Thu, 22 Dec 2011 12:02:47 +0000
Message-ID: <20111222120246.GM4546@opensource.wolfsonmicro.com>
References: <20111222110408.GA8479@opensource.wolfsonmicro.com>
	<CAAQ0ZWSoQJJZv9ReBvHC1FB2EeS_u2V=jDJOguoqNx2cR+1i_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4712924502
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 13:02:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAAQ0ZWSoQJJZv9ReBvHC1FB2EeS_u2V=jDJOguoqNx2cR+1i_g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 22, 2011 at 07:21:44PM +0800, Shawn Guo wrote:
> On 22 December 2011 19:04, Mark Brown

> > Shawn Guo (1):
> > =A0 =A0 =A0ASoC: mxs: correct 'direction' of device_prep_dma_cyclic

> If I remember correctly, the API change only sits on -next.  You may
> not want to push this patch for 3.2, I guess?

Oh, ffs.  git describe shows the change as being based off 3.1 so it
would be expected to appear in the 3.2 merge window but looking at
Linus' tree it doesn't seem to be there.  I'll revert the change.

If the API change is only in -next this shouldn't have been applied to
the ASoC tree at all.  This needs go along with the change that adds the
new API otherwise you break bisection.  Things like this *really* need
to be made clear when posting patches.  I'll revert the change, you
should get anyone else who's applied these changes to do so as well.
