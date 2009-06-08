From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: pxa-ssp: enhance I2S and
	add	Left_J support
Date: Mon, 8 Jun 2009 13:40:46 +0100
Message-ID: <20090608124045.GE7858@sirena.org.uk>
References: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
	<20090606201225.GA1029@sirena.org.uk>
	<74d0deb30906080512q29b9915fvec9b068bf4b2e126@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0088F243B5
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 14:40:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <74d0deb30906080512q29b9915fvec9b068bf4b2e126@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pHilipp Zabel <philipp.zabel@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Daniel Ribeiro <drwyrm@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 08, 2009 at 02:12:03PM +0200, pHilipp Zabel wrote:
> On Sat, Jun 6, 2009 at 10:12 PM, Mark
> Brown<broonie@opensource.wolfsonmicro.com> wrote:

OOI which MUA are you using?  I've noticed several people with this very
odd word wrapping the past day.

> > of in tree users it'd cause little disruption. ?A set_sample_width()
> > operation could also be added.

> set_sample_width or set_frame_width?

I'm inclined to go with sample here since it seems harder for the
machine drivers to get wrong but I've not really thought it through yet?

> I'd prefer a separate operation over a parameter to set_tdm_slot because
> in my setup I just need to force the (SSP) frame width to 16 bits.
> Enabling network mode and calling set_tdm_slot(..,1,1) wouldn't be
> necessary at all, then.

OTOH I don't really see much difference between the two cases - it's
just an extra couple of parameters on the end of the call.  That said,
it'd be much nicer if the driver were able to just do the right thing
for DSP mode unless explicitly configured, there's not the issue you
have with I2S where extra clocks would change the offset of the second
channel within a stereo frame so it's much easier.
