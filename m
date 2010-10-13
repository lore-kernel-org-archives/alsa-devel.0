From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: [patch 3/3] t5325: add audio support
Date: Wed, 13 Oct 2010 20:01:44 +0200
Message-ID: <87wrpmvunr.fsf@lechat.rtp-net.org>
References: <20101012094453.660938870@rtp-net.org>
	<20101012100039.492443712@rtp-net.org>
	<20101012171845.GI30933@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lechat.rtp-net.org (lechat.rtp-net.org [88.191.19.38])
	by alsa0.perex.cz (Postfix) with ESMTP id C4B69103849
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Oct 2010 20:01:42 +0200 (CEST)
In-Reply-To: <20101012171845.GI30933@rakim.wolfsonmicro.main> (Mark Brown's
	message of "Tue\, 12 Oct 2010 18\:18\:46 +0100")
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
Cc: alsa-devel@alsa-project.org, Saeed Bishara <saeed@marvell.com>, Martin Michlmayr <tbm@cyrius.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> On Tue, Oct 12, 2010 at 11:44:56AM +0200, Arnaud Patard wrote:
>> This patch declares the i2c audio codec and initialise audio.
>> 
>
> Looks like the changelogs for this and the previous patch got
> transposed

It's bad wording then. For me the changelog is fine. It means that :

- it's adding the alc5621 codec in the i2c bard info
- initialise kirkwood audio stuff by calling kirkwood_audio_init().

Maybe putting the explanations above would be better ?

Thanks,
Arnaud
