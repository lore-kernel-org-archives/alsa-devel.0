From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [patch 1/2] alsa: ASoC driver for s6000
	I2S	interface
Date: Fri, 27 Mar 2009 16:56:16 +0000
Message-ID: <20090327165616.GA9314@sirena.org.uk>
References: <1238074574-24734-1-git-send-email-dg@emlix.com>
	<20090326141503.GD3771@sirena.org.uk> <49CCFA24.3020203@emlix.com>
	<20090327162048.GA7542@sirena.org.uk> <49CD039D.8070302@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3DBC51037EB
	for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2009 17:56:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <49CD039D.8070302@emlix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel =?iso-8859-1?Q?Gl=F6ckner?= <dg@emlix.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 27, 2009 at 05:49:33PM +0100, Daniel Gl=F6ckner wrote:

> s6000_i2s_start and s6000_i2s_stop are called in s6000_pcm_trigger and
> s6000_i2s_int_sources is called in the interrupt handler.

> s6000_i2s_start can't be called from the dai's trigger callback on playba=
ck as
> the data sheet is very explicit about the order of enabling dma and i2s.

> s6000_i2s_stop is called there for consistency. The order on disabling is
> uncritical.

Are these two drivers really separate?  The reason for splitting out the
DMA driver in the normal case is that it is common for CPUs to be able
to use the same DMA driver for multiple interfaces - if that's not the
case then don't feel obligated to split them up too much.

Also note that you can pass data from the I2S driver to the PCM driver
via the dma_data pointer - if you need to pass a little vtable through
there then that's another option.
