From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: [patch 3/3] t5325: add audio support
Date: Wed, 13 Oct 2010 20:25:12 +0200
Message-ID: <87ocayvtkn.fsf@lechat.rtp-net.org>
References: <20101012094453.660938870@rtp-net.org>
	<20101012100039.492443712@rtp-net.org>
	<20101012171845.GI30933@rakim.wolfsonmicro.main>
	<87wrpmvunr.fsf@lechat.rtp-net.org>
	<20101013180607.GA15001@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lechat.rtp-net.org (lechat.rtp-net.org [88.191.19.38])
	by alsa0.perex.cz (Postfix) with ESMTP id EFD151039C7
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Oct 2010 20:25:10 +0200 (CEST)
In-Reply-To: <20101013180607.GA15001@sirena.org.uk> (Mark Brown's message of
	"Wed\, 13 Oct 2010 19\:06\:08 +0100")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Saeed Bishara <saeed@marvell.com>, Martin Michlmayr <tbm@cyrius.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> On Wed, Oct 13, 2010 at 08:01:44PM +0200, Arnaud Patard wrote:
>> Mark Brown <broonie@opensource.wolfsonmicro.com> writes:
>
>> > On Tue, Oct 12, 2010 at 11:44:56AM +0200, Arnaud Patard wrote:
>> >> This patch declares the i2c audio codec and initialise audio.
>
>> > Looks like the changelogs for this and the previous patch got
>> > transposed
>
>> It's bad wording then. For me the changelog is fine. It means that :
>
>> - it's adding the alc5621 codec in the i2c bard info
>> - initialise kirkwood audio stuff by calling kirkwood_audio_init().
>
>> Maybe putting the explanations above would be better ?
>
> Oh, actually the problem is that you've not prefixed the ASoC patches
> with ASoC: so they look like they're supposed to be arch/arm patches
> (2/3 being the main offender).

Oh, I see. This patch is modify arch/arm/mach-kirkwood/t5325-setup.c and
is adding only audio stuff and needs a header coming from previous
patches. That's why I've put it in the patch serie. imho doing like this
should make life easier for everyone.

Will add and "ASoC:" in the patch subject.

Thanks,
Arnaud
